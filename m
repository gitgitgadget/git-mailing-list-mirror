From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Does Git really need a commit message to go with a commit?
Date: Sat, 3 Apr 2010 22:06:16 +0000
Message-ID: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 04 00:06:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyBTz-0001GN-OO
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 00:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab0DCWGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 18:06:19 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:45621 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab0DCWGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 18:06:17 -0400
Received: by ewy20 with SMTP id 20so815893ewy.1
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=x2y6TFk27/E6hK7YV3nujhmOMgqzVADeWAK1oFoxwUQ=;
        b=gPROGcoiW8nkOYmeeireIEzm9FY3Ds3iYFCtjGlV8yxPvKqK3FVNIxnkp3tSTmv+Vr
         86HZkrL30W9wmbf5eVlr9z4yBG3AWnl51asu5ZJPkHBIU2c0X7a+g916b/qfnSqC9cXj
         iHv7ksqkEO/dOXjwDWsoPOFC8MCkR70NPRZq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=n46oTkOd+prOkBvY7r6Fz5tz/KLf+59pQ4YWpmUuyN45ykihX1ajkDRjv90nv+S3Ru
         PTzi4KnPJuJcJS1qiCfj8OaCmPFz3dmwAMFkE1xNPV89g2Zck8wux2NFIxkI8TXlS0BH
         6ERqxbotrY9zWIwrlFkbGpnmydeVzimv67yhs=
Received: by 10.213.16.146 with HTTP; Sat, 3 Apr 2010 15:06:16 -0700 (PDT)
Received: by 10.213.44.129 with SMTP id a1mr543946ebf.37.1270332376247; Sat, 
	03 Apr 2010 15:06:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143906>

git-commit(1) doesn't allow you to make a commit without a commit
message. This is annoying and doesn't properly preserve history in
applications like snerp-vortex which replay a SVN dump into Git. You
have to add `$msg = "Git made me do it" unless length $msg' somewhere.

Is there really no way to add a commit with no message with the git
tools? Will anything break if I manually construct a commit with no
message? Are commit messages inherently part of the format or does
git-commit(1) just think it knows better than me?
