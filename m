From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: About -X<option>
Date: Sat, 5 Jul 2008 14:57:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807051454060.3334@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 14:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF7L9-0000Qz-CF
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 14:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbYGEM5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 08:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYGEM5N
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 08:57:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:41095 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752389AbYGEM5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 08:57:13 -0400
Received: (qmail invoked by alias); 05 Jul 2008 12:57:10 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp003) with SMTP; 05 Jul 2008 14:57:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aG7c9PQDaNxHqSIRgyMbRlAQ0Gr+lQPtU1Qmkjs
	8g103ikOS2xZSy
X-X-Sender: user@eeepc-johanness
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.78
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87444>

Hi,

the -X<option> options are not really easy to convert to parseopt.  This 
is only one indication that the interface can be improved.

Another one: you are more likely wanting to pass backend-_specific_ 
options to git-merge.

So, how about using this syntax instead?

	git pull -s recursive,theirs

i.e. strategy terms consist of the strategy name, optionally followed by a 
comma separated list of backend options.

Hmm?

Ciao,
Dscho
