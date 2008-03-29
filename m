From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 05:43:22 -0400
Message-ID: <20080329094322.GA21814@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291002.43768.robin.rosenberg.lists@dewire.com> <20080329091145.GA19501@coredump.intra.peff.net> <200803291039.43355.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 10:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfXba-0001g8-H1
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 10:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYC2JnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 05:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbYC2JnZ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 05:43:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4945 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYC2JnY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 05:43:24 -0400
Received: (qmail 23114 invoked by uid 111); 29 Mar 2008 09:43:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 05:43:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 05:43:22 -0400
Content-Disposition: inline
In-Reply-To: <200803291039.43355.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78462>

On Sat, Mar 29, 2008 at 10:39:43AM +0100, Robin Rosenberg wrote:

> > Because some UTF-8 sequences have multiple representations, and that
> 
> Care to give an example?

There were several given in the "OS X normalize your UTF-8 filenames"
thread a while back. They generally boil down to "a<UMLAUT MODIFIER>"
versus "<A WITH UMLAUT>" both of which are valid UTF-8.

-Peff
