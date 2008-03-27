From: Jeff King <peff@peff.net>
Subject: Re: .git/info/attributes not cloned
Date: Thu, 27 Mar 2008 00:53:42 -0400
Message-ID: <20080327045342.GC6426@coredump.intra.peff.net>
References: <47EB0FAE.5000102@rea-group.com> <20080327033341.GB5417@coredump.intra.peff.net> <47EB213F.1020503@rea-group.com> <20080327042925.GA6426@coredump.intra.peff.net> <47EB271F.1050307@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 05:54:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jek8A-00073E-Ce
	for gcvg-git-2@gmane.org; Thu, 27 Mar 2008 05:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbYC0Exp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 00:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbYC0Exo
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 00:53:44 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2746 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbYC0Exo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 00:53:44 -0400
Received: (qmail 5793 invoked by uid 111); 27 Mar 2008 04:53:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 27 Mar 2008 00:53:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Mar 2008 00:53:42 -0400
Content-Disposition: inline
In-Reply-To: <47EB271F.1050307@rea-group.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78333>

On Thu, Mar 27, 2008 at 03:48:31PM +1100, Toby Corkindale wrote:

>> I vaguely recall some discussion of this in the past, so maybe it isn't
>> a good idea. But I would think changing git-archive to respect
>> .gitattributes might be worth doing (presumably the version of
>> .gitattributes from the tree that is being exported).
>
> Respecting the repo's .gitattributes would feel right. It seems unusual  
> (to me) that it bypasses $REMOTE/.gitattributes, but DOES check  
> $REMOTE/info/attributes.

I agree that it seems like a bug. You might search the list archives for
discussion around the export_subst attribute to see if it was discussed
then or if it is simply an omission.

-Peff
