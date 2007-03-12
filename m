From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] Replace fork_with_pipe in bundle with run_command
Date: Tue, 13 Mar 2007 00:44:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703130011190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070312230011.GB16840@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:44:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQuBo-0002Sf-Vz
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbXCLXoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbXCLXoU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:44:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:44038 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752431AbXCLXoT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:44:19 -0400
Received: (qmail invoked by alias); 12 Mar 2007 23:44:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 13 Mar 2007 00:44:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vblMCWd0v6tfAcNBlCxXE+Ne+hfks/jL3fc+6eG
	laHWDGJpJFoZFZ
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070312230011.GB16840@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42094>

Hi,

On Mon, 12 Mar 2007, Shawn O. Pearce wrote:

> Now that the run_command family supports all of the redirection
> modes needed by builtin-bundle, we can use those functions rather
> than the underlying POSIX primitives.  This should help to make the
> bundle command slightly more portable to other systems, like Windows.

Looks fine to me (and since it passes the tests, it must be correct, 
right?)

Ciao,
Dscho
