From: "pradeep singh" <pradeep.rautela@gmail.com>
Subject: Git pull fails on a repository > 1.5G.
Date: Mon, 17 Sep 2007 14:29:24 +0530
Message-ID: <a901b49a0709170159g477525bcr5383a1a051ae5e3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:59:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCSK-0003fW-Cs
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759307AbXIQI72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759303AbXIQI71
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:59:27 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:58243 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758827AbXIQI7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:59:25 -0400
Received: by py-out-1112.google.com with SMTP id u77so3032428pyb
        for <git@vger.kernel.org>; Mon, 17 Sep 2007 01:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=V+L7RbUObZRDs6FzpVvHT1vw8aUb6DxX+byx3Vd/PCg=;
        b=h6idLfSe8ogVgZrIpVdmuEMZsx/GZHDU2MAtRC3mTg+qKUPEKZp/kwTCFsqGUMMQf9pdQ5uvn8xx1cVk9Ug9w0p/9OPnD6dSMt2v55rkzMDXA80vxxYKCRpPrkc/m1HElRkHs+IOoQceIHOzs3yEAoexiYWxB3/I402pmVoGf5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sspY49EHwG/l+F4Fo+S82YX4T/WtWE/yQH7LPAD4xDW0UYYN+xIDTVbB+ENgjufxrjTTakjLEHW8DbpDR2JPq/eovVA7HbWkNnCBDZG9kaKQkGOkYtW0lAwJn9+AXX6JgiRan2qCmDoO6fN3F8AMriqHRQ32fkB7iJTiAWTcsBs=
Received: by 10.35.131.13 with SMTP id i13mr6031500pyn.1190019564759;
        Mon, 17 Sep 2007 01:59:24 -0700 (PDT)
Received: by 10.35.93.15 with HTTP; Mon, 17 Sep 2007 01:59:24 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58404>

Hi All,

I am using git at work for a rather big repository. Size is around
1.5-1.8Gigs now.
My git version is 1.5.2.4.

The remote repo has some changes to a file with some simple printk's
some some code changes.

I have my git repo in /mnt/reiser/project .

I changed to the my repo.

i did a git-pull ssh://user1@10.100.205.34/opt/test/project test .[to
pull from another test machine].

I got some conflicts in a file but in some important files it did not update it.

Any hints whats wrong with my technique or is there something wrong with git?

BTW the two machines have different versions of git. The remote
machine have git-1.4.4 from ubuntu repo.

Thanks
---
Pradeep
