From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] setup/rev-parse: allow HEAD to be spelled 'head'
Date: Fri, 5 Oct 2007 08:51:39 +0200
Message-ID: <20071005065139.GA2623@steel.home>
References: <1191553750-25562-1-git-send-email-sam.vilain@catalyst.net.nz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Oct 05 08:51:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idh2O-0005jI-DN
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 08:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804AbXJEGvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 02:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbXJEGvn
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 02:51:43 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:8927 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbXJEGvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 02:51:43 -0400
Received: from tigra.home (Fc941.f.strato-dslnet.de [195.4.201.65])
	by post.webmailer.de (fruni mo64) (RZmta 13.4)
	with ESMTP id t02e4dj955mfvM ; Fri, 5 Oct 2007 08:51:40 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 6F62B277AE;
	Fri,  5 Oct 2007 08:51:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0AC94C772; Fri,  5 Oct 2007 08:51:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1191553750-25562-1-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPn7A==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60040>

Sam Vilain, Fri, Oct 05, 2007 05:09:10 +0200:
> If the repository got mangled by FAT capitalization rules, then a ref
> such as "HEAD" will become "head" once it is back on a non-FAT FS.
> Check for this condition in resolve_refs and in the setup code.
> 
> Suggested-by: Francois Marier <francois@debian.org>
> Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
> ---
>   This should probably help people putting their git repos on
>   FAT USB sticks.

Can the people just mount FAT partitions with shortname=mixed?
