From: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20=28Grubba=29?= 
	<grubba@grubba.org>
Subject: [PATCH v2 0/3] Handling of gitattribute macro expansion
Date: Fri,  2 Apr 2010 21:33:38 +0200
Message-ID: <cover.1270236242.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Henrik=20Grubbstr=C3=B6m=20 (Grubba) ?= 
	<grubba@grubba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 21:34:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxmcx-00037n-8B
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab0DBTdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 15:33:54 -0400
Received: from mail.roxen.com ([212.247.29.220]:52918 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab0DBTdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 15:33:52 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id A927C62817A
	for <git@vger.kernel.org>; Fri,  2 Apr 2010 21:33:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id evzOylpr1GcJ; Fri,  2 Apr 2010 21:33:50 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 11C59628156;
	Fri,  2 Apr 2010 21:33:50 +0200 (CEST)
Received: from shipon.roxen.com (localhost [127.0.0.1])
	by shipon.roxen.com (8.13.8+Sun/8.13.8) with ESMTP id o32JXnZD026554;
	Fri, 2 Apr 2010 21:33:49 +0200 (CEST)
Received: (from grubba@localhost)
	by shipon.roxen.com (8.13.8+Sun/8.13.8/Submit) id o32JXnaA026553;
	Fri, 2 Apr 2010 21:33:49 +0200 (CEST)
X-Mailer: git-send-email 1.7.0.3.316.g33b5e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143840>

Second try at handling macro expansion in gitattribute files
in a deterministic way.

Henrik Grubbstr=C3=B6m (Grubba) (3):
  Attr: Fixed debug output for macro expansion.
  Attr: Allow multiple changes to an attribute on the same line.
  Attr: Expand macros immediately when encountered.

 attr.c                |   38 ++++++++++++++++++++++++--------------
 t/t0003-attributes.sh |   15 +++++++++++++++
 2 files changed, 39 insertions(+), 14 deletions(-)
