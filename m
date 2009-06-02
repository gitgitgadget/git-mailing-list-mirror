From: "Chris Friesen" <cfriesen@nortel.com>
Subject: git and multiple cores
Date: Tue, 02 Jun 2009 16:40:12 -0600
Message-ID: <4A25AA4C.9070600@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 03 00:40:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBcet-00037p-3S
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 00:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbZFBWkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 18:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbZFBWkS
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 18:40:18 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:49939 "EHLO
	zrtps0kp.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333AbZFBWkR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 18:40:17 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zrtps0kp.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id n52MeHM13178
	for <git@vger.kernel.org>; Tue, 2 Jun 2009 22:40:17 GMT
Received: from [47.130.80.200] ([47.130.80.200] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Jun 2009 18:40:17 -0400
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
X-OriginalArrivalTime: 02 Jun 2009 22:40:17.0240 (UTC) FILETIME=[1A1BBD80:01C9E3D3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120554>


I'm using git 1.6.1.3 and it seems to be limited to a single core.
Given that I've seen cases where the cpu has been basically pinned for
minutes on end (initial clone of a repository, for instance) has there
been any discussion of taking advantage of multiple cores?

Chris
