From: Michael Campbell <michael.campbell@gmail.com>
Subject: Should "git help" respect the 'pager' setting?
Date: Thu, 30 May 2013 12:33:01 -0400
Message-ID: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 30 18:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui5mm-0000Y1-Kp
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 18:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934587Ab3E3QdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 12:33:04 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:63530 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933985Ab3E3QdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 12:33:02 -0400
Received: by mail-pd0-f175.google.com with SMTP id 6so650780pdd.34
        for <git@vger.kernel.org>; Thu, 30 May 2013 09:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=TH1kaxzjjw3zuhVkqVjgl89S8D2gKKyMa7LgnK4xVRw=;
        b=Om5woKrCz9c1CVw0qn9eU7m3a7tre2gBj2Np+AvuJ/+VqKaPgyBu28nrTAbQ1sMBS6
         ExWnDiEs8fZG2fTnwPzUQoBgC2DpwCM5iLMLrhFLij4DsdDIUNS8d7Zfb9SezM+DiZbD
         nu1hAuoqVilHdjok1CICTpDPbPRxurPKOJmbRgz7rEaZNH4SrtaOmFqX8/LIuUYiiflL
         iT8D+6YXAjIiL8GlKP4ndEZLxL5kBJ84WRxVDkQj+B80bkMPGNEHofMvPoMy34a/gEcy
         oRrWoiP4N85VikikyVqoVLEyL3hxw2oTuwPaY8uRhHmpyKskicZj2qGBWfZWT4IlCe1Y
         MCSw==
X-Received: by 10.68.211.73 with SMTP id na9mr8847556pbc.90.1369931581812;
 Thu, 30 May 2013 09:33:01 -0700 (PDT)
Received: by 10.70.91.225 with HTTP; Thu, 30 May 2013 09:33:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226019>

I have my global git config pager set to 'cat', but when I do a "git
help <command>", it still uses a pager.  This is especially irksome in
emacs shell buffers, where I am most of the time.  I know I can do a
M-x man -> git-<whatever>, but wondered if this was a bug or user
error.  ("git --no-pager help <command>" does the same.)


12:31 [mcampbell] /tmp  % git --no-pager help log
WARNING: terminal is not fully functional
-  (press RETURN)
