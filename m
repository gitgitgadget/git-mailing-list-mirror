From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/2] gitweb: CSS cleanup, part 1
Date: Mon, 19 Nov 2007 14:16:10 +0100
Message-ID: <1195478172-17226-1-git-send-email-jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 14:17:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu6Ua-0006uS-0w
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 14:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbXKSNQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 08:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752510AbXKSNQb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 08:16:31 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:50007 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbXKSNQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 08:16:30 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1406693nfb
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 05:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:subject:date:message-id:x-mailer;
        bh=duY8wgd2fITp16C2TB8BDXp1Rhfh6JnCd+zCI2+xvp4=;
        b=eEBaAsi0g39EnGrV2BmJ0njqQP1vENCprVx52HxRT0/tuHbbCPXLz2k9E4W8jikaYltIlbUr3l0tVYJaoEAdX9oFUUd7luxMiY3Dat1oULp10x5CLfcVPV/V4io5CUrMP/3rUf4lNLrZPo74kMs970EWF1GveaoWBsVirerTqr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:message-id:x-mailer;
        b=Ee90p2BT4uSuOiE3ZceJjruolLZCmMlxzqRNXRcEH9AS8h7gisv+b5L4xfnCiJpEOn/h36NrKvARSeUQZcKS+BDx4sX4iyi78Nq1FfJ0eOIZ72QVUrTZGGMMT9uRzp99TZBRMls6StkI9ppQ32E/6BB502S4SUU9uxGz7riSZx4=
Received: by 10.86.84.5 with SMTP id h5mr3740727fgb.1195478188981;
        Mon, 19 Nov 2007 05:16:28 -0800 (PST)
Received: from roke.D-201 ( [83.8.241.246])
        by mx.google.com with ESMTPS id o11sm8781118fkf.2007.11.19.05.16.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Nov 2007 05:16:28 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lAJDGIPM017260
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 14:16:19 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lAJDGDbW017259
	for git@vger.kernel.org; Mon, 19 Nov 2007 14:16:13 +0100
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65437>

This series of (independent) patches is low hanging fruit of gitweb's
CSS cleanup and fixes. In the second part I plan on large
reorganization of CSS file to make it easier to read, understand,
and modify.

Jakub Narebski (2):
      gitweb: Style all tables using CSS
      gitweb: Put project README in div.readme, fix its padding

Diffstat:
 gitweb/gitweb.css  |    8 ++++----
 gitweb/gitweb.perl |   26 ++++++++++++++------------
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
Jakub Narebski
