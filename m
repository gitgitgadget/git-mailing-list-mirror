From: tilo@tilo-schwarz.de
Subject: [tig PATCH 0/1] Make height of split view configurable
Date: Mon, 23 Feb 2009 23:24:02 +0100
Message-ID: <cover.1235338009.git.tilo@tilo-schwarz.de>
Cc: git@vger.kernel.org, Tilo Schwarz <tilo@tilo-schwarz.de>
To: jonas.fonseca@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 23 23:25:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbjF9-0002fI-U9
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 23:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755641AbZBWWYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 17:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754897AbZBWWYM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 17:24:12 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:55883 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659AbZBWWYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 17:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1235427848; l=627;
	s=domk; d=tilo-schwarz.de;
	h=Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=+s4pQoyGCieDq2JpNPKWnhjFnZMa6jqqy5hVjvagHTY=;
	b=xI6zOjccMlFPkCVcLQWoQDaZAep2EzhTQVzd3UdM9/wlVqeS1EkSjE1Vl8Ia01wFtHh
	7tydOdy09DPOBFSe8QoGdRCZS3n7am+T1T1CQLu1+/4tAHfnu5nveHa84yyv/IEHKYah8
	CfbtGEvKa87rtoGZtf+xWe0tfa6qUQhaftQ=
X-RZG-AUTH: :IW0NeWC8cvPlgn0IPTehqi9r6o/0DSXjJ1Me0yWdPTUrUVR0TMXac2ZAlsJ41cQl
X-RZG-CLASS-ID: mo00
Received: from dellschleppa (p549CF809.dip.t-dialin.net [84.156.248.9])
	by post.strato.de (fruni mo28) (RZmta 18.21)
	with ESMTP id 305965l1NLcV1x ; Mon, 23 Feb 2009 23:24:05 +0100 (MET)
Received: by dellschleppa (sSMTP sendmail emulation); Mon, 23 Feb 2009 23:24:03 +0100
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111174>

Rationale: On a large display with many rows it would be nice to be
able to configure the heights of the views in the split view. For
example, I like to have the lower diff view be 90% of the total
view height.

As it is, the patch lets the height of the lower view be configurable.
Is it may be better to configure the height of the upper view? 

Any input on variable nameing, code style etc. of course welcome.


Tilo Schwarz (1):
  Make height of split view configurable

 NEWS        |    3 +++
 tig.c       |   30 +++++++++++++++++++-----------
 tigrc.5.txt |    8 ++++++++
 3 files changed, 30 insertions(+), 11 deletions(-)
