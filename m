From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Mon, 30 Nov 2009 15:02:51 -0500
Message-ID: <32541b130911301202j2b551d80v650d252b7934eb98@mail.gmail.com>
References: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> 
	<905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com> 
	<cover.1259201377.git.apenwarr@gmail.com> <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com> 
	<7vr5rlerqf.fsf@alter.siamese.dyndns.org> <32541b130911261405q6564d8f2o30b7d7fd6f708d05@mail.gmail.com> 
	<7vvdgs1qip.fsf@alter.siamese.dyndns.org> <32541b130911301008v4156f0c6ge9f30952565392f9@mail.gmail.com> 
	<7viqcrlrb8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 21:03:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFCSw-0004Nm-63
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 21:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbZK3UDH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 15:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbZK3UDH
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 15:03:07 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:41785 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbZK3UDG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 15:03:06 -0500
Received: by pzk1 with SMTP id 1so2960811pzk.33
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 12:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/oTJHlHMBcwyXjqj/H7eXJpicCHdlBPF821JS6seK2A=;
        b=p5MMPBOcWAFHNp7Vd+Af+sKkQ7xRc/5yiSrQOblKzwoHDtBhL/0Wsi8DTAaBJ+ZUgm
         rJZafzTYqDvxiZzcNVosZGnNaQEv5BLnEjwcb+iZVI36tQ8QbWT3QTd0UFhvscr7Igg7
         RzgK0mgOaD2Jd3aW2iCmdlcxR5Ci7rz+BgK+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aLCgZEV1TMjNt87CyF2km5z9C4hm0hzkukbEm9qB42dw0swrIajN09jtscnEFBsFYi
         teA50GVRrcT0Shsh+eLoIfvjbNnJpwh1sliKQiXL7mnDKlMtoTlGg/T1LfCeyhQpxuwp
         hnhqivdOJNdhlx1QJ8jrMMfgvurN/fHj0V240=
Received: by 10.140.185.18 with SMTP id i18mr327885rvf.87.1259611391073; Mon, 
	30 Nov 2009 12:03:11 -0800 (PST)
In-Reply-To: <7viqcrlrb8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134135>

On Mon, Nov 30, 2009 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Avery Pennarun <apenwarr@gmail.com> writes:
>>> I've queued the series with minor fixes to 'pu' and pushed it out.
>>
>> Since I see you didn't change a couple of things you mentioned in
>> earlier comments (the NEEDSWORK comment and the sq-then-eval trick) =
do
>> you still want me to respin this series?
>
> The commit still is NEEDSWORK and shouldn't be in 'next' in its curre=
nt
> shape. =A0I don't think the topic is 1.6.6 material yet, and we will =
be in
> pre-release feature freeze any minute now, so there is no urgency.
>
> As I did the sq-then-eval in many places in our Porcelain scripts (an=
d
> many of them are converted to C and lost the need for the trick), I m=
ay
> get tempted to fix it up when I am bored ;-). =A0But no promises.

I'll interpret that as "no, I should not respin the series because
Junio plans to deal with it" :)

Do let me know if there's anything I should do to help this advance
from pu->next sooner (if they delay is not simply because of the code
freeze).

Have fun,

Avery
