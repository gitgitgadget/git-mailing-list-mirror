From: Michael Witten <mfwitten@gmail.com>
Subject: Re: GIT commit strategy
Date: Tue, 16 Aug 2011 16:46:46 +0000
Message-ID: <CAMOZ1Bvy2+8UdBuxRM03=Ynh6NpD-o_TVNoFG1M3+t993BikyA@mail.gmail.com>
References: <C0B80A98F4E14FA287D3BAFA8366BEAC@procyon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Vadim K." <klug@hot.ee>
X-From: git-owner@vger.kernel.org Tue Aug 16 18:47:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtMnR-0002A4-KL
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 18:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab1HPQrR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Aug 2011 12:47:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48457 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580Ab1HPQrQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2011 12:47:16 -0400
Received: by ywf7 with SMTP id 7so74159ywf.19
        for <git@vger.kernel.org>; Tue, 16 Aug 2011 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=atz3j/gxEwSd6FXZTPzLIC9k5zGtNGLIegZCjrNr+UU=;
        b=Kbwwe/k6LxrrPFoBJW8N/I6NFglaoW6E03s2KJaOdwd2//09OiHgonZnWKMLEHkdut
         4QHOf/qbPTDg7lQrIE68qkyS+ADaeYM3SvXMc9MhPiO1mZpZoSm8hZopnQzlxVrAHcBV
         uRsbKrqpBUT2HofbROMU7ytqyvROk5SwB8f2Y=
Received: by 10.43.52.1 with SMTP id vk1mr5579802icb.129.1313513236050; Tue,
 16 Aug 2011 09:47:16 -0700 (PDT)
Received: by 10.42.174.66 with HTTP; Tue, 16 Aug 2011 09:46:46 -0700 (PDT)
In-Reply-To: <C0B80A98F4E14FA287D3BAFA8366BEAC@procyon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179459>

2011/8/16 Vadim K. <klug@hot.ee>:
> Hello all,
>
> =C2=A0 Imagine developer A has changed files f1 and f2, then made com=
mit and push
> to the server
> =C2=A0 Developer B has changed files f2 and f3 and made local commit.
>
> =C2=A0 Next B wants to publish changes to the server and make pull to=
 resolve
> conflicts at f2. =C2=A0After pulling from the server it has all 3 fil=
es - f1, f2
> and f3 to commit before push. But B did not changed f1 and actually c=
an
> "ban" this change if he commits only f2 and f3 - files that were chan=
ged by
> him. In latter case after pushing to the server GIT will restore prev=
ious
> version of the f1, even if it has more recent one !! It does not seem=
 to be
> very logical.
>
> =C2=A0 Question: is it possible to show to the developer only files, =
that he
> changes? Like in SVN - after updating from the server developer must =
resolve
> conflicts (if any) and only commits changes that he has made. By the =
way -
> in a case of non-conflicting files (let me say A changes f1, B change=
s f2)
> GIT makes commit automatically and does not show to the B, that f1 wa=
s
> changed and need to be re-commited. B only need to push the change ba=
ck.

It is difficult to understand exactly what you have written here, but
I feel that git already does what you want, so I don't understand why
you are confused.

Please provide a concrete example (with git commands, expected
results, actual results, etc.) so that we can understand each other.
