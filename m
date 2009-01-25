From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v1 3/3] git-gui hooks for new config variable
 "diff.primer"
Date: Sun, 25 Jan 2009 10:58:51 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901251045090.12651@kiwi.cs.ucla.edu>
References: <1232904657-31831-1-git-send-email-keith@cs.ucla.edu> <1232904657-31831-2-git-send-email-keith@cs.ucla.edu> <1232904657-31831-3-git-send-email-keith@cs.ucla.edu> <1232904657-31831-4-git-send-email-keith@cs.ucla.edu>
 <alpine.DEB.1.00.0901251918230.14855@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn O Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 25 20:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRADk-0005Ze-Ir
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 20:00:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbZAYS7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 13:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbZAYS7M
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 13:59:12 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:36423 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbZAYS7L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 13:59:11 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0PIwpA2014575;
	Sun, 25 Jan 2009 10:58:51 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0PIwpPG014572;
	Sun, 25 Jan 2009 10:58:51 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0901251918230.14855@racer>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107085>

On Sun, 25 Jan 2009, Johannes Schindelin wrote:

> Rather than storing the information about how to call "git diff" as 
> diff.primer, why don't you store that information in a config variable 
> gui.whiteSpaceMode and teach "git gui" to call "git diff" accordingly?
> 
> That would have the further advantage of not breaking other people's 
> setups...

This wasn't just for the GUI.  Using Git for a project I imported from CVS, I 
wanted --ignore-space-at-eol to be in effect at all times on the command line.  
Of course, the "alias.dff" approach suggested yesterday by Teemu would work for 
that.  But I got the feeling this is a more general need.  I'll name my primary 
inspiration: ExamDiff (a Windows program).  ExamDiff lets you specify a wide 
range of options that remain in effect over all invocations.  Seems like 
something a lot of users would find natural.  Please comment.

> Please submit git-gui patches without the git-gui prefix, as it makes it 
> harder on the maintainer of git-gui, Shawn (who you did not Cc: BTW).

Sorry Shawn, I should have Cc'd you.  Please let me know if I can improve the 
git-gui code in any way.

                                        -- Keith
