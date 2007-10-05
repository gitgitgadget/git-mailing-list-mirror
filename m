From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix in-place editing in crlf_to_git and ident_to_git.
Date: Fri, 5 Oct 2007 09:30:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710050930030.4174@racer.site>
References: <87wsu2sad0.fsf@gollum.intra.norang.ca> <20071005082026.GE19879@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Bernt Hansen <bernt@alumni.uwaterloo.ca>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 10:31:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idiap-0002S0-Vm
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbXJEIau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754025AbXJEIau
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:30:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:36597 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753864AbXJEIat (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:30:49 -0400
Received: (qmail invoked by alias); 05 Oct 2007 08:30:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 05 Oct 2007 10:30:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kbPtdd11keB4N0V+vpPIxYtKJVWaRT2LeFtmSrk
	CGxSQWF/nXmayo
X-X-Sender: gene099@racer.site
In-Reply-To: <20071005082026.GE19879@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60051>

Hi,

On Fri, 5 Oct 2007, Pierre Habouzit wrote:

> When crlf_to_git or ident_to_git are called "in place", the buffer 
> already is big enough and should not be resized (as it could make the 
> buffer address change, hence invalidate the `src' pointers !).

I wonder why we resize at all if the buffer is big enough to begin with.

Ciao,
Dscho
