From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] blame: Add option to show author email instead of
 name
Date: Thu, 21 Oct 2010 16:53:58 -0400
Message-ID: <20101021205358.GA29377@sigill.intra.peff.net>
References: <7vsk02ypj5.fsf@alter.siamese.dyndns.org>
 <1287535323-20347-1-git-send-email-kevin@sb.org>
 <20101021180525.GA11501@burratino>
 <79AB0864-E151-468E-9C86-EBCAD929938B@sb.org>
 <20101021203210.GA12685@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Ballard <kevin@sb.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:53:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P928b-0002Gr-8H
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757811Ab0JUUxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 16:53:16 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:42054 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026Ab0JUUxP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:53:15 -0400
Received: (qmail 12260 invoked by uid 111); 21 Oct 2010 20:53:15 -0000
Received: from 129-79-255-184.dhcp-bl.indiana.edu (HELO sigill.intra.peff.net) (129.79.255.184)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 21 Oct 2010 20:53:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Oct 2010 16:53:58 -0400
Content-Disposition: inline
In-Reply-To: <20101021203210.GA12685@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159566>

On Thu, Oct 21, 2010 at 03:32:10PM -0500, Jonathan Nieder wrote:

> No preference, since I never use "git annotate" myself.  In fact,
> long term, I'd rather see a "git blame --format=<template>" appearing
> and "git annotate" replaced with a thin script wrapping "git blame".

Isn't that what it is already?

  $ grep blame builtin/annotate.c
  return cmd_blame(argc + 1, nargv, prefix);

-Peff
