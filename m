From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: [PATCH] Some documentation...
Date: Wed, 20 Apr 2005 13:24:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201321380.2630@cag.csail.mit.edu>
References: <42668C8D.3000209@dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 19:23:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIuZ-0004Sx-S6
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbVDTRZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVDTRZw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:25:52 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:2713 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261765AbVDTRYf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 13:24:35 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOIw9-0001KX-00; Wed, 20 Apr 2005 13:24:29 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42668C8D.3000209@dgreaves.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, David Greaves wrote:

> In doing this I noticed a couple of points:
> * update-cache won't accept ./file or fred/./file

The comment in update-cache.c reads:
/*
  * We fundamentally don't like some paths: we don't want
  * dot or dot-dot anywhere, and in fact, we don't even want
  * any other dot-files (.git or anything else). They
  * are hidden, for chist sake.
  *
  * Also, we don't want double slashes or slashes at the
  * end that can make pathnames ambiguous.
  */

It could be argued that './' is a special case... but at the moment this 
is definitely a designed 'feature' not a 'bug'.
  --scott

BLUEBIRD SEQUIN SECANT Waihopai Honduras KUDOVE genetic KUJUMP SCRANTON 
DES AMLASH Indonesia SLINC cracking ESMERALDITE mustard Uzi KUSODA
                          ( http://cscott.net/ )
