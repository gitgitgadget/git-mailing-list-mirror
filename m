From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git: avoiding merges, rebasing
Date: Tue, 9 Oct 2007 11:43:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091141440.4174@racer.site>
References: <200709301421.52192.bruno@clisp.org> <46FF99E2.8050605@byu.net>
 <200709302141.25597.bruno@clisp.org> <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr>
 <07BCEF3E-90DE-4BB7-8A8C-F03D12293B5F@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bruno Haible <bruno@clisp.org>, bug-gnulib@gnu.org,
	git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Oct 09 12:43:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfCZA-0005Gl-UJ
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 12:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbXJIKnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 06:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXJIKnr
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 06:43:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:44685 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751370AbXJIKnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 06:43:47 -0400
Received: (qmail invoked by alias); 09 Oct 2007 10:43:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 09 Oct 2007 12:43:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Dezc7dP+DV93Q+HxWOBArBfEUHqcJuQHRnFasdI
	oXJo1Au6BUzXOm
X-X-Sender: gene099@racer.site
In-Reply-To: <07BCEF3E-90DE-4BB7-8A8C-F03D12293B5F@lrde.epita.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60382>

Hi,

On Mon, 8 Oct 2007, Benoit SIGOURE wrote:

> [as usual, I forgot the attachment...]

Two comments:

- by not inlining you made it hard to review your script.  Therefore I 
  will not do it.

- Try to avoid naming the script git-merge-*; these scripts/programs are 
  merge _strategies_, not merge _drivers_ (and yes, we already have two 
  programs violating this rule -- merge-base and merge-file -- but that 
  does not mean that you are free to add to the pile).

Ciao,
Dscho
