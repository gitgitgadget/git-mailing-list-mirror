From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
	maxsize reached
Date: Wed, 5 Mar 2008 03:44:28 -0500
Message-ID: <20080305084427.GA18285@sigill.intra.peff.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <47CD78C9.80003@viscovery.net> <200803050937.40345.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWpFM-0005cu-Pk
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 09:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757613AbYCEIob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 03:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757604AbYCEIob
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 03:44:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3242 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbYCEIoa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 03:44:30 -0500
Received: (qmail 25226 invoked by uid 111); 5 Mar 2008 08:44:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 05 Mar 2008 03:44:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2008 03:44:28 -0500
Content-Disposition: inline
In-Reply-To: <200803050937.40345.michal.rokos@nextsoft.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76195>

On Wed, Mar 05, 2008 at 09:37:39AM +0100, Michal Rokos wrote:

> Could somebody else try to run testcase above on some other OSes?

SunOS 5.8 correctly returns '5' in each case.

-Peff
