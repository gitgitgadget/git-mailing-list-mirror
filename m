From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Port forwarding
Date: Tue, 12 Jun 2007 11:08:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706121103230.14121@woody.linux-foundation.org>
References: <466EBB1B.9060405@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Claudio Scordino <cloud.of.andor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 20:08:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAn1-0008FR-6M
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 20:08:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825AbXFLSIV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 14:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755552AbXFLSIV
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 14:08:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41322 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755015AbXFLSIU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 14:08:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CI8FPr006201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2007 11:08:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CI8AQh017572;
	Tue, 12 Jun 2007 11:08:10 -0700
In-Reply-To: <466EBB1B.9060405@gmail.com>
X-Spam-Status: No, hits=-2.676 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49983>



On Tue, 12 Jun 2007, Claudio Scordino wrote:
> 
>    how can I specify the port in git-clone when cloning from a server running
> git-daemon ?

Just doing

	git clone git://hostname:port/repo/path/name

should be fine.

> I need to set port forwarding from a public server to a private server.
> The public server, however, already hosts a git-daemon on port 9418.
> So, I have to use a different port for the forwarding.
> 
> My idea is to let the public server listen on a different port (e.g. 9419) and
> make it redirect all the incoming connections to the port 9418 of the private
> server.

I would argue that it probably makes more sense to make the _private_ 
server listen to another port (fewer people who need to use the :<port> 
syntax). But hey, that's a matter of taste.

> However, I don't know how make git-clone go on a port different than the
> default (9418).

See above. The obvious thing should "just work".

		Linus
