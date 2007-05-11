From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] user-manual: Use "git config --global" instead of editing
 ~/.gitconfig
Date: Fri, 11 May 2007 09:22:34 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705110916580.24220@xanadu.home>
References: <200705102353.31821.johan@herland.net>
 <20070510220253.GZ13719@fieldses.org> <20070510230045.GF4489@pasky.or.cz>
 <20070511034653.GB26896@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@suse.cz>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Fri May 11 15:22:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmV56-0002I8-V1
	for gcvg-git@gmane.org; Fri, 11 May 2007 15:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758502AbXEKNWo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 09:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758526AbXEKNWo
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 09:22:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11898 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758502AbXEKNWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 09:22:43 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHV00AWFP5OWDH1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 11 May 2007 09:22:36 -0400 (EDT)
In-reply-to: <20070511034653.GB26896@fieldses.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46958>

On Thu, 10 May 2007, J. Bruce Fields wrote:

> So while I'm not convinced of the value of consistency here, if we have
> to have consistency, I'd rather standardize on config-file-editing.

Why not simply providing both?

	You can modify your config with the following commands:

	...

	Alternatively, you might edit your ~/.gitconfig directly as 
	well with the following content:

	...

Wouldn't that be clearer?  This way there is no confusion since it is 
clear up front that both methods are equivalent, and the user can choose 
between them.

For one, I prefer the git-config method even if I do edit source files 
all day long.  It just seems faster to me.


Nicolas
