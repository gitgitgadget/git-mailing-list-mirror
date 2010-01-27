From: Frans Pop <elendil@planet.nl>
Subject: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 08:19:39 +0100
Message-ID: <201001270819.39819.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 08:19:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na2Bq-0005XH-0u
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 08:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab0A0HTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 02:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564Ab0A0HTm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 02:19:42 -0500
Received: from cpsmtpm-eml102.kpnxchange.com ([195.121.3.6]:51908 "EHLO
	CPSMTPM-EML102.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1749667Ab0A0HTm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 02:19:42 -0500
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML102.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 27 Jan 2010 08:19:39 +0100
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 27 Jan 2010 07:19:40.0006 (UTC) FILETIME=[16E0F860:01CA9F21]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138109>

I'm currently using the following command for this:
   git log --pretty=format:%H | grep -q '^<commit id>"

Problem is that with large repos that can be quite slow.

Is there a faster way to do the test?

TIA,
FJP
