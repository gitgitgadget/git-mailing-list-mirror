From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Document "commit --only".
Date: Sun, 06 May 2007 19:13:41 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705061908430.24220@xanadu.home>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
 <11784859173725-git-send-email-Matthieu.Moy@imag.fr>
 <11784859182473-git-send-email-Matthieu.Moy@imag.fr>
 <11784859184184-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 07 01:13:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkpvJ-0000jG-LO
	for gcvg-git@gmane.org; Mon, 07 May 2007 01:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXEFXNn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbXEFXNn
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 19:13:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48271 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbXEFXNn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 19:13:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHN00ANZ76T0710@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 06 May 2007 19:13:41 -0400 (EDT)
In-reply-to: <11784859184184-git-send-email-Matthieu.Moy@imag.fr>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46396>

On Sun, 6 May 2007, Matthieu Moy wrote:

> The documentation was there earlier, but removed by
> 4170a19587280eeb3663a47a6fd993910de78076.
> 
> That option being the default now, it could perhaps be actually
> removed, but since it is there, and mentionned in the SYNOPSIS, it
> should be actually documented.

I don't think this is a good idea either.

> +-o|--only::
> +	Commit only the files specified on the command line.
> +	This format cannot be used during a merge. This is the
> +	default.

This looks really confusing.  This is the default _only_ if files are 
specified on the command line.

IMHO I'd rather remove the option from the synopsis and flag it as 
scheduled for removal in the source instead.


Nicolas
