From: Alexey Kasyanchuk <degitx@gmail.com>
Subject: Big path on git add file [windows bug]
Date: Wed, 16 Sep 2015 11:01:28 +0300
Message-ID: <CAMg53oum4s2HE5A-H4g-3N8akOm4KetHM6ntUqRPnygLRALwpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 10:01:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc7f8-0002l4-4L
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 10:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbIPIBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 04:01:30 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36415 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbbIPIB3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Sep 2015 04:01:29 -0400
Received: by qgx61 with SMTP id 61so164865669qgx.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=Z6Tjb6O/5srYeJjeIeITPVp4FIuWKh99CM+I5zeyle0=;
        b=EowQQpmyjJ5bZHyy7biDewXKzCUMp3Mp7e7rKwKdvtHyI/n8v17V+jswUk5Qr5GlkM
         ADSHgfr2KU7SNpUxDjgsNHZBAMM9zXlLgqx6p/0h0JkNdsynCxNhcZLV4I3ypF1lU+C7
         YXP2xOEukFThoBBtQsmTU1RAFrQFlfB4to9KEwA87n1MCMPmd+MjbVEh5tvr+he+qser
         7CLKTFKm6n/VsehM/D1h8UwdBnojLZ2oAm15E0w7zO7eBO42L7qYuqID7s8HMguzLBQu
         qgSjQ52zzkmvCNmypYKF92Ffr3LwKnJLeKUrwYX2h3JX2sac0V/+5jr8Z5NwTfrPxwLE
         nBsg==
X-Received: by 10.140.150.213 with SMTP id 204mr39661400qhw.104.1442390488513;
 Wed, 16 Sep 2015 01:01:28 -0700 (PDT)
Received: by 10.55.146.129 with HTTP; Wed, 16 Sep 2015 01:01:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278006>

I tried add one of node.js module to git project. But add operation failed:

libgit2 returned: Invalid path for filesystem
'E:/Projects/vsteams/node_modules/gulp-imagemin/node_modules/imagemin/node_modules/imagemin-gifsicle/node_modules/gifsicle/node_modules/bin-build/node_modules/decompress/node_modules/decompress-tar/node_modules/strip-dirs/node_modules/is-natural-number/is-natural-number-cjs.js':
Data area passed to a system call is too small.

Is this windows problem or problem with libgit2 realization on windows
(windows 7 by the way)? It looked like problem with big system path
(276 symbols). May be some sulution for this?

Version: Git-2.5.2.2-64-bit

-- 
Best regards,
Alexey Kasyanchuk
C/C++ Developer


Skype: degitx
mobile: +375295777373
