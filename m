From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v2 06/19] reset.c: remove unnecessary variable 'i'
Date: Tue, 15 Jan 2013 10:36:40 -0800
Message-ID: <CANiSa6i6p98Kjc=+4hjag46Oby-_aPuHqjPukUDsVULbjkPCpw@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
	<1358228871-7142-1-git-send-email-martinvonz@gmail.com>
	<1358228871-7142-7-git-send-email-martinvonz@gmail.com>
	<A5E8E180685CEF45AB9E737A010799805E00DD@cdnz-ex1.corp.cubic.cub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matt Kraai <kraai@ftbfs.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: "Holding, Lawrence (NZ)" <Lawrence.Holding@cubic.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 19:37:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvBNg-0005Nj-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 19:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab3AOSgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 13:36:44 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:37599 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431Ab3AOSgm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 13:36:42 -0500
Received: by mail-ie0-f176.google.com with SMTP id 13so795314iea.35
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 10:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k/Kdh4A1Oipg1r1JT5olnor3fE1rqALjhJpB/00h7zQ=;
        b=Px+skkOKzrNk6BdUmUoUPzGAJa7gd5aU/5nYr4frZRPlIAWkNI6SHv8nrYRFN06E9R
         0gvEFNpDAGwrnxyiX5eE4llJXaoG45lpr5Fj7oyPmozY1QKcEA4miYI0Cz+0F1XlpzZT
         s5Y2iZnHVmK82nWnlRwNwOeoHR5R9kVfNa7xz+E2ENdA/eGhSniJP9fAURE0DeSdzrjY
         WMEXUudGFvF62rst4Ska/2zwM6IIPUSprQ2wJY+sxtLs7gVMvLU0lwf3CVKACWT7LF6f
         26fWgxVzlrUtbNK7X5bIHr7kNxTBBG8+vs7IJQuxr+PRudK920pI3fb1DGIDny5TMZ2O
         tmzA==
Received: by 10.50.187.197 with SMTP id fu5mr2371778igc.95.1358275000642; Tue,
 15 Jan 2013 10:36:40 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Tue, 15 Jan 2013 10:36:40 -0800 (PST)
In-Reply-To: <A5E8E180685CEF45AB9E737A010799805E00DD@cdnz-ex1.corp.cubic.cub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213657>

I suppose this was meant for everyone. Adding back the others.

On Tue, Jan 15, 2013 at 10:27 AM, Holding, Lawrence (NZ)
<Lawrence.Holding@cubic.com> wrote:
> Maybe use *argv instead of argv[0]?

Sure. Everywhere? Also in the lines added in patch 17/19 that refer to
both argv[0] and argv[1], such as "argv[1] &&
!get_sha1_treeish(argv[0], unused)"? Or is this just a sign that I'm
making the code _more_ confusing to those who are more familiar with
C?
