From: Jeff King <peff@peff.net>
Subject: Re: How to init a empty repo for pushing?
Date: Fri, 3 Apr 2009 14:23:12 -0400
Message-ID: <20090403182312.GA15071@coredump.intra.peff.net>
References: <eafc0afe0904031117rbfd55cft5f40f1b45df1e454@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Changsheng Jiang <jiangzuoyan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 20:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpo4a-0005oT-OB
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 20:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbZDCSX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 14:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757719AbZDCSX3
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 14:23:29 -0400
Received: from peff.net ([208.65.91.99]:54889 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757381AbZDCSX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 14:23:28 -0400
Received: (qmail 820 invoked by uid 107); 3 Apr 2009 18:23:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 14:23:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 14:23:12 -0400
Content-Disposition: inline
In-Reply-To: <eafc0afe0904031117rbfd55cft5f40f1b45df1e454@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115551>

On Sat, Apr 04, 2009 at 02:17:33AM +0800, Changsheng Jiang wrote:

> Just 'git init' in server, then 'git push server' after 'git remote
> add server ...'  in laptop gives error.

It's hard to say without seeing the error message, but I'm assuming it
was along the lines of "No refs in common".

By default, "git push server" will push matching branches (i.e., ones
that both the client and the server have in common). To push a new
branch, you say "git push server $BRANCH", or even just "git push --all
server".

-Peff
