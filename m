From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Removed redundant static functions such as update_tracking_ref()
 and verify_remote_names() from builtin-send-pack.c, and made the ones in
 transport.c not be static so they can be used instead.
Date: Sat, 25 Apr 2009 02:07:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904250206250.10279@pacific.mpi-cbg.de>
References: <1240546432-26212-1-git-send-email-andy@petdance.com> <20090424210418.GC13561@coredump.intra.peff.net> <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Andy Lester <andy@petdance.com>
X-From: git-owner@vger.kernel.org Sat Apr 25 02:09:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxVSv-0001bq-Ic
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 02:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbZDYAHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 20:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZDYAHj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 20:07:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:58935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750733AbZDYAHi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 20:07:38 -0400
Received: (qmail invoked by alias); 25 Apr 2009 00:07:37 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 25 Apr 2009 02:07:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kmCw1fFvkjKLsGJQXtb8Wlo43ESMQLahMm2lZ9Y
	wTEdcXeEJ287Bf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <99B4BF12-01B9-4A68-B2E0-EF5DF2595FF0@petdance.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117526>

Hi,

On Fri, 24 Apr 2009, Andy Lester wrote:

> On Apr 24, 2009, at 4:04 PM, Jeff King wrote:
> 
> >in git itself we usually use the imperative mood in commit mesages.
> 
> This was what I was looking for.  I think what I'll do is fold your 
> message into Documentation/SubmittingPatches and submit that as a patch 
> first.

I dunno.  The most important part of CodingGuidelines is this:

	As for more concrete guidelines, just imitate the existing code
	(this is a good guideline, no matter which project you are
	contributing to).

(And of course, this holds for the style of commit messages, too.)

Ciao,
Dscho
