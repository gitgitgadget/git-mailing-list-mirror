From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] additional help when editing during interactive rebase
Date: Wed, 9 Jan 2008 11:23:32 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801091120150.31053@racer.site>
References: <1199845915-sup-797@south> <7vsl17pv1c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, William Morgan <wmorgan-git@masanjin.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 12:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCZ2j-0007Ut-Kb
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 12:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbYAILX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 06:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbYAILX4
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 06:23:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:51336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751368AbYAILXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 06:23:46 -0500
Received: (qmail invoked by alias); 09 Jan 2008 11:23:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 09 Jan 2008 12:23:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19mJDowVHJmfMX0MU1G9wLLM60wp+QPK8zYYwWj7B
	56Ku5/3YL2SmgS
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl17pv1c.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69983>

Hi,

On Tue, 8 Jan 2008, Junio C Hamano wrote:

> I would have removed those empty lines around the instruction if I were 
> patching this, though.  Losing 5 lines out of 25-line terminal was 
> marginally Ok.  Losing 9 lines 4 lines too many and is unacceptable.
> 
> Thoughts?

I wonder if it would not make even more sense to record the current HEAD 
name, and call "commit --amend" if it is the same upon "--continue".

Note that "commit --amend" is _already_ called automatically if the index 
is dirty (but agrees with the working directory).

Then the user would be spared some additional typing, and the help could 
be changed to hint at "rebase --continue".  It also would make things more 
consistent.

Ciao,
Dscho
