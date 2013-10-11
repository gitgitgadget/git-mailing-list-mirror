From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/2] HTTP GSS-Negotiate improvements
Date: Fri, 11 Oct 2013 22:35:43 +0000
Message-ID: <1381530945-90590-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 00:35:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUlJK-0003Ab-6T
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 00:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184Ab3JKWfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 18:35:50 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32956 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751828Ab3JKWft (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Oct 2013 18:35:49 -0400
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E2D7B2807A;
	Fri, 11 Oct 2013 22:35:48 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.236.g382490f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235923>

This patch set adds an option, http.continue, to enable requests for 100
Continue responses when pushing over HTTP.  This is needed for large pushes
using GSS-Negotiate authentication.

Changes from v1:
* Default to disabled.

brian m. carlson (2):
  http: add option to enable 100 Continue responses
  Update documentation for http.continue option

 Documentation/config.txt | 9 +++++++++
 http.c                   | 6 ++++++
 http.h                   | 1 +
 remote-curl.c            | 7 ++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

-- 
1.8.4.rc3
