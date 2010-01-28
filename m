From: kap4lin <kap4lin@gmail.com>
Subject: make install error
Date: Wed, 27 Jan 2010 19:58:42 -0500
Message-ID: <daef5be81001271658y4188445bofea2e3d576df91e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 01:58:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaIih-0006ny-EP
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 01:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab0A1A6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 19:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113Ab0A1A6p
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 19:58:45 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:49369 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab0A1A6p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 19:58:45 -0500
Received: by ey-out-2122.google.com with SMTP id 22so1301200eye.5
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 16:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Da+JXDCAkffS2Ppj2BhfDcsYi6Pg6oMSD/up7lGuvLU=;
        b=FxQ+9U24MgxHyxznsgizKaWmsZWcdqWmC3P6V4zClusSYvFl7ZdLxn+W91xJT45jXV
         18bFuKhdUIpp108nAH2pwE70VfNKaXO30h4OtaaPUPR9yjzh5s5Ze13s0BEoRG8mUNqc
         V1tDKOLCPGZe9fyL1tCHD+q8eMRL/WZKZMabM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=QVUzQrEQKWvpTMgXAbjRKHAP1nnVjW/2VNrqWVZ+LQ4o6+kJMRK2LKL9NaB0086OIJ
         H4wvwGnZf2uVFbeymoaVitlitCu18sOTg4PxhHp+sFw6xquRfxC2JYWlc4D5rmXBKtk4
         Z6stIU2wJjEPYN9/5OBYwpA/569QQNDLEHmJw=
Received: by 10.216.86.139 with SMTP id w11mr450933wee.10.1264640322611; Wed, 
	27 Jan 2010 16:58:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138213>

Hi,

(Kindly Cc me, I am not subscribed)

Process followed:
$ make configure
$ ./configure --prefix=/scratch/kap4lin/usr
$ make all
$ make install

The make install step is giving the following error:

make -C templates DESTDIR='' install
make[1]: Entering directory `/scratch/kap4lin/softwares/git-1.6.6.1/templates'
install -d -m 755 '/scratch/kap4lin/usr/share/git-core/templates'
(cd blt && gtar cf - .) | \
        (cd '/scratch/kap4lin/usr/share/git-core/templates' && umask
022 && gtar xof -)
gtar: This does not look like a tar archive
gtar: Skipping to next header
gtar: Archive contains obsolescent base-64 headers
gtar: Error exit delayed from previous errors
make[1]: *** [install] Error 2
make[1]: Leaving directory `/scratch/kap4lin/softwares/git-1.6.6.1/templates'
make: *** [install] Error 2

Any help?
-- 
Regards
Kap4Lin
--------------------------------------
http://counter.li.org  #402424
