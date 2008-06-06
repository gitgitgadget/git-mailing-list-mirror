From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status
	-u|--untracked-files option
Date: Fri, 6 Jun 2008 08:32:06 +0200
Message-ID: <20080606063206.GA4181@steel.home>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org> <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 08:33:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4VVb-0006jQ-7v
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 08:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753525AbYFFGcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 02:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbYFFGcL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 02:32:11 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:13627 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066AbYFFGcK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 02:32:10 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMna1s/dNMs
Received: from tigra.home (Fa852.f.strato-dslnet.de [195.4.168.82])
	by post.webmailer.de (fruni mo64) (RZmta 16.41)
	with ESMTP id t030e2k5630uUS ; Fri, 6 Jun 2008 08:32:06 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C5A5A277BD;
	Fri,  6 Jun 2008 08:32:06 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8845956D28; Fri,  6 Jun 2008 08:32:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84030>

Marius Storm-Olsen, Tue, Jun 03, 2008 15:09:10 +0200:
> Determining untracked files can be a very slow operation on large trees.
> This commit adds a <mode> argument, which allows you to avoid showing the
> untracked files in a repository. Possible options are:
>     none   - Show no untracked files
>     normal - Show untracked files and directories
>     all    - Show all untracked files
> 
> If the optional argument is not specified, the option defaults to 'all'.

Looks very familiar:

    http://thread.gmane.org/gmane.comp.version-control.git/66183
