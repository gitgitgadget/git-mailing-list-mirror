From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug in diff header generation
Date: Fri, 2 Mar 2007 23:05:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703022254320.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1172840031.22581.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Matthias Kestenholz <lists@spinlock.ch>
X-From: git-owner@vger.kernel.org Fri Mar 02 23:05:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNFsu-0002yB-AK
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 23:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030512AbXCBWFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030514AbXCBWFq
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 17:05:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:35822 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030512AbXCBWFp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 17:05:45 -0500
Received: (qmail invoked by alias); 02 Mar 2007 22:05:43 -0000
X-Provags-ID: V01U2FsdGVkX18invAzQngiZjwKBrbYYPRUxKayrtfzUMglkDi+hf
	ImD1VLaAl7/K1H
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1172840031.22581.3.camel@localhost.localdomain>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41252>

Hi,

On Fri, 2 Mar 2007, Matthias Kestenholz wrote:

> [13:49] mk@crap ~/Projects/git > git diff HEAD:git.c ~/bin/viname|head
> diff --git a/home/mk/bin/viname b/home/mk/bin/viname

This is intended behaviour. You don't want a Git object name as a file 
specifier, because you cannot edit a Git object.

Hth,
Dscho
