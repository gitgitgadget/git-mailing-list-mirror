From: Andrew Ruder <andy@aeruder.net>
Subject: Re: problem pushing repository
Date: Thu, 21 Jun 2007 21:24:26 -0500
Message-ID: <20070622022426.GA2961@bowser.ruder>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com> <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 22 04:42:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Z6m-000623-GR
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 04:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXFVCmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 22:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbXFVCmr
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 22:42:47 -0400
Received: from aeruder.net ([208.78.97.67]:43211 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbXFVCmq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 22:42:46 -0400
X-Greylist: delayed 1089 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Jun 2007 22:42:46 EDT
Received: from aeruder (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id C780B2204CD
	for <git@vger.kernel.org>; Fri, 22 Jun 2007 02:24:36 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50666>

On Thu, Jun 21, 2007 at 07:00:18PM -0700, Junio C Hamano wrote:
> 	$ ssh newberry.ihepa.ufl.edu sh -c 'echo $PATH'
> 
> may be a good starting point to test this, and the first step
> to fix it would be
> 
> 	$ man ssh
> 	$ man sshd

While I wholeheartedly agree with Junio here, you may also find

remote.<name>.receivepack

useful, see git-push(1) and git-config(1) for more information.

- Andy

-- 
Andrew Ruder <andy@aeruder.net>
http://www.aeruder.net
