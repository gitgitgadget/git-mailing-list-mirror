From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: why no "ignore" command on git
Date: Thu, 15 Oct 2009 00:35:23 +0200
Message-ID: <42efdea40910141535g23a50b87p9b6c4a0fde7e842e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 15 00:48:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyCdh-0003sC-Py
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 00:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761276AbZJNWgC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 18:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761253AbZJNWgB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 18:36:01 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:33732 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761232AbZJNWgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 18:36:00 -0400
Received: by ewy4 with SMTP id 4so296863ewy.37
        for <git@vger.kernel.org>; Wed, 14 Oct 2009 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=8ToOxpgGHdBV8IK1H7d8QAKms9yztzJT23cZRmWlyxs=;
        b=gKQ2rdSZKg/0TfRw++rUgqGckhzfbWrIz8kvCUwIm5cZECpmBV5mCxJy8c9PA2iXYp
         xgZK3IHREfAz1jBMbdKc81ugtsrkQwPX2BhAK6wFzp6iADoTGJFCJdJRcQ/IERair5jR
         qAHPHo6Omt0zEOl7kE1ig3Dr77pccbLfgikpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kXsXFS1UQm+ci6I1eSD9CKXF9VsCC1ZqJvEAYqMiF33LETX/O+xOEC7z3ky4y/ZkiV
         f6SB+H6+jQ6PY7rMSMnxqDWP+Efz39E3nMXn8Qj8zNHHp7+LFalutjU+Vktl/Nx1SNP2
         vTS0kuy9dPgSKwxRcRL0kQktk+viV08xyocI4=
Received: by 10.216.88.209 with SMTP id a59mr3064207wef.50.1255559723279; Wed, 
	14 Oct 2009 15:35:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130346>

Hello,

why does git don't have an "ignore" command, to ignore some files or
directories all the time.
In many project file structures you have IDE specified project files
or directories which
should not be tracked on git. All the time git says that you can add
these files, this is not
usable if you want to add many files with the "git add ." command.
I read on some pages by a google search that you can create
a ".gitignore" directory or something like that. But you had to do
this manually.

why there is no "ignore" command on git?

best regards

Ralf
