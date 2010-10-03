From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 09/15] t5602 (clone-remote-exec): add missing &&
Date: Sat, 2 Oct 2010 21:08:58 -0600
Message-ID: <AANLkTim5QE8Ze8BQd+dES86FxPx9nJNObU1d7YLF29xN@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-10-git-send-email-newren@gmail.com>
	<7vzkv0mkn5.fsf@alter.siamese.dyndns.org>
	<20101001113412.GH6816@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 05:10:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Exz-00036s-0l
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 05:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619Ab0JCDJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Oct 2010 23:09:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63374 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab0JCDI7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Oct 2010 23:08:59 -0400
Received: by fxm14 with SMTP id 14so1244300fxm.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 20:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6VX+maPByyFpK9XKdfxxs10+DKaki8UxegPJhmxaUEI=;
        b=WuycWFwzsgGy7aPUOT0ERUYwTOPxi3H2JCOG5/bx2ujVjdnlmi1E58n2bcc6qRjZkU
         8xr0ZkAWLS7b70gx60gdmChod0DCdZejsqsWbnfEUZvDZ0xu+HuduynGQFz+keZUIogw
         oTRbCWwyM+6qhl48uY265hp5YxJbkEXaLrtvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bW8wOaaL89V89oJ9ZvM5YAZ/Y1IqSuSK85jGTUhgOy4ux8EdZ89UHqiHfreAZI9xrU
         8gqP04SZdThttYcM+/lLKUTl62uebil49zFoV8nX0OkyfP0y+p/mVF03ZsfnH71ILu/k
         RlDVufPtQxz98Jn898+aCzKTRwh+x2/2DBBds=
Received: by 10.223.112.11 with SMTP id u11mr7457866fap.2.1286075338649; Sat,
 02 Oct 2010 20:08:58 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sat, 2 Oct 2010 20:08:58 -0700 (PDT)
In-Reply-To: <20101001113412.GH6816@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157818>

On Fri, Oct 1, 2010 at 5:34 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Junio C Hamano wrote:
>> Elijah Newren <newren@gmail.com> writes:
>
>>> + =C2=A0 =C2=A0GIT_SSH=3D./not_ssh test_must_fail git clone localho=
st:/path/to/repo junk &&
>>
>> I think this suffers from the same issue that have been fixed with 0=
9b78bc
>> (t7502-commit.sh: rearrange test to make more portable, 2008-07-22) =
and
>> 2d60615 (tests: Avoid single-shot environment export for shell funct=
ion
>> invocation, 2009-01-26).
>
> Here's a patch for squashing.
>
> Thanks again.

Thanks for all the reviews and help.  Sorry I've been so slow to
respond; it's been a busy week.
