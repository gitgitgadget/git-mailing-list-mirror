From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 16:56:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702141653440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
 <7v7iumx7hu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702131053110.8424@woody.linux-foundation.org>
 <7v8xf1uxme.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702132127330.3604@woody.linux-foundation.org>
 <Pine.LNX.4.63.0702141208020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D31C0E.2040206@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 16:56:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHMUK-00062Z-VW
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 16:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXBNP4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 10:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbXBNP4F
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 10:56:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:45825 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932348AbXBNP4C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 10:56:02 -0500
Received: (qmail invoked by alias); 14 Feb 2007 15:56:01 -0000
X-Provags-ID: V01U2FsdGVkX1+rBlcA5FSrkvnvpeob8Njf/hBf22+WqRk5EawI17
	TN9Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45D31C0E.2040206@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39661>

Hi,

On Wed, 14 Feb 2007, Mark Levedahl wrote:

> This suggests to me a core.AutoCRLFstrategy variable that is a comma 
> separated list of methods to use (set to a reasonable default of course 
> that does not cause runtime headaches on Unix): a file would be deemed 
> binary unless all listed methods declare the file as text (with an empty 
> list disabling AutoCRLF detection).

This sounds regretfully complex. Somebody (you?) mentioned that cvsnt does 
a kick-ass job here. Does cvsnt need strategies? I don't think so. Neither 
do we. Someone who cares enough should just rip^H^H^Hlook at cvsnt's text 
detection.

Ciao,
Dscho
