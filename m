From: Manish Patel <manishpatel2280@gmail.com>
Subject: Re: error: insufficient permission
Date: Fri, 16 Dec 2011 00:09:54 -0800 (PST)
Message-ID: <1324022994789-7099986.post@n2.nabble.com>
References: <4AB73A07.3020703@bioinf.uni-leipzig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 09:10:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbSrg-0004uC-Q5
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 09:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759523Ab1LPIJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 03:09:56 -0500
Received: from sam.nabble.com ([216.139.236.26]:60152 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174Ab1LPIJz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 03:09:55 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <manishpatel2280@gmail.com>)
	id 1RbSra-0005pT-RQ
	for git@vger.kernel.org; Fri, 16 Dec 2011 00:09:54 -0800
In-Reply-To: <4AB73A07.3020703@bioinf.uni-leipzig.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187265>

Very simple.. just find out .git directory give 0777 permission to objects
dir.. such as..

chmod -R 0777 objects

--
View this message in context: http://git.661346.n2.nabble.com/error-insufficient-permission-tp3683868p7099986.html
Sent from the git mailing list archive at Nabble.com.
