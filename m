From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: german translation bug
Date: Wed, 25 Dec 2013 21:59:10 +0100
Message-ID: <CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
References: <1573480.3a5WD62Cc4@i5>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
X-From: git-owner@vger.kernel.org Wed Dec 25 21:59:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VvvYE-0005ul-JI
	for gcvg-git-2@plane.gmane.org; Wed, 25 Dec 2013 21:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab3LYU7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Dec 2013 15:59:12 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:39122 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab3LYU7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Dec 2013 15:59:11 -0500
Received: by mail-wi0-f169.google.com with SMTP id j9so4457436wiv.0
        for <git@vger.kernel.org>; Wed, 25 Dec 2013 12:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=7Adbck3EuExkozrXMKaB1nZ1EXfVPP4O3GrEMfJN5i8=;
        b=uP68VFYGnCabd+06evDPfokgcPDGb6K3+cLX/+96C/yz76bi0U3MYfnlRl6jNuNPC4
         dqUWnIO57gOYkON6EAH2BoJVa/8Re3BJSj2DFBJlEpMjkMpIRt0NpbroIHnmeL9MmWFo
         ZP1lx5TCtN3dcCHTL3pcT0SfjGGqyEJIGgWR04iOX3QXlQLcKGOpVUPqhweaXN9ahWqU
         +GI34S3i8STrRRYivDeJLXV1nfQmguUUTB4OmTL5OrTYlPv3J1bNoPNMfci2u0atpXfn
         DrpxbvcsD2/mIG/hUNpbj5xuLwZ6eRRb+uIB8+Vb9gHqtGB0MZie+rS4hWhKwmAvuEg/
         4kQA==
X-Received: by 10.180.108.83 with SMTP id hi19mr26802677wib.26.1388005150119;
 Wed, 25 Dec 2013 12:59:10 -0800 (PST)
Received: by 10.194.165.163 with HTTP; Wed, 25 Dec 2013 12:59:10 -0800 (PST)
In-Reply-To: <1573480.3a5WD62Cc4@i5>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239677>

On Wed, Dec 25, 2013 at 8:53 PM, Wolfgang Rohdewald
<wolfgang@rohdewald.de> wrote:
> "Arbeitsverzeichnis leer" means
> "working directory empty" which is obviously wrong.
>
> It should say
>
> "Arbeitsverzeichnis sauber"
>
> wr@s5:~/src/linux$ git status
> # Auf Zweig drm-intel-testing
> Nichts zum Einreichen, Arbeitsverzeichnis leer
> wr@s5:~/src/linux$ LANG=3DC git status
> # On branch drm-intel-testing
> nothing to commit, working directory clean
>
>

This message is currently translated as "nichts zu committen, Arbeitsve=
rzeichnis
unver=C3=A4ndert". Before it was translated as "nichts einzutragen,
Arbeitsverzeichnis sauber".
According to the log of git.git, it was never translated as you wrote,
so it seems
that your system uses a different German translation than upstream Git.
What version of Git do you use? What distro in what version do you use?

>
> --
> Wolfgang
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
