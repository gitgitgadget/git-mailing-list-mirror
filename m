From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name(): accept ':directory/' to get at the cache_tree
Date: Fri, 22 Dec 2006 13:16:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612221315370.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612220318320.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm9g7duz.fsf@assigned-by-dhcp.cox.net> <emg4qp$f8v$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 13:17:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxjKm-0005wR-S0
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 13:17:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbWLVMQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 07:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWLVMQp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 07:16:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:49826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965152AbWLVMQo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 07:16:44 -0500
Received: (qmail invoked by alias); 22 Dec 2006 12:16:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 22 Dec 2006 13:16:42 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <emg4qp$f8v$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35167>

Hi,

On Fri, 22 Dec 2006, Jakub Narebski wrote:

> Junio C Hamano wrote:
> 
> > (2) What does this do when the index is unmerged?
> 
> I think it should show "git ls-files --unmerged --abbrev", perhaps...

Nah. I'd rather fail out, saying that because there are unmerged entries, 
there is no valid tree in the index.

Ciao,
Dscho
