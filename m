From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: VSS to git
Date: Mon, 02 Mar 2009 18:48:46 +0100
Message-ID: <49AC1BFE.2040601@drmicha.warpmail.net>
References: <b0a3bf780903020915g60d97b76pfdbbd60017625f0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Velevitch <chris.velevitch@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 18:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeCHf-00053K-SJ
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 18:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbZCBRs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 12:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZCBRs6
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 12:48:58 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:44535 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753596AbZCBRs6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 12:48:58 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 77B9C2D0FAD;
	Mon,  2 Mar 2009 12:48:55 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 02 Mar 2009 12:48:55 -0500
X-Sasl-enc: nwZ7eza6ZS4R7N7yL76pYTtvgx00XekPGFZUYHCtjUx3 1236016135
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CFC691ACAF;
	Mon,  2 Mar 2009 12:48:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090302 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <b0a3bf780903020915g60d97b76pfdbbd60017625f0a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111951>

Chris Velevitch venit, vidit, dixit 02.03.2009 18:15:
> I can't seem to find any utilities to convert a vss repository to git.
> In the absence of such a tool, what is the best approach to converting
> an vss repository to git?

Depending on the complexity of your vss repo, going through svn may be
an option, see

http://kerneltrap.org/mailarchive/git/2008/5/27/1952124

which points at

http://www.pumacode.org/projects/vss2svn

Using those pieces you may even be able to produce a fast-exporter for
vss, whose output you could feed into git-fast-import (vss2svn already
creates an svn dump file).

Michael
