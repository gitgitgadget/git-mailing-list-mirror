From: Alangi Derick <alangiderick@gmail.com>
Subject: Fixing translation errors in gits error messages
Date: Sun, 3 May 2015 17:39:27 +0100
Message-ID: <CAKB+oNsa5c3zwx03pm7P_FDO3Xdxgr+rBOncAAmAjQL4LLJOdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 18:39:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YowvX-00080h-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 18:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbbECQja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 12:39:30 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36657 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbbECQj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 12:39:28 -0400
Received: by qgeb100 with SMTP id b100so56537284qge.3
        for <git@vger.kernel.org>; Sun, 03 May 2015 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DPpcKzOyq6JuDXplZuFBZ4CtFg33W+7kA886RMaOxWk=;
        b=urFHhhYbTpr5S04q9iaURE7XdOy/NkYrELUTbi9tyMpIYfG9HGOkxNPLWOh+9yD8Wh
         T4vZUk41JLxsqUinbgePBr4Xu5jAfDl0gXDhWv9vKW5m1tH0uT3jnqIBXOTqjQq8KTG6
         /6iFDs0AYS2dWZ6FFssFqnE0qJPx47iLb//JxkBM00CsXhKlImnhTKzITuMzmJn96wGA
         rK7kCjvu63QuironJYymEb3VS2ee7hAV5Knyb+WrhU/ZPoYMN0yzmgHdpUNtfUwKEjZT
         vK/hAPRQH1GZxa4FCB4he3+ShnOx/fMWzqzTJu1qtLxhi8WN+sY5pS4mf/1dsYaQZOoN
         VGdQ==
X-Received: by 10.140.192.73 with SMTP id n70mr23446250qha.91.1430671167870;
 Sun, 03 May 2015 09:39:27 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sun, 3 May 2015 09:39:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268270>

Hello,
     I am embarking on the project of fixing all the translation
errors in the entire git source codes while maintaining the strings in
error(_( function the same. I will be sending a series of patches
which will include the fixes for all translation errors for files
containing them until i finish all this errors.

I ran the command:
 git grep --cached -F -e 'error("' > fix_translation.txt
so that i can track all the files with the errors and fix them file
after file manually.

Regards
Alangi Derick Ndimnain
