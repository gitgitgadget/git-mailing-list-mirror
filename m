From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Mon, 31 Dec 2007 03:50:22 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712310349260.2093@fbirervta.pbzchgretzou.qr>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl>
 <476E42BF.1010300@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 03:51:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9Ak2-0008B1-Jg
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 03:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbXLaCuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 21:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbXLaCuY
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 21:50:24 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:49193 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbXLaCuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 21:50:23 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id D2B96180C568F; Mon, 31 Dec 2007 03:50:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id C80031C05CE47;
	Mon, 31 Dec 2007 03:50:22 +0100 (CET)
In-Reply-To: <476E42BF.1010300@garzik.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69383>


On Dec 23 2007 06:13, Jeff Garzik wrote:
> Another year, another update!  :)
>
> The kernel hacker's guide to git has received some updates:
>
> 	http://linux.yyz.us/git-howto.html
>

It says

"""Don't forget to download tags from time to time.

git pull only downloads sha1-indexed object data, and the requested
remote head. This misses updates to the .git/refs/tags/ and
.git/refs/heads/ directories. For tags, run git fetch --tags $URL."""


But when I do git pull on a simple tracking tree (e.g. git-clone
torvalds/linux-2.6.git; git pull;) it automatically grabs new tags.
