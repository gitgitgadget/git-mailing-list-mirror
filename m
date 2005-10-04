From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 17:46:40 +0200
Message-ID: <20051004154640.GC4682@kiste.smurf.noris.de>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0510031606550.31407@g5.osdl.org> <20051004071210.GA18716@localdomain> <Pine.LNX.4.63.0510040321170.23242@iabervon.org> <pan.2005.10.04.14.18.59.102722@smurf.noris.de> <434296F1.5030006@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 17:50:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMp0e-0006rQ-H6
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 17:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVJDPrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 11:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbVJDPrL
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 11:47:11 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:46214 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S964821AbVJDPrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 11:47:09 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EMp05-0007MW-8W; Tue, 04 Oct 2005 17:47:00 +0200
Received: (nullmailer pid 16299 invoked by uid 501);
	Tue, 04 Oct 2005 15:46:40 -0000
To: "H\. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <434296F1.5030006@zytor.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9682>

Hi,

H. Peter Anvin:
> >I would however assume that *nobody* sets both the send and receive
> >buffers such that their cumulative size is <4k, so 99 object IDs
> >at 41 bytes definitely should be OK.
> 
> For TCP, I think we should simply get our own (or set) packet buffer 
> size and conform to it.  Problem solved...

Actually, it isn't -- if you have a ssh connection, you don't have
access to the raw TCP socket.

Just limit the number of objects in flight to 20 or so.
Problem also solved.  ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
He hated to set precedents; those who did so were sometimes promoted, more
frequently they joined their ancestors.
					-- Robert A. Heinlein
