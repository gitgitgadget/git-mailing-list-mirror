From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect core.autocrlf when preparing temporary files
 for external diff
Date: Sun, 22 Mar 2009 00:54:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903220053260.10279@pacific.mpi-cbg.de>
References: <cover.1237635609u.git.johannes.schindelin@gmx.de> <8cb424b16f21164ddc26d0be3f6f7727254b3506.1237635609u.git.johannes.schindelin@gmx.de> <7vocvuekjb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 00:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlB19-0006Sc-9a
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:54:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396AbZCUXwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754271AbZCUXwp
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:52:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:43176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754243AbZCUXwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 19:52:45 -0400
Received: (qmail invoked by alias); 21 Mar 2009 23:52:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp048) with SMTP; 22 Mar 2009 00:52:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oc2UasW+oQ5Tjp2WNt5HDPSIcHI6qKRFiezdinx
	2OjmmM/e7/nDKJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vocvuekjb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114100>

Hi,

On Sat, 21 Mar 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When preparing temporary files for an external diff, the files should 
> > be handled as if they were worktree files.
> 
> I do not think so.  convert_to_working_tree() aka "smudge" means you 
> would be feeding crap like $Id$ expansion to the external diff, which we 
> chose not to do quite on purpose.

You might have missed me mentioning that we often can do without temporary 
files, taking the working directory copies right away?

And if you think about it, it makes complete sense.

Ciao,
Dscho
