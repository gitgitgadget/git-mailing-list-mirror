From: "H. Peter Anvin" <hpa@zytor.com>
Subject: .git/info/refs
Date: Tue, 23 Jan 2007 23:38:46 -0800
Message-ID: <45B70D06.3050506@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 08:38:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9cie-0000ou-Dk
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 08:38:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183AbXAXHiy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 02:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933186AbXAXHix
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 02:38:53 -0500
Received: from terminus.zytor.com ([192.83.249.54]:39392 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933183AbXAXHix (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 02:38:53 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0O7clLr028478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 23 Jan 2007 23:38:47 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
X-Virus-Scanned: ClamAV 0.88.7/2481/Tue Jan 23 14:10:15 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.5 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_48_96 autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37612>

Would it be an incompatible change to add the commit date (and perhaps 
the author date) to .git/info/refs?  I believe that would make it 
possible to dramatically (orders of magnitude) speed up the generation 
of the gitweb index page, which is easily the most expensive gitweb page 
to generate.

	-=hpa
