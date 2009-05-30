From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-cvs script
Date: Sat, 30 May 2009 16:33:17 -0700
Message-ID: <7vr5y6xj2a.fsf@alter.siamese.dyndns.org>
References: <4A213793.3030205@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nick Woolley <nickwoolley@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Sun May 31 01:34:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAY4A-0004aK-Mf
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 01:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872AbZE3XdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 19:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbZE3XdS
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 19:33:18 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46702 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758542AbZE3XdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 19:33:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090530233319.BSUB20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 May 2009 19:33:19 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id xzZH1b0064aMwMQ04zZHCD; Sat, 30 May 2009 19:33:17 -0400
X-Authority-Analysis: v=1.0 c=1 a=BrDiTsk0AAAA:8 a=r5lGCiNQIMMiXsUzclcA:9
 a=ydioTlFCP9KFY-WbYfr_HSaa584A:4 a=-hJg1tCh9CgA:10 a=LucBaDpCW-Di8E46:21
 a=EkraT1S2_m-c2eQP:21
X-CM-Score: 0.00
In-Reply-To: <4A213793.3030205@yahoo.co.uk> (Nick Woolley's message of "Sat\, 30 May 2009 14\:41\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120369>

Nick Woolley <nickwoolley@yahoo.co.uk> writes:

> I have script which wraps git-cvsimport and git-cvsexport, called "git-cvs".
>
> The main aim of the script is to automate the steps for tracking a CVS
> repository with the git-cvs* commands.

If I recall correctly, the above is in line with the original spirit of
how git-cvsexportcommit was envisioned to be used by its original authors.

That is, the import side is more or less satisfactory done in the sense
that it deserved a short and sweet command name, but the export side is
not as finished as the import side is, and you have to drive it more
explicitly by telling what commit to send back to the CVS side.  Building
on top of it so the tool keeps track of what needs to be sent, like git-svn
allows users to do, would be the right thing to do.

> It's not currently as sophisticated as git-svn,...
> ...
>  - Is this at all useful to anyone else in it's current form?

I have to admit that it won't be to me (because I do not interact with CVS
myself) but I don't count ;-)
