From: gnu kevin <kevin.gnu.zhang@gmail.com>
Subject: how to clone all branches include remote branches
Date: Wed, 11 Feb 2009 01:49:12 +0800
Message-ID: <95463c700902100949w23a95536re9a65a2e5c3c0b5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 18:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWwkr-0008KQ-VW
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 18:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbZBJRtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 12:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbZBJRtP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 12:49:15 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:50766 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752995AbZBJRtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 12:49:14 -0500
Received: by qyk4 with SMTP id 4so3428159qyk.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 09:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=qBam19/Rzt6a8EWbx4ZnPVL4tC/751y/FHVwzIhR/TI=;
        b=q3w5/o0DN8YOaZxm+50IAPlaVB1SaClA+Ud7Qh4Qlg9wnw4q3iDVevWs55Qp0nCRVA
         iwe1jkA0SZTtHKiodSVx66zV1Y/tEsEmf7EtvY4Fy3+Vx24Jc7xC/549hSj+MIdUAP2c
         NIs+zR9ZeUN0TcWtyT0PK5qL/I2CXVhH+yciE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rlllaVgARb0XUoTb8Vjm5KJynMOkEJo7n9ypP+JwpNXaD5WspsHe/WKME1HOmqgerl
         IEs8Nz64Zk2rSB1Rdrr0Y1gwAMwRo5K+PVzhKNvSQAFhudZRl6K388dWBSKrSdJkJtg7
         NdFymYbWQYoXeMwqKITtGD1HsE+kMksKwHP3Q=
Received: by 10.143.18.21 with SMTP id v21mr1309214wfi.149.1234288152750; Tue, 
	10 Feb 2009 09:49:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109284>

hi,

I'd like to know how to get all remote(grandparent) branches by clone
a remote repo . for example:
remote repo ABC contains below branches:
master
stable/main
dev/main

while master is the local branch in remote repo and stable/main &
dev/main is two remote branches of that remote repo, when I clone from
ABC repo, I can only get a copy of ABC's local branch master, how can
I get those two remote(grandparent) branches also copied?

BRs,
Kevin
