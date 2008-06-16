From: Jeff King <peff@peff.net>
Subject: Re: current repository hash
Date: Mon, 16 Jun 2008 14:45:20 -0400
Message-ID: <20080616184520.GA11992@sigill.intra.peff.net>
References: <556d90580806160451g36daefb6o48b93b92589211bf@mail.gmail.com> <8aa486160806160515p751b2af4j2b0db6db7a9ad482@mail.gmail.com> <556d90580806161130g62269318i46f00e5c7f79b7d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 20:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Jid-0004C4-MS
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 20:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbYFPSpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 14:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754155AbYFPSpY
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 14:45:24 -0400
Received: from peff.net ([208.65.91.99]:2674 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027AbYFPSpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 14:45:23 -0400
Received: (qmail 26147 invoked by uid 111); 16 Jun 2008 18:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 16 Jun 2008 14:45:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2008 14:45:20 -0400
Content-Disposition: inline
In-Reply-To: <556d90580806161130g62269318i46f00e5c7f79b7d9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85214>

On Mon, Jun 16, 2008 at 08:30:16PM +0200, Alf Clement wrote:

> When I run describe I get an error:
> $ git describe --debug HEAD
> fatal: cannot describe '792815de6e3c2403f1e2ed5f2264ca88a0ae7000'
> 
> Any hints why? I have a tag v1.3 attached to HEAD and all commited.

By default, git-describe uses only annotated tags. Try "git describe
--tags HEAD".

-Peff
