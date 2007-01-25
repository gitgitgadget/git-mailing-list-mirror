From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Consolidate {receive,fetch}.unpackLimit
Date: Wed, 24 Jan 2007 22:32:49 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701242231340.3011@xanadu.home>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
 <7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0701231101040.3011@xanadu.home>
 <7v1wljc3hb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 04:32:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9vM6-0006M3-DE
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 04:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbXAYDcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 22:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbXAYDcv
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 22:32:51 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36089 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbXAYDcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 22:32:50 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCE00JLVN6P7C10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 24 Jan 2007 22:32:49 -0500 (EST)
In-reply-to: <7v1wljc3hb.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37703>

On Wed, 24 Jan 2007, Junio C Hamano wrote:

> This allows transfer.unpackLimit to specify what these two
> configuration variables want to set.
> 
> We would probably want to deprecate the two separate variables,
> as I do not see much point in specifying them independently.

Well... since they're already there and not hurting anything I would let 
them live.  Never know how they might be useful.


Nicolas
