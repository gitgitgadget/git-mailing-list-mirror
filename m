From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Fri, 19 May 2006 17:35:48 -0700
Message-ID: <7vy7wxfs7v.fsf@assigned-by-dhcp.cox.net>
References: <e4f1ta$e07$1@sea.gmane.org> <87y7wyv72m.fsf@morpheus.hq.vtech>
	<20060519092136.GN22257@spearce.org>
	<Pine.LNX.4.64.0605192006400.6713@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 02:36:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhFRo-0002iW-3C
	for gcvg-git@gmane.org; Sat, 20 May 2006 02:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWETAfu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 20:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWETAfu
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 20:35:50 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:11212 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751449AbWETAft (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 20:35:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060520003548.TNBM18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 20:35:48 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0605192006400.6713@iabervon.org> (Daniel
	Barkalow's message of "Fri, 19 May 2006 20:28:22 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20369>

Daniel Barkalow <barkalow@iabervon.org> writes:

> $ git pull . stuff
> # Notice that the diffstat is exciting
> # What did I just get?
> $ git log master@{5 minutes ago}..master
>
> This is about the only easy way to find out that the fast-forward you just 
> did included merging a line which contains a commit from several weeks 
> ago. (Because the "before" state isn't easily accessible for a 
> fast-forward, and the date of the old commit puts it way back in a 
> date-ordered log.)

Did you forget about "git log ORIG_HEAD.."?
