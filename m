From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pretty.c: add %z specifier.
Date: Thu, 20 Mar 2008 22:13:38 -0400
Message-ID: <20080321021337.GD1613@coredump.intra.peff.net>
References: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Govind Salinas <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 03:14:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcWlz-00010i-Lg
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 03:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbYCUCNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 22:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbYCUCNk
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 22:13:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2951 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbYCUCNk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 22:13:40 -0400
Received: (qmail 14951 invoked by uid 111); 21 Mar 2008 02:13:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Mar 2008 22:13:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2008 22:13:38 -0400
Content-Disposition: inline
In-Reply-To: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77697>

On Thu, Mar 20, 2008 at 07:45:26PM -0500, Govind Salinas wrote:

> This adds a %z format which prints out a null character.  This allows for
> easier machine parsing of multiline data.  It is also necessary to use write
> to print out the data since printf will terminate at a null.  That in turn
> requires that an fflush be executed before the write to preserve the order
> the data is printed.

How about using fwrite instead of write?

-Peff
