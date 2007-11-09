From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Fri, 9 Nov 2007 14:31:13 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091429120.4362@racer.site>
References: <473463E0.7000406@gmail.com> <fh1p10$nta$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jasampler@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 15:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUta-0000H9-RO
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 15:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759732AbXKIOb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 09:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbXKIOb1
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 09:31:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:49219 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752529AbXKIOb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 09:31:27 -0500
Received: (qmail invoked by alias); 09 Nov 2007 14:31:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp004) with SMTP; 09 Nov 2007 15:31:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QiWcWAJqQUb/vqgYH657PIT5FkBy3ftUvXP6FHB
	C0eOtT91crdDyl
X-X-Sender: gene099@racer.site
In-Reply-To: <fh1p10$nta$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64191>

Hi,

[re Cc:ing jasam]

On Fri, 9 Nov 2007, Jakub Narebski wrote:

> Carlos Rica wrote:
> 
> > +     struct option options[] = {
> > +             { OPTION_STRING, 'l', NULL, &list, "pattern", "list tag names",
> > +                     PARSE_OPT_OPTARG, NULL, (intptr_t) no_pattern },
> 
> > +             OPT_STRING('F', NULL, &msgfile, "file", "message in a file"),
> 
> Does it matter that you use OPTION_STRING here and OPT_STRING macro there?

I guess it is because of the PARSE_OPT_OPTARG thing, together with 
no_pattern.  We need to know if -l was specified, even if no argument was 
passed in.

Hth,
Dscho
