From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 0/3] gitweb: make static files accessible with PATH_INFO
Date: Sat, 31 Jan 2009 02:31:49 +0100
Message-ID: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 02:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4jS-0000JH-7o
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 02:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbZAaBbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 20:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbZAaBbs
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 20:31:48 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:32199 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZAaBbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 20:31:48 -0500
Received: by fk-out-0910.google.com with SMTP id f33so664359fkf.5
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 17:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=roSglN91Y6od9ct7X5DzS8Rk/46pukZlXAUjo0bls7E=;
        b=FnrNYZf+L4LcNt+1xQvkucd+Pf7JOIjkg/yQwfFMavVcMEprwcBMRGSwSTzRN5VjOW
         xd72pvkNUrpgNRwr1uzr13Rl4F8i0TtE59ZWElKR5RLw/gMud/qAqmwvoHIMBst2ONgG
         +4gqQytVcWyHrPgLgsJHdQG9yveSxgwi5/pig=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=J4ufcfz7/bbZojqkns8eu4TbnQew9b7T9+sr4j0Q81HD8VZAvTmfZB9l+2UTqhpOLO
         /fEBn7ouTccfU+/ccBctQkeA5Scn4IzvagDPg+hZaT62Y7QCym6qOsYtDNugcpPKtTkp
         YQbghOZXVPIHn9QWHz0qKSfvXsuyZn2CR+O9g=
Received: by 10.181.224.3 with SMTP id b3mr639416bkr.183.1233365506583;
        Fri, 30 Jan 2009 17:31:46 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id k29sm1602266fkk.16.2009.01.30.17.31.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 17:31:46 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107898>

This patchset includes

1. the single patch to make static files accessible with PATH_INFO, with
   the same quoting standard as the nearby code;
2. an additional patch that extends the README with some examples on how
   to configure Apache to use gitweb with PATH_INFO enabled by default
   (and gitweb as directory index);
3. the repeatedly recommended comment fix to align comments to code in the
   git_header_html() sub.

Giuseppe Bilotta (3):
  gitweb: make static files accessible with PATH_INFO
  gitweb: webserver config for PATH_INFO
  gitweb: align comments to code

 gitweb/README      |   76 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |    9 +++++-
 2 files changed, 83 insertions(+), 2 deletions(-)
