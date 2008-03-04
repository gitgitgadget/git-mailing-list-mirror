From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-submodule: Don't die when command fails for one
 submodule
Date: Tue, 4 Mar 2008 16:03:11 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041602150.22527@racer.site>
References: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>  <alpine.LSU.1.00.0803041500170.22527@racer.site> <46dff0320803040800o499bb77bsa033134bda43becb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:04:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZdD-0005fP-Pq
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765038AbYCDQEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765033AbYCDQD7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:03:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:58045 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1765022AbYCDQD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:03:58 -0500
Received: (qmail invoked by alias); 04 Mar 2008 16:03:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 04 Mar 2008 17:03:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/naG4gu7jnaBpPZgyHKveJwNfVdX8p6HmZY1RB/m
	Krsv1nQkzt6AAC
X-X-Sender: gene099@racer.site
In-Reply-To: <46dff0320803040800o499bb77bsa033134bda43becb@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76107>

Hi,

On Wed, 5 Mar 2008, Ping Yin wrote:

> The error output is not lost and is in module_name

That's what I am saying: the error output is not enough.  The exit status 
needs to indicate that there was an error, too.  Everything else is 
unusable by scripts.

Thank you very much,
Dscho

