From: Nicolas Pitre <nico@cam.org>
Subject: Re: specify charset for commits
Date: Fri, 22 Dec 2006 10:31:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612221030440.18171@xanadu.home>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus>
 <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com>
 <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 16:31:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxmNK-00062L-0T
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 16:31:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422884AbWLVPbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 10:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWLVPbz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 10:31:55 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17803 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030199AbWLVPby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 10:31:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAO00GAXLT5L6E0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 22 Dec 2006 10:31:54 -0500 (EST)
In-reply-to: <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
X-X-Sender: nico@xanadu.home
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35182>

On Fri, 22 Dec 2006, Johannes Schindelin wrote:

> Hi,
> 
> On Thu, 21 Dec 2006, Junio C Hamano wrote:
> 
> >  (2) update commit-tree to reject non utf-8 log messages and
> >      author/committer names when i18n.commitEncoding is _NOT_
> >      set, or set to utf-8.
> 
> The problem is: you cannot easily recognize if it is UTF8 or not, 
> programatically. There is a good indicator _against_ UTF8, namely the 
> first byte can _only_ be 0xxxxxxx, 110xxxxx, 1110xxxx, 11110xxx. But there 
> is no _positive_ sign that it is UTF8. For example, many umlauts and other 
> special modifications to letters, stay in the range 0x7f-0xff.

Still... that would be a good enough thing to have in the majority of 
cases, wouldn't it?


Nicolas
