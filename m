From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] import-tars: be nice to wrong directory modes
Date: Sat, 28 Apr 2007 18:07:20 -0700
Message-ID: <7vk5vwhttj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704290159230.29859@racer.site>
	<20070429000842.GR5942@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 03:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhxsr-00068K-OU
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 03:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbXD2BHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 21:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXD2BHW
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 21:07:22 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:36147 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbXD2BHW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 21:07:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429010721.DSJJ22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 21:07:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id sp7L1W0021kojtg0000000; Sat, 28 Apr 2007 21:07:20 -0400
In-Reply-To: <20070429000842.GR5942@spearce.org> (Shawn O. Pearce's message of
	"Sat, 28 Apr 2007 20:08:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45805>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> 
>> Some tars seem to have modes 0755 for directories, not 01000755. Do
>> not generate an empty object for them, but ignore them.
>
> This fix is small and corrects a rather ugly repository corruption,
> so I've applied it to my gfi-maint branch.

Good teamplay.  So you want me to pull gfi-maint to maint and
gfi-master to master?
