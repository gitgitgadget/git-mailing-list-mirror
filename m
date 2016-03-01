From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] environment.c: introduce DECLARE_GIT_GETTER helper macro
Date: Tue, 1 Mar 2016 10:05:43 -0500
Message-ID: <20160301150543.GN12887@sigill.intra.peff.net>
References: <1456601744-18404-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: JunioCHamanogitster@pobox.com, Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 16:06:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aals9-0005Eo-7y
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 16:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbcCAPFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 10:05:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:52495 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753964AbcCAPFq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 10:05:46 -0500
Received: (qmail 28992 invoked by uid 102); 1 Mar 2016 15:05:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 10:05:45 -0500
Received: (qmail 8528 invoked by uid 107); 1 Mar 2016 15:05:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Mar 2016 10:05:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Mar 2016 10:05:43 -0500
Content-Disposition: inline
In-Reply-To: <1456601744-18404-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288033>

On Sun, Feb 28, 2016 at 01:35:44AM +0600, Alexander Kuleshov wrote:

> +DECLARE_GIT_GETTER(const char *, get_git_dir, git_dir)
> +DECLARE_GIT_GETTER(const char *, get_git_namespace, namespace)
> +DECLARE_GIT_GETTER(char *, get_object_directory, git_object_dir)
> +DECLARE_GIT_GETTER(char *, get_index_file, git_index_file)
> +DECLARE_GIT_GETTER(char *, get_graft_file, git_graft_file)

Hmm. I'm somewhat lukewarm on this patch. It's fewer lines and less
duplication, which is nice, but this kind of code generation often makes
things annoying (to step into with the debugger, to find with ctags,
etc). I dunno.

-Peff
