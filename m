From: "Murphy, John" <john.murphy@bankofamerica.com>
Subject: Git Gui bug calling gitk
Date: Thu, 24 Jul 2008 09:01:48 -0400
Message-ID: <80915B5E107BED488500050294C6F48712136B@ex2k.bankofamerica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 15:03:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM0TC-0001Ao-B6
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 15:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYGXNBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 09:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbYGXNBw
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 09:01:52 -0400
Received: from vamx04.bankofamerica.com ([171.159.192.80]:37145 "EHLO
	vadmzmailmx04.bankofamerica.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751816AbYGXNBv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 09:01:51 -0400
Received: from vadmzmailmx01.bankofamerica.com ([171.182.200.78])
	by vadmzmailmx04.bankofamerica.com (8.13.6/8.13.6) with ESMTP id m6OD1nhG031350
	for <git@vger.kernel.org>; Thu, 24 Jul 2008 13:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bankofamerica.com;
	s=corp1; t=1216904510; bh=hDHU0RiDn0VTkzPexQ3GUD8z26WGih8Ois5y/B1ml
	do=; h=Received:Date:From:Subject:To:Message-id:MIME-version:
	 X-MIMEOLE:Content-type:Content-transfer-encoding:Content-class:
	 Thread-topic:Thread-index:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 X-OriginalArrivalTime:X-Proofpoint-Virus-Version; b=wh+eMZW+oZvRVv
	+01HvaFsCltovxwyyNb1YqWhDhiIq4m6xoIKnncYxIawYI5U7Gk6NyVy2XvdRQM5m62
	x+Jf/Ul0PgbzTKT3uS2pe/YvEkxo7I/Zn7Ydn04tPln9hmh1DgBndh+btRjNvUoKran
	QZxXchvE0lWNM0LvUFaHXVI=
Received: from memva2mta03.bankofamerica.com (memva2mta03.bankofamerica.com [171.186.140.81])
	by vadmzmailmx01.bankofamerica.com (8.13.6/8.13.6) with ESMTP id m6OD1n2o030657
	for <git@vger.kernel.org>; Thu, 24 Jul 2008 13:01:49 GMT
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
Thread-topic: Git Gui bug calling gitk
Thread-index: AcjtjQoIfKHCBjtmRlSAOUALxZzqPw==
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
X-OriginalArrivalTime: 24 Jul 2008 13:01:48.0880 (UTC) FILETIME=[6F048D00:01C8ED8D]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-07-24_03:2008-07-24,2008-07-24,2008-07-24 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89877>

I have recently installed git: v1.5.6.1-167-gbf270ab and git gui:
gitgui-0.10.2-8-g2add5cb

>From Git Gui we try to run Visualize Branch History and get the
following error:

Unable to start gitk:
c:/cygwin/usr/local/git/libexec/git-core/gitk does not exist

I presume this was just an oversight when git- commands were removed
from the bin directory.

-John Murphy
