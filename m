From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Please make git-am handle \r\n-damaged patches
Date: Mon, 03 Aug 2009 12:08:32 -0700
Message-ID: <4A7735B0.2040703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 03 21:08:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY2tr-000053-00
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 21:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbZHCTIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 15:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754420AbZHCTIe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 15:08:34 -0400
Received: from terminus.zytor.com ([198.137.202.10]:51186 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbZHCTIc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 15:08:32 -0400
Received: from anacreon.sc.intel.com (hpa@localhost [127.0.0.1])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n73J8WMg017893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 3 Aug 2009 12:08:32 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
X-Virus-Scanned: ClamAV 0.94.2/9648/Mon Aug  3 06:27:08 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124718>

In a serious case of craniorectal immersion, the Thunderbird developers
have started using \r\n line endings on saved emails:

https://bugzilla.mozilla.org/show_bug.cgi?id=503271
https://bugzilla.mozilla.org/show_bug.cgi?id=507530

It would be nice if git-am could handle this case automatically.

	-hpa
