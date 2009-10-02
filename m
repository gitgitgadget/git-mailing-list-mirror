From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] add NORETURN_PTR for function pointers
Date: Thu, 1 Oct 2009 20:43:25 -0400
Message-ID: <20091002004325.GA506@coredump.intra.peff.net>
References: <1254333950-2440-1-git-send-email-kusmabite@gmail.com>
 <1254333950-2440-2-git-send-email-kusmabite@gmail.com>
 <20091001081710.GC13436@coredump.intra.peff.net>
 <40aa078e0910010957q4daf104cja218af3aa5424637@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, gitster@pobox.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 02:43:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtWFH-0004MJ-B1
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 02:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbZJBAn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 20:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbZJBAn2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 20:43:28 -0400
Received: from peff.net ([208.65.91.99]:60301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbZJBAn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 20:43:27 -0400
Received: (qmail 23512 invoked by uid 107); 2 Oct 2009 00:46:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Oct 2009 20:46:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Oct 2009 20:43:25 -0400
Content-Disposition: inline
In-Reply-To: <40aa078e0910010957q4daf104cja218af3aa5424637@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129417>

On Thu, Oct 01, 2009 at 09:57:12AM -0700, Erik Faye-Lund wrote:

> On Thu, Oct 1, 2009 at 1:17 AM, Jeff King <peff@peff.net> wrote:
> > Thanks, this version and (your 1/2) both look sane to me. The only thing
> > missing are some Makefile knobs to tweak this, but I will assume that
> > will come as part of a later MSVC-compatibility series.
> 
> Thanks for reviewing :)
> 
> I sent an additional patch to the msysgit mailing-list that defines
> NORETURN for MSVC, but I think it's better to keep it out of git.git
> for a little while. There's no Makefile-knobs, it checks for _MSC_VER
> (similar to what's done for GCC).

That sounds good. Thanks.

-Peff
