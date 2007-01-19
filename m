From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Documentation/git.txt: command re-classification
Date: Fri, 19 Jan 2007 17:08:53 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701191437450.3011@xanadu.home>
References: <Pine.LNX.4.64.0701181713200.2577@xanadu.home>
 <7v1wlrle61.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 23:09:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H81uu-0001CF-8E
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:09:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbXASWIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 17:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbXASWIy
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:08:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:37003 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964942AbXASWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:08:54 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JC4004AEYUTLRJ0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 19 Jan 2007 17:08:53 -0500 (EST)
In-reply-to: <7v1wlrle61.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37207>

On Thu, 18 Jan 2007, Junio C Hamano wrote:

>  * I unfortunately had to drop your patch on the floor, because
>    I was cooking a few patches to automate the maintenance of
>    the command list (which are now in 'master' and the product is
>    being served at www.kernel.org/pub/software/scm/git/docs/),
>    which majorly conflicted with your work.
> 
>    So here is a counterproposal; I moved commands across groups
>    after looking at what your patch did, but classified some of
>    them differently.

OK.  But I think the following are still misclassified:

  git-rev-parse
  git-runstatus
  git-fsck-objects

> +The interface (input, output, set of options and the semantics)
> +to these low-level commands are meant to be a lot more stable
> +than Porcelain level commands, because these commands are
> +primarily for scripted use.  To put it another way, the
> +interface to Plumbing commands are subject to change in order to
> +improve the end user experience.

I think the "to put it another way" sentence is a bit confusing here.


Nicolas
