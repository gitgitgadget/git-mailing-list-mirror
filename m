From: =?ISO-8859-1?Q?L=E1szl=F3_Lajos_J=E1nszky?= 
	<laszlo.janszky@gmail.com>
Subject: use gitignore implementation in shell bash
Date: Tue, 18 Jun 2013 17:45:55 +0200
Message-ID: <CA+=RcCrAnNoFbu1VGnFLpubOkss1VyyfdumJiVcJ0G0z+tB6sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 18 17:46:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoy6a-0000Eh-9O
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755785Ab3FRPp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 11:45:56 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:42944 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871Ab3FRPpz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jun 2013 11:45:55 -0400
Received: by mail-oa0-f42.google.com with SMTP id n12so5254724oag.15
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=GMeszCqDDG/4tCm9OP3vijH0YxAMuXIBpowhsWQDAfc=;
        b=k3XwfGUsQwpY8NkS4gL7oQpisPnjcTTjjYgk8VAGUN0rPdcfPTDjQsiZmNp4mr5ppD
         XQPXPb5j/1o3UL2iNQnhoflNgiHe2699t355uSj9ea4hgIxbsawWCO3HfGalYjs5hmD+
         5KgntkLsgimBsxN/JKqqqcgVO1vDmXg4TJEmA7i6xhM/zu5bdfLPEFx4P5YfgapdU8jR
         5wj7HrfpzVeLHE2biPtO9WGuNXnFZx0J3y6JNTlStMmL+ktnoVuzJw2FCSOQaiD4eAjC
         lqud59/i6iIdjVxE5OSjj2gRp//K3prHTGezBQzMc26FJ/ZUU/W3+V//kkVgJRGu3f5X
         S5lQ==
X-Received: by 10.182.79.106 with SMTP id i10mr12523054obx.59.1371570355313;
 Tue, 18 Jun 2013 08:45:55 -0700 (PDT)
Received: by 10.182.29.166 with HTTP; Tue, 18 Jun 2013 08:45:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228254>

Hi!

I have a question about gitignore.

There is a git extension called git ftp, written by Ren=E9:
https://github.com/resmo in bash. This extension uses git to push only
the changed files to the ftp server. Currently this extension uses
grep to decide which file is ignored by upload. It uses a config file
called .git-ftp-ignore which contains the regex patterns. I was
wondering it will be better if we could use a gitignore style config
file, and I found an issue for there:
https://github.com/resmo/git-ftp/issues/191#issuecomment-14647798 Now
we are discussing about how is that possible.. If anybody can help in
that it would be awesome! I thought there is a slightly chance to use
the original .gitignore implementation for that. Is that possible
somehow?

If you want to contribute, or you have an answer please write into the
linked issue: https://github.com/resmo/git-ftp/issues/191
The developer of the project cannot see this mail list, I am just an
user of his product...

Many Thanks!
Laszlo Janszky
