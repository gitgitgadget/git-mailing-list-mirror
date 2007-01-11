From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 09:53:34 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701110949421.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 09:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4vgp-0004o4-F4
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 09:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030237AbXAKIxg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 03:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbXAKIxg
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 03:53:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:50736 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030237AbXAKIxf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 03:53:35 -0500
Received: (qmail invoked by alias); 11 Jan 2007 08:53:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 11 Jan 2007 09:53:34 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36559>

Hi,

On Wed, 10 Jan 2007, Junio C Hamano wrote:

> * ar/merge-recursive (Wed Jan 10 11:20:58 2007 -0800) 2 commits
>  + merge-recursive: do not use on-file index when not needed.
>  + Speed-up recursive by flushing index only once for all entries
> 
> I did not see much improvement (maybe a largish kernel merge
> going from 2.5 seconds to slightly less than one second)

That is a heck of an improvement. It is only uses 40% of the time it used 
before! On other machines, with other OSes, this makes the difference 
between 10 minutes and 4 minutes.

BTW I am not quite sure if you missed this patch: 
http://thread.gmane.org/gmane.comp.version-control.git/36212/, or if you 
did not like it, want enhancements, ...

Ciao,
Dscho
