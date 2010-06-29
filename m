From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: recovering orphaned commit
Date: Tue, 29 Jun 2010 20:39:03 +0530
Message-ID: <AANLkTiks6yPfdTACQwZlqv8PPPEg3RYGMx1Q1PjT0nRu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 29 17:09:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTcRW-0000hF-T0
	for gcvg-git-2@lo.gmane.org; Tue, 29 Jun 2010 17:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756480Ab0F2PJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jun 2010 11:09:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32893 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278Ab0F2PJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jun 2010 11:09:10 -0400
Received: by gyd12 with SMTP id 12so1426976gyd.19
        for <git@vger.kernel.org>; Tue, 29 Jun 2010 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=jxbp9WdZhPol+0DAhwusEq7FAPnz9SiYMJSla/x5XDY=;
        b=Od0ii2Z7QsMOSm2wN5ffNRd+DlNEj385JBYa3ldXgxgVolJsMWJw8agTt/ljNhECWC
         sAL9g91DX3aNZRnKtSb3y2cCsuxkTtwIgtxq5iItM4EiuphyWR/XO+lVSwMtoXBS98dp
         vjVx5Ah5UPYdIoybxsD4TwXcI4XyxqKhp7UyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=E2Cp1C7wvHL717NfzV5KGlnCipWgt+tw97DaP++Cy/euVYg5NyHakTSYTPaaDFc5C4
         P7c+Rw/NLhuwb9z/G7Kt/7C4kr1Hh4o2OzKcfJ1yQn8ar1Or6/+ESbhtCBXPJtg3EQaO
         IkuaEHGRYYeUKcIO5K4JWUK3VwaxECLXRaENc=
Received: by 10.91.178.7 with SMTP id f7mr5583597agp.42.1277824143954; Tue, 29 
	Jun 2010 08:09:03 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Tue, 29 Jun 2010 08:09:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149906>

 I have a situation like this; 2 commits.

Example -

 2899684ed173063354b7fe4f5ec7216e7d953e2c	 <-- HEAD  ( say C1)
 1ef67de1a0d6e97470a8c827d2989317600532ff                    ( say C2)

To see file at C2 ; I have done git reset --hard C2; I could see the file.
Now want go to C1 ; Ho do I Determine C1  using git command ?

Thx/ Mahesh Bangalore India.
