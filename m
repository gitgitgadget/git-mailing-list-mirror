From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 0/4] fast-import: add a new option command
Date: Wed, 12 Aug 2009 22:09:42 -0700
Message-ID: <1250140186-12363-1-git-send-email-srabbelier@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbSa3-0001mT-85
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917AbZHMFKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752880AbZHMFKP
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:10:15 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:1751 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbZHMFKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:10:14 -0400
Received: by rv-out-0506.google.com with SMTP id f6so169015rvb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 22:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=bem97s4lbtDBkgaSkd77OnDSQIEsySVCmR/JCInupZ8=;
        b=mMh6tLBf7Xy8QwkWJD1EPGjrvRnkDIQ+LWtdNUz3bD6Gdwu3KOTxRm5KNVv+/yzGIE
         wJCnj4QrCbDbvaBXgp9P5tp9oAahtkjWEg6yJ5yH+7WKXYts0njkhGY9S9V2k8s3LAaR
         k9XEmjddDfwhIKUeThkbITvpT+9qjobBR+zPA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=scCOcX2wjBILrXc5kBWEbSLu+JiJlpjMAlum8kCf3mVSDy6hnQ2zuQv/3HbQWTVEJM
         HBQ4InD/hKERRITWSjQXbNpLqP3Rnqkwho5kBDUgZyIn6CC9AWy7WDk86iEGlLxci4ln
         d3XPK5DTn4LoPxceSLIbcRXxRoBf80FHfslAQ=
Received: by 10.140.174.14 with SMTP id w14mr379945rve.198.1250140215690;
        Wed, 12 Aug 2009 22:10:15 -0700 (PDT)
Received: from localhost.localdomain ([173.8.183.73])
        by mx.google.com with ESMTPS id g14sm6740240rvb.20.2009.08.12.22.10.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 22:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.16.g72c66.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125777>

Sverre Rabbelier (4):
      fast-import: put option parsing code in seperate functions
      fast-import: define a new option command
      fast-import: add option command
      fast-import: test the new option command

 Documentation/git-fast-import.txt |   23 ++++++
 fast-import.c                     |  149 +++++++++++++++++++++++++++----------
 t/t9300-fast-import.sh            |   33 ++++++++
 3 files changed, 165 insertions(+), 40 deletions(-)
