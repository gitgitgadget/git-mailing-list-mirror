From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit
	right after init
Date: Wed, 25 Mar 2009 08:42:19 -0400
Message-ID: <20090325124219.GA5307@coredump.intra.peff.net>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <adf1fd3d0903250456l3c14a863pd6ee00c0025100c4@mail.gmail.com> <alpine.DEB.1.00.0903251338130.26370@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 13:44:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmSSd-0003Kl-Ea
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 13:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325AbZCYMmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 08:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756299AbZCYMmc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 08:42:32 -0400
Received: from peff.net ([208.65.91.99]:37944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbZCYMmb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 08:42:31 -0400
Received: (qmail 6697 invoked by uid 107); 25 Mar 2009 12:42:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Mar 2009 08:42:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2009 08:42:19 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903251338130.26370@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114599>

On Wed, Mar 25, 2009 at 01:38:30PM +0100, Johannes Schindelin wrote:

> > > +If no message is given, "Initial commit" will be used.
> > 
> > Why a default message and not running the editor?
> 
> Because I would say "Initial commit" anyway.

Agreed. This feature is about convenience. If you really want to say
something more exciting, then use "git commit" directly. Heck, you can
even "git commit --amend" it afterwards.

-Peff
