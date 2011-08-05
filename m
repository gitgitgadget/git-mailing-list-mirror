From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri, 5 Aug 2011 19:29:01 +0200
Message-ID: <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Aug 05 19:29:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpODS-00059V-Uh
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 19:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab1HER3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 13:29:42 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41039 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377Ab1HER3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2011 13:29:41 -0400
Received: by pzk37 with SMTP id 37so4212495pzk.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 10:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Qev24zZwRR+XSd/gzu015lnblJJAO70vxtnrjAeq70Y=;
        b=Ll7hxCOgBzUG9Q5W6DB2U7n+3b6zkKxx4YZNyiFPzclKMXAKBHAF2dcIZ/1CdlWtb4
         hoU+MD3FBe8EM649Nk8AqupAQfcuLzH4HWmSrou8/M7Vr/K5OH4NO3h0iAkTAuQqH3Mp
         3q5+IlyoJv+XsD8a9+79sfnM6SavTlsi6UYVE=
Received: by 10.142.48.20 with SMTP id v20mr2314736wfv.115.1312565381062; Fri,
 05 Aug 2011 10:29:41 -0700 (PDT)
Received: by 10.68.56.65 with HTTP; Fri, 5 Aug 2011 10:29:01 -0700 (PDT)
In-Reply-To: <1312560614-20772-3-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178806>

On Fri, Aug 5, 2011 at 6:10 PM, Pascal Obry <pascal@obry.net> wrote:
> In fact Cygwin supports both, so make Git agree with this.
> The failing case is when a file is committed in a sub-dir of the
> repository using a log message from a file specified with a DOS
> style path-name. To reproduce:
>
> =A0 $ cd src
> =A0 $ git commit -F c:\tmp\log.txt file.c
> =A0 fatal: could not read log file 'src/c:\tmp\log.txt': No such file=
 \
> =A0 or directory.

Cygwin is a unix-layer on top of Windows, designed to play by the
POSIX-rules. So why would you want to support Windows-style paths on
Cygwin?

If you want a Git that handles Windows paths, use Git for Windows...
