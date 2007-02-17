From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: test suite failures because cmp behaves oddly
Date: Sun, 18 Feb 2007 00:16:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180015470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702172225.12758.johannes.sixt@telecom.at>
 <7v3b54s7y3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:16:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIYms-0000ve-H2
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992841AbXBQXQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992859AbXBQXQL
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:16:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:48563 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992841AbXBQXQK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:16:10 -0500
Received: (qmail invoked by alias); 17 Feb 2007 23:16:08 -0000
X-Provags-ID: V01U2FsdGVkX1+ZbXF/98WZCfgjPZH5ZzsY7dm4skEi02Ra8ZieBX
	1DTA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b54s7y3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40020>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> > Does anyone know how 'cmp' can signal success when its output is redirected 
> > to /dev/null, even if the compared files are different?
> >
> > $ cmp M.sum actual7.sum; echo $?
> > M.sum actual7.sum differ: char 20, line 2
> > 1
> > $ cmp M.sum actual7.sum > /dev/null; echo $?
> > 0
> > ...
> > Has anyone seen something like this?
> 
> I vaguely recall this reported long time ago from one of the
> regulars on the list, but googling or gmane search came up
> empty.

Was me. AFAIR it was fixed in CVS.

Ciao,
Dscho
