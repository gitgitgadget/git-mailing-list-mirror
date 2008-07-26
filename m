From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove references to git-fetch-pack from "git clone"
 documentation.
Date: Sat, 26 Jul 2008 05:24:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260523520.26810@eeepc-johanness>
References: <1217011068-1675-1-git-send-email-shaslam@lastminute.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steve Haslam <shaslam@lastminute.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 05:24:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMaOl-00020T-8f
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 05:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbYGZDXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 23:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752614AbYGZDXr
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 23:23:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:42605 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751816AbYGZDXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 23:23:47 -0400
Received: (qmail invoked by alias); 26 Jul 2008 03:23:45 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp048) with SMTP; 26 Jul 2008 05:23:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19s60I9VORsz1HEKHkFBVpsrS7ffKhpDdGZSRaDBR
	I+Dbe86u9TklKs
X-X-Sender: user@eeepc-johanness
In-Reply-To: <1217011068-1675-1-git-send-email-shaslam@lastminute.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90165>

Hi,

On Fri, 25 Jul 2008, Steve Haslam wrote:

> "git clone" no longer calls "git-fetch-pack",

So it calls it internally, avoiding fork() and exec().  But the code is 
still git-fetch-pack's.  The difference should be lost on the regular Git 
user.

Ciao,
Dscho
