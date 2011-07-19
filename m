From: "J. Bakshi" <joydeep@infoservices.in>
Subject: Re: about directory management
Date: Tue, 19 Jul 2011 13:23:33 +0530
Message-ID: <20110719132333.1713c52b@shiva.selfip.org>
References: <20110719113706.0aca61b5@shiva.selfip.org>
	<4E253603.7020403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 09:53:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj57V-000263-Nx
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 09:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab1GSHx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 03:53:29 -0400
Received: from static.206.87.46.78.clients.your-server.de ([78.46.87.206]:46720
	"EHLO Kolkata.infoservices.in" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752476Ab1GSHx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2011 03:53:28 -0400
Received: from shiva.selfip.org (unknown [122.176.30.116])
	by Kolkata.infoservices.in (Postfix) with ESMTPSA id 878173804001;
	Tue, 19 Jul 2011 09:53:25 +0200 (CEST)
In-Reply-To: <4E253603.7020403@gmail.com>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177440>

On Tue, 19 Jul 2011 19:45:07 +1200
Chris Packham <judge.packham@gmail.com> wrote:

> On 19/07/11 18:07, J. Bakshi wrote:
> > Hello,
> > 
> > I need to add directory structure in my git repo where some of the directory are empty but still need to add those to maintain the structure. I also need to add directory as non-recursive, so that I can add the final child directory so get the structure. How can git help to do these ?
> > 
> > Thanks
> > --
> 
> One of the things that makes git different from other SCMs is that it
> tracks sets of changes (i.e. commits) not individual files/directories.
> My initial response is to tell you to create the directories when you've
> got something to put into them and not before. If they are needed for
> compilation of your code then make it part of the build process. If you
> do have a reason for needing empty directories the standard response is
> to put a .dummy file in the directory (you only need it in the deepest
> directory, not every directory on the path).
> 
> 

Thanks for your valuable clarification and notes.
