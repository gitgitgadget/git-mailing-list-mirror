From: Mark Burton <markb@ordern.com>
Subject: git describe --tags --long barfs on new tags?
Date: Wed, 2 Jul 2008 15:45:06 +0100
Organization: Order N Ltd.
Message-ID: <20080702154506.7b83bae8@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 16:51:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE3ft-0007Io-8w
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbYGBOuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 10:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYGBOuP
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:50:15 -0400
Received: from c2beaomr05.btconnect.com ([213.123.26.183]:20411 "EHLO
	c2beaomr05.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701AbYGBOuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 10:50:14 -0400
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jul 2008 10:50:14 EDT
Received: from crow.ordern.com (host86-128-141-55.range86-128.btcentralplus.com [86.128.141.55])
	by c2beaomr05.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id AMT67167;
	Wed, 2 Jul 2008 15:45:06 +0100 (BST)
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 5545F190EC1
	for <git@vger.kernel.org>; Wed,  2 Jul 2008 15:45:06 +0100 (BST)
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr05.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0205.486B9473.0060,ss=1,fgs=0,
	ip=86.128.141.55,
	so=2007-10-30 19:00:17,
	dmn=5.4.3/2008-02-01
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87148>


Howdy folks,

Discovered this today:

~/git[master]$ git tag mb
~/git[master]$ git describe 
v1.5.6.1-156-ge903b40
~/git[master]$ git describe --tags
mb
~/git[master]$ git describe --tags --long
Segmentation fault (core dumped)

Hope this is useful info.

BTW - just started using git and I am very impressed with it - took me a while to get my head around the "index" but now I wonder what the problem was.

Cheers,

Mark
