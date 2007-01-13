From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail
 header
Date: Sat, 13 Jan 2007 12:19:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701131217410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <871wm08kcu.fsf@morpheus.local> <7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
 <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 12:19:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5gvT-0002cO-2F
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 12:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422636AbXAMLTv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 06:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbXAMLTt
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 06:19:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:53111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422636AbXAMLTt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 06:19:49 -0500
Received: (qmail invoked by alias); 13 Jan 2007 11:19:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 13 Jan 2007 12:19:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36750>

Hi,

On Fri, 12 Jan 2007, Junio C Hamano wrote:

> Side note.  The previous patch does not help if your commit were
> made in non UTF-8 with not too recent git; the code assumes that
> commit messages without the new "encoding" headers are in UTF-8.

Why not just use is_utf8() and warn, or error out, if the message is not 
UTF-8? (I tend towards the erroring out, since this _is_ a new feature, 
and gives undesired results with "old" commits.)

Ciao,
Dscho
