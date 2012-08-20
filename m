From: Jose Nobile <jose.nobile@gmail.com>
Subject: BUG Report. Why GIT commit need 30GB of memory for a commit?
Date: Mon, 20 Aug 2012 00:12:33 -0500
Message-ID: <CAJ69RUQ++RpfgDmPh2k6n1e61xX9OZ_tvG5K7Q4CXvh7i2cj6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 07:12:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3KI4-0007AQ-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 07:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250Ab2HTFMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 01:12:36 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43798 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab2HTFMe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Aug 2012 01:12:34 -0400
Received: by qaas11 with SMTP id s11so2722422qaa.19
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 22:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=BzXBId7uidhARbuuY7izATuM/U/SdSnI17IP3GNGXIc=;
        b=QmV8AYQ5nm8DGBUR8y/GzTK4lffExBqVLcS06HGrFtb56uGsKcvK1BlceU6VtgeMO7
         uGzC8l5roUo1iXAn4joSFaxGYHitscZtEtKeYZ+lMPI+Pn9g6APr3WJyxohKPuHQJX66
         o/wYNz5DE5isTPdN7nMhh/SrTTLdJmtmMtYvxdsnWVAprlDMxz/6vwz7SZTSGWuDNLCS
         Do/NyaX8d5LtPrfH2f2PR3lZ+WxNA8cFZDS4DmkwA5Zsx3XBty3xVEr9RvnaayBx4nHa
         Gvgfc+89eXThq5Jg9v8sLhLz+vgBlJxO1DigOYpT1xdmdnWHpsjC7z8iTMqn4ujcqJ+5
         jM9w==
Received: by 10.229.134.213 with SMTP id k21mr10059687qct.106.1345439553801;
 Sun, 19 Aug 2012 22:12:33 -0700 (PDT)
Received: by 10.229.219.147 with HTTP; Sun, 19 Aug 2012 22:12:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203754>

I have a big repository, around 80GB
git --version
#git version 1.7.12
git init .
#Initialized empty Git repository in /reponame/.git/
git add -A .

git commmit -m "Backup 2012-08-19 03:43:44"
#fatal: Out of memory, malloc failed (tried to allocate 32220431361 byt=
es)
#[master (root-commit) 8053f0d] Backup 2012-08-19 03:43:44

 Why GIT need 30GB of memory for a commit?

This is not in accordance with the first paragraph of the homepage of
main page of GIT:


Git is a free and open source distributed version control system
designed to handle everything from small to very large projects with
speed and efficiency.


Greetings,
Jos=C3=A9 Nobile
