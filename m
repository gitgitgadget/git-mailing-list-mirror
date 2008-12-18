From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 0/4] gitweb: patch view
Date: Thu, 18 Dec 2008 08:13:15 +0100
Message-ID: <1229584399-23879-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 08:14:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDD5k-0007I7-Qq
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 08:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbYLRHNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 02:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYLRHNU
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 02:13:20 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:15163 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbYLRHNU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 02:13:20 -0500
Received: by fg-out-1718.google.com with SMTP id 19so119795fgg.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 23:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1KmLqDsipd7En0isSvuvpLmA/N7CDtGqevGqaVOjgGE=;
        b=ruXubMh7nK8FetfDFW4vEOANhVxcEwBWN78WS+Coo9hdwNEZMpPL+S36439uLLqzSm
         w1x8kgxYW3gzPUkfzPL9K1OTwP9c9IaBMah9403DYKrWAy5WDeiOGue25EgiVmfjg1ri
         V3EsiS43P6W71Q1zu8hsWE3GGN6xmDrDpQo7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bdbGnwNiS6JK7V4swOpg8Ubq1qyWQrZa37vCchi1Q+HtaJrjmJUzq+4Uz4KC5odkOn
         E7fDdZg0ckmhSJkugdkCiz/l5sfYGoZzDgAFQV4SPEuc7Smd3UrMnPP7qopxxA5k+iHB
         TOmGW5gsO1D68tqkhp3Jqbo9j3IU/Fr+WJA1s=
Received: by 10.86.60.14 with SMTP id i14mr931026fga.21.1229584398364;
        Wed, 17 Dec 2008 23:13:18 -0800 (PST)
Received: from localhost ([78.13.57.58])
        by mx.google.com with ESMTPS id l19sm4860571fgb.6.2008.12.17.23.13.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Dec 2008 23:13:17 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103437>

Sixth iteration of the patch view in gitweb, that exposes the
git-format-patch output directly, allowing patchset exchange via gitweb.

As suggested by Junio, the call pattern for git_commitdiff is changed to
use named parameters even for the first parameter (-format).

Giuseppe Bilotta (4):
  gitweb: add patch view
  gitweb: change call pattern for git_commitdiff
  gitweb: add patches view
  gitweb: link to patch(es) view in commit(diff) and (short)log view

 gitweb/gitweb.perl |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 108 insertions(+), 1 deletions(-)
