From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist: git info
Date: Tue, 13 Nov 2007 11:08:08 -0800
Message-ID: <7v3avat147.fsf@gitster.siamese.dyndns.org>
References: <fhad5q$iia$1@ger.gmane.org> <20071112222106.GE2918@steel.home>
	<4738D8AA.1030604@users.sourceforge.net> <fhaol0$p5r$1@ger.gmane.org>
	<fhbn50$uqu$1@ger.gmane.org>
	<Pine.LNX.4.64.0711131111220.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Neumann <tneumann@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1CV-00060C-U3
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764147AbXKMTIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764143AbXKMTIR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:08:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37156 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760711AbXKMTIP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:08:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B77622F0;
	Tue, 13 Nov 2007 14:08:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 03725955B5;
	Tue, 13 Nov 2007 14:08:31 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711131111220.4362@racer.site> (Johannes
	Schindelin's message of "Tue, 13 Nov 2007 11:13:59 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64830>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 13 Nov 2007, Thomas Neumann wrote:
>
>> Perhaps also project description (if it exists?) one can specify a 
>> project description? I did not even know this. But yes, this would be 
>> useful, too. In general I think git info should show everything to 
>> quickly understand what is currently checked out.
>
> Is slightly troubles me that you put so much emphasis on what I would call 
> "remote information".  I understand that in svn, your working directory 
> without the server is not very useful.  But we do not have that problem.

I mildly disagree.

Exactly because you can do so much more in isolation than with
other systems like SVN, I tend to think that you would want to
know what "git remote show" gives you, and a lot more (e.g. what
"git shortlog origin@{1}..origin" would give you if you were to
fetch now).  You can deviate from the others quite a lot without
synchronizing, because git allows you to do so very easily, and
I can understand that some people will find it scary when it
comes to the point to synchronize with the others.

A stronger support to learn "what happened there while I was
looking the other way" would be a definite plus.

But "project description"?  Give me a break.  If you have cloned
the repository (or learned the existence of repository), you
already learned from elsewhere what the project is about.

I haven't spoken in this thread because honestly I found most of
the things mentioned here were totally uninteresting.
