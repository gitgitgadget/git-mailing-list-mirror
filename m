From: Jim Radford <radford@blackbean.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Fri, 11 Nov 2005 10:23:36 -0800
Message-ID: <20051111182336.GA24416@blackbean.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <20051110185423.GA7212@blackbean.org> <4373AE02.9050909@op5.se> <7v4q6kxm9c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 19:24:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EadYt-0001U3-Rt
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 19:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVKKSXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 13:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVKKSXl
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 13:23:41 -0500
Received: from cpe-66-74-186-186.socal.res.rr.com ([66.74.186.186]:54166 "EHLO
	mail.blackbean.org") by vger.kernel.org with ESMTP id S1750978AbVKKSXk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 13:23:40 -0500
Received: from home.blackbean.org (localhost.localdomain [127.0.0.1])
	by mail.blackbean.org (8.13.4/8.13.4) with ESMTP id jABINakB024656;
	Fri, 11 Nov 2005 10:23:36 -0800
Received: (from jim@localhost)
	by home.blackbean.org (8.13.4/8.13.4/Submit) id jABINaST024653;
	Fri, 11 Nov 2005 10:23:36 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q6kxm9c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11624>

On Thu, Nov 10, 2005 at 12:48:15PM -0800, Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> > Jim Radford wrote:

> >> The main reason I see for splitting cvs and email import out is the
> >> non-standard dependencies, cvsps and perl(Email::Valid).

> > Define "non-standard". String::ShellQuote isn't installed by default on 
> > Fedora Core 3 but is required by git-archimport.

You are right.  I had missed that it required String::ShellQuote.  It
should go in it's own RPM (and it already has).

-Jim
