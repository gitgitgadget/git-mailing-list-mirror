From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: [PATCH] Cleanup of unused symcache variable inside diff-lib.c
Date: Sun, 11 Jan 2009 21:09:23 +0100
Organization: private
Message-ID: <86eiz98v0s.fsf@broadpark.no>
References: <1231699002-5316-1-git-send-email-barvik@broadpark.no>
 <alpine.DEB.1.00.0901111944360.3586@pacific.mpi-cbg.de>
 <86iqol8wql.fsf@broadpark.no>
 <alpine.DEB.1.00.0901112044230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 21:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM6e3-0007I1-1i
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 21:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbZAKUJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 15:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752031AbZAKUJ0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 15:09:26 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:46922 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZAKUJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 15:09:25 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB00H1IPBOW1E0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 21:09:24 +0100 (CET)
Received: from localhost ([80.203.78.153]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDB009CMPBN9I30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 11 Jan 2009 21:09:24 +0100 (CET)
In-reply-to: <alpine.DEB.1.00.0901112044230.3586@pacific.mpi-cbg.de>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105211>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
<snipp>
> My question was more: why do you do additional work and put a git diff 
> --raw between the commit message and the diffstat when that information is 
> in the patch already?

 Ok, I see.  I (re)used the 'git format-patch' command from previous
 run, and this time it was (without the line-breaks):

    git format-patch  --stat  --patch-with-raw -1 --signoff -M -C
       --summary --full-index --subject-prefix="PATCH"
       --output-directory ../diff_lib_c_symcache_cleanup_v1/

  Regarding the '--summary' I think it is a nice thing to do (so I try
  to always use it), and the '--full-index' is such that the git software
  have a less chance of producing a collision.

  -- kjetil
