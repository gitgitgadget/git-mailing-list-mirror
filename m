From: Petr Bena <benapetr@gmail.com>
Subject: git stash broken on MS Windows (automatically modify the files again)
Date: Wed, 3 Dec 2014 15:33:26 +0100
Message-ID: <CA+4EQ5d70JWiawt5zb9s6Vc3cDMApPmhdB2w+WLyfmWCcTQF4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 03 15:33:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwAzl-0003PY-Cb
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 15:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbaLCOd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 09:33:27 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:43993 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163AbaLCOd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 09:33:26 -0500
Received: by mail-ob0-f181.google.com with SMTP id gq1so1111626obb.40
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JRsyM5wp4echIGrwiZ+Hx2W11pKPMRZjVpYx4KLGTK0=;
        b=VUa2H2XLIg2IxMvIDdRi4NHhMJ0znKI8MR8slkhaykozFxzSdrTwwG4ghwlVps/M1k
         UAvFbiPAFaQAzesDHLGyRtA3XALvxumTtkG/+ZVKbo98NAigvLU0IOThq/sRiI+9S6fJ
         9sobF7nJhsZln9T8EGohM9bNP0SmRNaqLnfWL1uWsPYeQ6F4DPUGkF5TNzia1dTlkpHG
         97QXceM7G5w+UIAdR9/Okwgz1PBMMBMvvF8wzKe1BCKYMu1bidC6DOgWcaXeH3/NwmSV
         Tivx+V6w9hn8QFS5ERANPX9phILdvKYSdq1jQfR5E/BX9gW33fdMr92Zs0VBrwzpeEZr
         jb7w==
X-Received: by 10.182.122.139 with SMTP id ls11mr3410598obb.6.1417617206239;
 Wed, 03 Dec 2014 06:33:26 -0800 (PST)
Received: by 10.202.3.3 with HTTP; Wed, 3 Dec 2014 06:33:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260650>

I have a mysterious problem with one of my git repositories that work
fine when I check it out on linux, but not when I do that on windows.

On windows, pile of files immediately change themselves - eg when I do
git diff I see a lot of changes. What is even more interesting, is
that when I do git stash, nothing happens (it tell me it stashed back,
but changes are still there, so i can keep stashing and stashing but
it doesn't help), I still have lot of dirty changes to tracked files
and I can't get rid of them in any way. It's pretty much like if files
were containing something what can't be stored on NTFS and windows
version of git would replace the content with something else.

Because it's private repository I unfortunately can't provide it's
content, but these files are mostly SQL text files, the screenshot (so
that colors are preserved), is here: http://snag.gy/93A8S.jpg

Is there any way to "fix" windows git so that it works? Did anyone
experience this? It may be something related to windows line endings,
but I am not really sure.

During installation of GIT I checked "keep line endings as they are in
repository"

Thanks
