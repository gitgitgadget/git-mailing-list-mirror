From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 0/4] gitweb feed metadata tuneups
Date: Fri, 23 Jan 2009 05:48:37 +0100
Message-ID: <1232686121-1800-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 23 05:49:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQDzN-00044x-A0
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 05:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbZAWEs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 23:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755259AbZAWEs2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 23:48:28 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:61810 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154AbZAWEs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 23:48:28 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2404923fgg.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 20:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HsPuuJvoMmV8HnQFDmTHTaixEP9cLb0YAB0rnsubBjg=;
        b=VB5rlECWmyBawVjGn7b51nHY8ppnGPCDbKh6iamulA1fAUi5Jm03IDz7NlFz5Lcd9P
         Ldclx6MT/G9tLN7bS6j1D9h0IDl4y1SRzExb7x06pOIDeY4DBiX/F3mRT2dwU+rGWTqU
         96UMshb+BCPm8NDskjD7ySGiButFIBEu21yG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vhJ6Ylb5WAiCQ9IE5/UUNQwE1eBjxouTlTjisNdyqK8zX9phmZKgS5tHTF0r+wtYPg
         99x6LY8b4Ze3EzDWjan6SgE61WuwPBcf8f/yPH+Q6bF6pO1yAiKx93zRKA9oBvLm/KC2
         iQKzwNuYLQYfC11OHC+hO/9qrUaf+OZAMA1P0=
Received: by 10.86.29.8 with SMTP id c8mr991422fgc.67.1232686106458;
        Thu, 22 Jan 2009 20:48:26 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id 3sm8453075fge.47.2009.01.22.20.48.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jan 2009 20:48:25 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106832>

The next four patches add some metadata to gitweb generated feeds:
channel image, managing editor and last-update dates are added to RSS
feeds, and the feed generator (gitweb, with version specification) is
added to both RSS and Atom feeds.

Giuseppe Bilotta (4):
  gitweb: channel image in rss feed
  gitweb: feed generator metadata
  gitweb: rss feed managingEditor
  gitweb: rss channel date

 gitweb/gitweb.perl |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)
