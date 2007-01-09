From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/6] Make merge-base a built-in.
Date: Tue, 9 Jan 2007 12:05:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091202560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vd55oo52e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 12:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Enb-00012u-P5
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 12:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXAILFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 06:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbXAILFp
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 06:05:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:60682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751149AbXAILFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 06:05:44 -0500
Received: (qmail invoked by alias); 09 Jan 2007 11:05:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 09 Jan 2007 12:05:43 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd55oo52e.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36351>

Hi,

On Tue, 9 Jan 2007, Junio C Hamano wrote:

>  builtin-merge-base.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++
>  merge-base.c         |   88 --------------------------------------------------

Hmm. I wonder if we should make "-M" a default for format-patch... But 
then, some use git to develop against a non-git upstream, and sending such 
patches might upset the upstream maintainers...

Anyway, I think this series is sane (i.e. I did not find obvious flaws 
reading them).

Ciao,
Dscho
