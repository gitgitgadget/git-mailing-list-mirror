From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Wed, 13 Jun 2012 16:55:41 +0200
Message-ID: <CAMP44s1SOOBHRD7=u78S0dyRMdY0Q=zzkULxoz72ZzBaGC8Fyg@mail.gmail.com>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
	<CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
	<7vbokwmifp.fsf@alter.siamese.dyndns.org>
	<CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
	<7vmx4baaqc.fsf@alter.siamese.dyndns.org>
	<CAMP44s2US+PoxfboZSML84GEvUwiHV4eQBOQSp6zhruT8xrKdg@mail.gmail.com>
	<7v7gvdaogr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 16:55:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seoz8-0002WU-Gj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 16:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab2FMOzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 10:55:44 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34409 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754428Ab2FMOzm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 10:55:42 -0400
Received: by lahd3 with SMTP id d3so490743lah.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qM3CVSLEVDPccwSIrQv61+AklJtGTgtTgZUIEC5iz24=;
        b=A9/wZtVrOSD/6TJEHRUwN8Py1QoCS3tDxe0qRb3L3xS+IIqO7cpKfLqtYXajvRwJiz
         O72v2pyC141kgQIBMnMmYufikJ7wli43Vs3ohsJaguh+s5h5WwmcNMDTcYCLcGPVB9eW
         35rxLn1zU5tsHbQTTBdG+XjtnfERTosnhKnmQ2M4KmayUUPZhWcPevXlExkN2sQTvLNW
         HiSbDuF2MFf4VagFTCuPXkHF8aihIWcgyX5psckv5QgKtI4KC4LQx2ABt8dX5VRsFbvV
         24i030qrCAVFqzHmZjUgkQ1szDEsx13l03JfVULa+zLnTIbMvcoY3OxToJw9aylBRidZ
         fbjw==
Received: by 10.152.123.244 with SMTP id md20mr24976863lab.0.1339599341193;
 Wed, 13 Jun 2012 07:55:41 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 13 Jun 2012 07:55:41 -0700 (PDT)
In-Reply-To: <7v7gvdaogr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199893>

On Mon, Jun 11, 2012 at 4:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> You say I'm being irresponsible, I say you are being preoccupied by a
>> theoretical problem that will not occur, and would not cause any
>> problems if it does.
>
> See how the two implementations are different

They are not.

http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/completion/git-completion.bash;h=13690eaecb4d8fafa67b79d33e804e6f8c64d742;hb=refs/heads/pu#l37

http://git.kernel.org/?p=git/git.git;a=blob;f=contrib/completion/git-prompt.sh;h=29b1ec9eb1797e0f2c3c9f7067222432150ba85f;hb=refs/heads/pu#l54

Where is the difference?

> and think what happens
> when a user dot sources these two scripts in different order. Callers
> of __gitdir in one expects it to pay attention to GIT_DIR, callers in
> the other don't, but you can't have both at the same time in the
> same shell, can you?

So, what you are saying is that we would end up with the "wrong" __gitdir()?

But that "wrong" version is the one that everybody has been using both
for completion and prompt since 2006, and *nobody* has complained
(except SZEDER, recently).

So, as user, how would having this ancient __gitdir() would affect me?
What is this "huge" issue that we want to avoid at all costs?

> It is not theoretical, as you yourself already made it happen.

Nope. I haven't.

Even if I did, what are the *effects*?

> Get over it.

Indeed, please do.

Cheers.

-- 
Felipe Contreras
