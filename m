From: Carlos Santana <neubyr@gmail.com>
Subject: file in new branch also shown in master branch?
Date: Mon, 28 Dec 2009 16:37:08 -0600
Message-ID: <92c9564e0912281437g20fe51f9ta33383791ef20385@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 23:37:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPODF-0002fl-Sr
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 23:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbZL1WhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbZL1WhK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 17:37:10 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:51545 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbZL1WhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 17:37:09 -0500
Received: by fxm25 with SMTP id 25so4891863fxm.21
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 14:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=20rYgf9m2zSqruheKUoiXKKSVaO8tWX7uLR9bc0XC7M=;
        b=uAdX+TxKcNjXlZSqWkJEP075cYBWXR6Jt0Gd0UwYDojDv5II0CfMg6yVrj1dAQmmM9
         mZOojJX5Dvw7gBRujuo927m1mEq50ARmPng112uqc0yHLxS5wGaSsIS5zRrEj2iaUXmG
         H1xgOBvuTqymmQnyNZuR6gLl9I+m2I2srGgjU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=oAeZhrALDIFhwYFfcuK47DufWCJzHtudlQuM1uc/4PUgo49oNTXG5HTX7y6FPp+yDh
         TW6/eZK9N0X4CVV1o3Ef8MrMibUAez5QoZ+6E0FaHhmBiWB7xyWwQ2H6aSPqg2OvUtnL
         3kwSm1osUcZzAhFJ/Jen/wV2UWN6VwGBQFol0=
Received: by 10.223.5.77 with SMTP id 13mr10604948fau.86.1262039828117; Mon, 
	28 Dec 2009 14:37:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135771>

Hi,

I tried following commands to test branching:

git branch test
git checkout test
echo "Test branch" >> testfile
git status
git checkout master
git add .
git commit
git push

The 'testfile' file shows up in 'master' as well as 'test'. I thought
it would be seen only in test branch, but it is not so. Is it normal
or am I missing something? I was unable to repeat same behavior again,
so I am confused now. Any clues?

-
CS.
