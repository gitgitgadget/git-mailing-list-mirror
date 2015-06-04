From: Rossella Barletta <rossella.barletta@gmail.com>
Subject: Permission denied ONLY after pulling bundles
Date: Thu, 4 Jun 2015 15:04:21 +0200
Message-ID: <CAJeiYQGUsB-9XYdnqDgoSy5JU-EVTbf-1OuTU5BGfpT9q6xKbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: dario.ligorio@selex-es.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 04 15:04:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0Uot-0004Pc-QV
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 15:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbbFDNEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 09:04:23 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:35037 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbbFDNEW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 09:04:22 -0400
Received: by qgh73 with SMTP id 73so2594562qgh.2
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 06:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=OljxJE4WIouxgNh0L0lONPtEbxsygkBh9SiPR4cCGHQ=;
        b=CcIh1WG+IKbvzqK7bP52iE1vmAJrDPIRj/aDiG9O4zkjsCkWRW4AwYNIDahZ4uuL2C
         KIUS+40Mx3g7vIrI0snS/eXPs8B5aJkk1SOb/RXqXsNOgntczKZmO/LFFPePzclvnqU6
         E4QyLJNI4Nks3ZBV9M3c+XpZBCOjDANoKpG7oc5Qq+5dDw2erk4aUHeC0XdTn+uVKLZB
         hBK2WDDzlfsQelowVjUAX2jAaHyWUx6S6KsPI+iPt6IpK1odxrqVCLDbl8rEjPNWB3Wb
         Ur86RbMTEKzcpfsR4sk8JjnUtcrMjG3rhBKvMD9mv9hAm+uLRiqSnABMAO87cSPCY9oF
         hdhA==
X-Received: by 10.140.81.135 with SMTP id f7mr42422923qgd.33.1433423061555;
 Thu, 04 Jun 2015 06:04:21 -0700 (PDT)
Received: by 10.96.58.165 with HTTP; Thu, 4 Jun 2015 06:04:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270771>

Dear git group,


I would like to ask your help for a problem that we cannot fix in any way.

We have a git repository in folder on Windows.

Then we use VMware player on CentOS_6 on which we create a clone of
the git repository, after of course having mounted the directory in
which the repository is.

So the repository is on windows and the clone on Linux.

We are able to perfom all the git operations we need, except for the
pull .bundle, which is successful in itself but prevent us from
pushing after that.

As we try to push after pulling a .bundle in a branch we get the error message

NODE1:fdp> git push
Counting objects: 1977, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (423/423), done.
fatal: write error: Permission denied00 KiB | 158 KiB/s
error: pack-objects died of signal 13
error: pack-objects died with strange error


We have checked all the permissions, changed the users, recreated the
clone but nothing worked.
The push operation works perfectly until we pull a bundle. After
pulling a bundle we are not able to push anymore.We tryed to delete
the branches, recreate others and all works perfectly, also the
push.As we pull the .bundle we cannot get the permission to do the
push anymore.

What has this to do with the bundle?



Thanks for your support.


-- 
Rossella
