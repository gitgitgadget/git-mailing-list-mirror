From: Nicolas Pitre <nico@cam.org>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 16:00:23 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702151557410.1757@xanadu.home>
References: <17876.51013.561979.431717@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 22:00:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHniP-0005d8-8o
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 22:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbXBOVAZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 16:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161256AbXBOVAZ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 16:00:25 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62472 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161255AbXBOVAY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 16:00:24 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDI00LHCVON6IC0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Feb 2007 16:00:23 -0500 (EST)
In-reply-to: <17876.51013.561979.431717@lisa.zopyra.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39849>

On Thu, 15 Feb 2007, Bill Lear wrote:

> We are about to switch to git 1.5 from git 1.4.4.1.  I cannot remember
> if someone posted about this, but what is the danger of working on a
> tracking branch --- there are abundant cautions about doing this, but
> I can't recall and can't find the reason this is bad.

A tracking branch is supposed to be a local mirror of what is available 
remotely.  If you commit local changes to it then you break that model.

This is why with Git 1.5.0 tracking branches are in a different 
namespace by default to which you cannot commit.


Nicolas
