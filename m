From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sat, 26 Feb 2011 23:09:14 +0200
Message-ID: <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
	<20110213193738.GA26868@elie>
	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
	<20110214231920.GA24814@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 22:09:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtROD-0007Ff-Al
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 22:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab1BZVJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Feb 2011 16:09:16 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33875 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1BZVJQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Feb 2011 16:09:16 -0500
Received: by bwz15 with SMTP id 15so2809088bwz.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lm6XxmNtxXbqr/HFpJ5hVxlvRtgnBaDo58jf7ETDxwQ=;
        b=oLwXzMYjaOpQnAKt2yd81J2o/hpj/2NtxYYQqEQdVSAfWo9F4pkNbl3jvQV9sPWz3z
         GspNNvSpFFJ184uVV8UY4DpSI9zXxfyhT1K+h6KuQmUY325KDH5fGC0ql9WUi1V/kT1K
         CQFgwfcaCLXl2ovLbBCDu11kcr3ll8LOxCbk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a5sDZJsFvxjD56Q4al2UxjIa54W2rthlXwBpumYR9TLNuED32DlW5HHdf82ZyBJ3ss
         90AQdQ4PdIAfVMeLp2ao2hj63aHIQovSHXEn8Soo/o90AomNjCXXMUhiakg2h/vfj3n7
         767yPIu0LtMKFXt9q6zRc+z8smSTpiP/ysvRw=
Received: by 10.204.56.194 with SMTP id z2mr3333272bkg.81.1298754554216; Sat,
 26 Feb 2011 13:09:14 -0800 (PST)
Received: by 10.204.67.141 with HTTP; Sat, 26 Feb 2011 13:09:14 -0800 (PST)
In-Reply-To: <20110214231920.GA24814@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167994>

On Tue, Feb 15, 2011 at 1:19 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> When people talk about the staging area I tend to get confused. =C2=A0=
I
> think there's an idea that because it sounds more concrete, there is
> less to explain --- or maybe I am just wired the wrong way.

I don't like the phrase "staging area". A "stage" already has an area.
You put things on the stage. Sometimes there are multiple stages.

> There is a .git/index file, with a well defined file format. =C2=A0An=
d
> there is an in-core copy of the index, too. =C2=A0It contains:
>
> =C2=A0- mode and blob name for paths as requested by the user with
> =C2=A0 "git add"

A commit stage.

> =C2=A0- competing versions for paths whose proposed content is
> =C2=A0 uncertain during a merge

Multiple commit stages.

> =C2=A0- stat(2) information to speed up comparison with the worktree

If only a subset of the files are there, it's an 'index', if not, then
I'd say it's a 'registry'. Anyway, it's something the user shouldn't
care about.

Cheers.

--=20
=46elipe Contreras
