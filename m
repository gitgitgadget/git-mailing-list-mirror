From: Jeff King <peff@peff.net>
Subject: Re: .git/info/attributes not cloned
Date: Wed, 26 Mar 2008 23:33:41 -0400
Message-ID: <20080327033341.GB5417@coredump.intra.peff.net>
References: <47EB0FAE.5000102@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 04:34:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jeisk-0007Np-TE
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 04:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073AbYC0Ddo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 23:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754633AbYC0Ddo
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 23:33:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3015 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754165AbYC0Ddo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 23:33:44 -0400
Received: (qmail 744 invoked by uid 111); 27 Mar 2008 03:33:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Mar 2008 23:33:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Mar 2008 23:33:41 -0400
Content-Disposition: inline
In-Reply-To: <47EB0FAE.5000102@rea-group.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78327>

On Thu, Mar 27, 2008 at 02:08:30PM +1100, Toby Corkindale wrote:

> If one creates a .git/info/attributes file in a Git repo, it will not be  
> present in cloned repos.
> I don't know if this is a bug or not, but it /seems/ wrong behaviour to  
> me, and reading from the manual pages.

It is not a bug. The .gitattributes file in your working directory _is_
cloned, and that is the right place to put things that you want to be
revision-controlled and used in every repo. The .git/info/attributes
file is for attributes that are purely local to that repo. This is
similar to the split between .git/info/exclude and .gitignore.

Can you point out which part of the manual gave the wrong impression (or
better yet, submit a patch making it more clear)?

-Peff
