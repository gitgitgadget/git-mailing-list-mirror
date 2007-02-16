From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pretend-sha1: grave bugfix.
Date: Fri, 16 Feb 2007 05:05:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702160503290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v3b56dhr1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 05:05:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHuLL-0001wQ-Vy
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 05:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423097AbXBPEFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 23:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423111AbXBPEFE
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 23:05:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:53800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1423097AbXBPEFC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 23:05:02 -0500
Received: (qmail invoked by alias); 16 Feb 2007 04:05:01 -0000
X-Provags-ID: V01U2FsdGVkX19SZppu8FFSQoJMz7sIbOnk/NJ0qiLc1HIfYirRjg
	ro1w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b56dhr1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39883>

Hi,

On Thu, 15 Feb 2007, Junio C Hamano wrote:

>  * I wonder how recent merge-recursive with multiple merge bases
>    (or an empty one) ever worked with this bug.  Am I
>    hallucinating?

Probably the fact helped that merge-recursive only pretends 
zero-sized blobs.

Ciao,
Dscho
