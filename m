From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Updated Kernel Hacker's guide to git
Date: Sun, 29 Jun 2008 22:49:36 -0400
Message-ID: <486849C0.7050703@garzik.org>
References: <200612241807.kBOI746w008739@laptop13.inf.utfsm.cl> <476E42BF.1010300@garzik.org> <Pine.LNX.4.64.0712310349260.2093@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 04:51:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD9UK-00066f-Jt
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 04:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbYF3CuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 22:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbYF3CuW
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 22:50:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59265 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496AbYF3Ctk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 22:49:40 -0400
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KD9ST-0000Fz-Dm; Mon, 30 Jun 2008 02:49:39 +0000
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <Pine.LNX.4.64.0712310349260.2093@fbirervta.pbzchgretzou.qr>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.4 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86865>

Jan Engelhardt wrote:
> On Dec 23 2007 06:13, Jeff Garzik wrote:
>> Another year, another update!  :)
>>
>> The kernel hacker's guide to git has received some updates:
>>
>> 	http://linux.yyz.us/git-howto.html
>>
> 
> It says
> 
> """Don't forget to download tags from time to time.
> 
> git pull only downloads sha1-indexed object data, and the requested
> remote head. This misses updates to the .git/refs/tags/ and
> .git/refs/heads/ directories. For tags, run git fetch --tags $URL."""
> 
> 
> But when I do git pull on a simple tracking tree (e.g. git-clone
> torvalds/linux-2.6.git; git pull;) it automatically grabs new tags.



Unfortunately tags are not copied in all cases.  To this day, I still 
have to 'git fetch --tags', generally when pulling from one local repo 
into another.  It's annoying that tags don't follow objects, when pulled.

	Jeff
