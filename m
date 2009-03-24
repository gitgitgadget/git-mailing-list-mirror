From: Jeff King <peff@peff.net>
Subject: Re: git hooks to run something
Date: Tue, 24 Mar 2009 07:15:25 -0400
Message-ID: <20090324111524.GA6291@coredump.intra.peff.net>
References: <556d90580903240356q3a72fd0bwa5ebe335914bc469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 12:17:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm4d3-000684-OI
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 12:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014AbZCXLPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 07:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593AbZCXLPe
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 07:15:34 -0400
Received: from peff.net ([208.65.91.99]:50540 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757542AbZCXLPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 07:15:34 -0400
Received: (qmail 29131 invoked by uid 107); 24 Mar 2009 11:15:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 07:15:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 07:15:25 -0400
Content-Disposition: inline
In-Reply-To: <556d90580903240356q3a72fd0bwa5ebe335914bc469@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114450>

On Tue, Mar 24, 2009 at 11:56:05AM +0100, Alf Clement wrote:

> when I switch between branches, I would like like to delete some
> object files and prepare some setup files.
> I there a good way to do this automatically when I run "git checkout
> branch", like
> misusing a hook to run a make in a special directory?
> All would happen in my local repository.

There is a post-checkout hook; see "git help hooks" for details.

You could also make an alias; see the documentation for "alias.*" in
"git help config".

-Peff
