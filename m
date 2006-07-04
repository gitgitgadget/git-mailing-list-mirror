From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 20:07:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607032007290.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com>
 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <20060704002138.GB5716@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 05:08:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxbGd-0003BK-0x
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 05:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWGDDHy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 23:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWGDDHy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 23:07:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751279AbWGDDHx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 23:07:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6437nnW012999
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 20:07:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6437n54014086;
	Mon, 3 Jul 2006 20:07:49 -0700
To: Jeff King <peff@peff.net>
In-Reply-To: <20060704002138.GB5716@coredump.intra.peff.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23240>



On Mon, 3 Jul 2006, Jeff King wrote:
> 
> Fetching by ssh actually makes two ssh connections (the second is to
> grab tags).

True. Although that should happen only if there are any new tags.

		Linus
