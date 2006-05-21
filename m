From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] send-pack: allow skipping delta when sending pack
Date: Sun, 21 May 2006 02:14:32 -0700
Message-ID: <7v4pzjzqmf.fsf@assigned-by-dhcp.cox.net>
References: <20060521054827.GA18530@coredump.intra.peff.net>
	<7vy7wvx5o9.fsf@assigned-by-dhcp.cox.net>
	<20060521081435.GA4526@coredump.intra.peff.net>
	<e4p83e$uqt$1@sea.gmane.org>
	<20060521084403.GB12825@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 11:14:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhk1E-0004TH-SI
	for gcvg-git@gmane.org; Sun, 21 May 2006 11:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWEUJOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 05:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEUJOe
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 05:14:34 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:37350 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932331AbWEUJOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 05:14:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521091433.YRYD27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 05:14:33 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060521084403.GB12825@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 21 May 2006 04:44:03 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20444>

Jeff King <peff@peff.net> writes:

> On Sun, May 21, 2006 at 10:24:37AM +0200, Jakub Narebski wrote:
>
>> Hmmm... isn't the patch slightly against git coding style?
>
> Oops, yes (though the point is moot since the patch is conceptually
> wrong). Is there a git coding style document somewhere?

When in doubt, please follow the kernel coding style ;-).
