From: Raimund Bauer <ray007@gmx.net>
Subject: Re: problem pushing repository
Date: Fri, 22 Jun 2007 16:17:30 +0200
Message-ID: <1182521850.6207.42.camel@localhost>
References: <799406d60706211849h6e4fd1dbn487beab03fe1d79c@mail.gmail.com>
	 <7v8xacbvf1.fsf@assigned-by-dhcp.pobox.com>
	 <20070622022426.GA2961@bowser.ruder>
	 <799406d60706220636q4f7a3c17v6833d2eda25e8f0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 16:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1jxA-0001Lv-0e
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 16:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbXFVORe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 10:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753849AbXFVORe
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 10:17:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:55532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753417AbXFVORd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 10:17:33 -0400
Received: (qmail invoked by alias); 22 Jun 2007 14:17:32 -0000
Received: from p5498A0C3.dip0.t-ipconnect.de (EHLO [192.168.178.21]) [84.152.160.195]
  by mail.gmx.net (mp040) with SMTP; 22 Jun 2007 16:17:32 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1+2CO1AC1e24F03cWySqBwko5Es2WhXBh1Tbmnjtn
	Jdqd6JRAHkUGEA
In-Reply-To: <799406d60706220636q4f7a3c17v6833d2eda25e8f0d@mail.gmail.com>
X-Mailer: Evolution 2.10.1 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50699>

On Fri, 2007-06-22 at 09:36 -0400, Adam Mercer wrote:
> This seems like the best way to fix this issue, however it isn't clear
> >from the man page what I need to put in my ~/.gitconfig. With the
> following in .gitconfig
> 
> [remote]
> glue.receivepack = /home/ram/opt/git/bin/git-receive-pack

In my config it looks like this:

[remote "slcom"]
        uploadpack = /usr/local/bin/git-upload-pack
        receivepack = /usr/local/bin/git-receive-pack

-- 
best regards

  Ray
