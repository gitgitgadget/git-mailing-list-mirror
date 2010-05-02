From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: RFD: Shipping GitBrowser.js for instaweb
Date: Sun, 02 May 2010 18:25:36 +0200
Message-ID: <4BDDA780.7090500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 02 18:30:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8c4D-0002dM-Gh
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 18:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab0EBQZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 12:25:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37522 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757202Ab0EBQZh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 May 2010 12:25:37 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8A691F2210
	for <git@vger.kernel.org>; Sun,  2 May 2010 12:25:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 02 May 2010 12:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=tOFkUf3F9NyIb89aQYU96BkPuyw=; b=rC2ryKHQnh2+5kvOmpuVLN86Xs7EdJOW/L0NQ/xLOtRQPol45rLAP0NP3j8KMICh0lKIEyK3QYka+ZtBFPKL0jTylT2OGxZo6V/BrMfX+ZWhmp5DUVe2c1gG2CiQc6kBptV5pYH2Wmge+jg+OAMNY3RPCdTIpJjm+sx7vLi8uJw=
X-Sasl-enc: cdPD31OcGFNbR9nfp6Pt1MKWCHQOTJLXWJ04fpbHsD13 1272817536
Received: from localhost.localdomain (p5DCC03EE.dip0.t-ipconnect.de [93.204.3.238])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 03F524C8887
	for <git@vger.kernel.org>; Sun,  2 May 2010 12:25:35 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146191>

Heya ;)

I was wondering whether it would make sense to ship GitBrowser.js with
Git and how much it would take to do so.

My personal answer to the 1st Q is Yes: instaweb as well as simple
gitweb installs would benefit from a graphical DAG viewer.

About the required effort I have no clue: I find it difficult to see
through which repo contains current gitweb, current repo.or.cz mods, and
especially the GitBrowser integration bits. Maybe we could ship the
integration bits without the actual GitBrowser if that is more feasible?

Michael
