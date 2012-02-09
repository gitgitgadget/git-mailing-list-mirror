From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: Merging tags does not fast-forward with git 1.7.9
Date: Thu, 9 Feb 2012 10:50:50 -0500
Message-ID: <CAPBPrntqaFk7YNf7Rz5aVNOMQVTAFaQcJoPFtsOn6rk8n2Q_sg@mail.gmail.com>
References: <20120209095415.GA19230@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 16:50:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvWGu-0004jV-Sx
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 16:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab2BIPuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 10:50:52 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57087 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2BIPuv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 10:50:51 -0500
Received: by vbjk17 with SMTP id k17so1146499vbj.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=lPck0aDRGIbcpcMMqauihYMMmAUkrAJDL0pQqm+LFH0=;
        b=KTVFeEQ4bYhtcpvYJsOLDYQSCuQH4ulAFzITRupwW/fLKuTCHqZL9VWoQ/AHvEj84Z
         1aNd7FQVQoICyC/wP/AkbXSwmB3k5ogkI1G8JeoLD0G5zQZXdwd137JtZxoxw/CjuFfV
         xpe9dEVKqHTNyFDgFzOkFb5YP/Pq5s8afA9gU=
Received: by 10.220.39.67 with SMTP id f3mr1026175vce.46.1328802650835; Thu,
 09 Feb 2012 07:50:50 -0800 (PST)
Received: by 10.220.116.3 with HTTP; Thu, 9 Feb 2012 07:50:50 -0800 (PST)
In-Reply-To: <20120209095415.GA19230@glitch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190292>

On Thu, Feb 9, 2012 at 4:54 AM, Domenico Andreoli <cavokz@gmail.com> wr=
ote:
> Hi,
>
> =C2=A0with the recent changes in tag merging (I updated git to 1.7.9)=
,
> my usual "git merge v3.X-rcY" command does not fast-forward any more.
> Of course the initial head is something like "v3.X-rcZ" without any
> change so that it should (and usually did) fast-forward to the new he=
ad.
>
> The editor is instead fired off and I have to fill the details of a
> merge commit, diverging from mainline as soon as I save and exit.
>
> Is there any simple and clear explanation for this? Thank you.

Someone else can explain what is going on more fully, but can you
report what happens when you run "git merge --ff-only v3.X-rcY"?

--=20
-Dan
