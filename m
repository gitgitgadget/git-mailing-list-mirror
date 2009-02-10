From: Mark Burton <markb@ordern.com>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with
 an asterisk
Date: Tue, 10 Feb 2009 00:03:21 +0000
Organization: Order N Ltd.
Message-ID: <20090210000321.78025483@crow>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
	<alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 01:10:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWgCP-0001cg-6Z
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 01:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbZBJAIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 19:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZBJAIe
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 19:08:34 -0500
Received: from c2bthomr14.btconnect.com ([213.123.20.132]:1450 "EHLO
	c2bthomr14.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752592AbZBJAId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 19:08:33 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Feb 2009 19:08:33 EST
Received: from crow.ordern.com (host86-128-142-98.range86-128.btcentralplus.com [86.128.142.98])
	by c2bthomr14.btconnect.com
	with ESMTP id CLA02617;
	Tue, 10 Feb 2009 00:03:21 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 9FDCB190CF8
	for <git@vger.kernel.org>; Tue, 10 Feb 2009 00:03:21 +0000 (GMT)
In-Reply-To: <alpine.DEB.1.00.0902100048410.10279@pacific.mpi-cbg.de>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr14.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B020A.4990C451.00B1,ss=1,fgs=0,
	ip=86.128.142.98,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109164>


Hi,

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Let's hope that nobody's scripts rely on a single star in front of the 
> local HEAD...

I don't know if I have any scripts that rely on a single star in front of
the local HEAD or not (I'm sure some people must have them), but I do
think this new feature would be very confusing, especially when used
with -a.

At the very least, make the indicator something other than a star, an @
or #, perhaps.

Cheers,

Mark
