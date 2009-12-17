From: Robert Zeh <robert.a.zeh@gmail.com>
Subject: git svn mkdirs ignores compressed unhandled.log files
Date: Thu, 17 Dec 2009 11:10:03 -0600
Message-ID: <8BB233FB-4269-4B14-8703-A4FF1E25FB0D@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 17 18:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1NLJwu-0007pr-EJ
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 18:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764970AbZLQRKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 12:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764966AbZLQRKT
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 12:10:19 -0500
Received: from qw-out-2122.google.com ([74.125.92.27]:14490 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbZLQRKQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2009 12:10:16 -0500
Received: by qw-out-2122.google.com with SMTP id 3so434399qwe.37
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 09:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version:x-mailer;
        bh=QG7BjgL8xZ5qpwWQPI1Md8H7EDEVBn3GasBSD8ZytLQ=;
        b=AoLRwSbxzYYJNQIyT7eQDyMR20xdsx0G5eu/i6GRPpcSFUicqA4n08CR/p4s9Y5QPN
         xTcXr4wfNjwaH3MqwccsRWqPQVlvEQpv83sqH8pJP9TfZcO24mEbNX9Df2aAn3Q3xriQ
         yRSkwX0R7a448GSPnOr1w6peJGbMtNXr6/8gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        b=WLJSwLisAWLmCN3Y9JxXhRA1DY0S3qhSiF+hkaKYIRsjt07KyYOgTkf7b90zUrLOK8
         PVA4TmTWD1/cst15vC/MHi09ccSjitbFBHOKrOenDODjuyf5443QKSMnen3jmV7QpGfz
         3mQTwRNkNSh7gLk6JwZbReEMudSbPqV6AqU8E=
Received: by 10.229.11.215 with SMTP id u23mr1510848qcu.91.1261069815033;
        Thu, 17 Dec 2009 09:10:15 -0800 (PST)
Received: from macintosh-5.getco.com ([66.250.141.2])
        by mx.google.com with ESMTPS id 20sm1510333iwn.9.2009.12.17.09.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Dec 2009 09:10:14 -0800 (PST)
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135377>

It looks like there is a conflict between git svn gc and git svn mkdirs.  The git svn mkdirs command only looks at unhandled.log files.   Shouldn't it also look at any compressed unhandled.log files too?

Robert
