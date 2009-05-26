From: "H. Peter Anvin" <hpa@zytor.com>
Subject: RFE: "git bisect reverse"
Date: Tue, 26 May 2009 15:21:36 -0700
Message-ID: <4A1C6B70.4050501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 27 00:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9520-0003qJ-I6
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 00:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604AbZEZWVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 18:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758037AbZEZWVk
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 18:21:40 -0400
Received: from terminus.zytor.com ([198.137.202.10]:43931 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757606AbZEZWVj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 18:21:39 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n4QMLbQb006410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 May 2009 15:21:40 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Virus-Scanned: ClamAV 0.94.2/9393/Tue May 26 03:17:55 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120013>

I would like to request the following feature:

"git bisect reverse"

... does exactly the same thing as "git bisect start", except that it
flips the meaning of "good" and "bad".  It is mentally fairly taxing to
do a reverse bisection (looking for an antiregression) when one has to
flip the meaning of "good" and "bad" (which are very loaded words to our
psyche), and it's even worse to try to get a user to do it...

	-hpa
