From: James Pickens <jepicken@gmail.com>
Subject: Re: Bug? Bad permissions in $PATH breaks Git aliases
Date: Tue, 27 Mar 2012 10:48:31 -0700
Message-ID: <CAJMEqRDodYQa_4vZ0+BZYS1+zL3e1iFXAMPgONbg8miEEs9wJQ@mail.gmail.com>
References: <CAJMEqRBmuBJuUmeoAU-_xf=s10ybD9pXhUJT+fn8aHNE2WJz6A@mail.gmail.com>
 <4F715ABD.4080102@viscovery.net> <CAJMEqRAQZwaeMNai9wckmPE2mRVVpttzEobZrsn29fMAo+LRRQ@mail.gmail.com>
 <7v7gy6krei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:49:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCaVu-00037A-RB
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab2C0Rsx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 13:48:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49804 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2C0Rsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 13:48:53 -0400
Received: by wgbdr13 with SMTP id dr13so168206wgb.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vtQuqIVCdQzVUeO4kofWYuzr5HiLOM+bpEdCA4MTWZo=;
        b=V3CNXtwf1hroSSkgfLe41aTBI8vz8AB9UT+sjLXg2hdT7oSIFnB9XL5ufdu0xmFK11
         J3qmvL7Swmd54g3xkHaiWFQYDZzbLP05uauG9YU5SL/vbmUywKHIplfHZFZzDKhSpMqB
         73th0NSIcIM7JqgzCAoHsf89IkRRfRfarQIAAFPs4M561/SkGSTnrLpG4uJC8pliFLSH
         X6+NoJXL+AWDuLDRc//mW/sfqWs60d9e86oCLtKIsgqHx4gpwq5R0plkgt7VRWCQLRDU
         ivQOFd6QaMMTZ61QKcw8isZq0Zki4I99ZGUUS0TwNEyEZO/a3y5FV3SrOGDS6cf8S8Lc
         2itg==
Received: by 10.180.104.230 with SMTP id gh6mr29358591wib.22.1332870531920;
 Tue, 27 Mar 2012 10:48:51 -0700 (PDT)
Received: by 10.223.154.205 with HTTP; Tue, 27 Mar 2012 10:48:31 -0700 (PDT)
In-Reply-To: <7v7gy6krei.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194063>

On Tue, Mar 27, 2012 at 8:14 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> James Pickens <jepicken@gmail.com> writes:
>> I'm not claiming that it's sane to have a broken PATH, but as I
>> mentioned in an earlier email, sometimes my PATH gets broken through
>> no fault of my own, and it would be nice if Git could be more helpfu=
l
>> in that case.
>
> Hrm, so which was more helpful in diagnosing the broken PATH? =C2=A0G=
it by
> letting you be aware that there is some problem, or your shell by kee=
ping
> me oblivious of the issue?

In this case the broken parts of my PATH were completely uninteresting
to me - they didn't contain any executables that I would ever use.  So
if it didn't break my Git aliases, I could have continued working with
the broken PATH and never known or cared that it was broken.

But I get your point - sometimes it's more helpful to let the user
know something is amiss than try to guess what was intended.  I just
don't think this is one of those cases, mainly because Git's behavior
is inconsistent with other programs.  Git's behavior is not even
consistent with itself - IMO, a PATH containing a directory that
doesn't exist is just as broken as a PATH containing an inaccessible
directory, but Git only has a problem with the latter.  That doesn't
make sense to me.

James
