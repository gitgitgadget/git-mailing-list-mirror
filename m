From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] git-commit.sh: convert run_status to a C builtin
Date: Thu, 7 Sep 2006 05:10:29 -0400
Message-ID: <20060907091028.GA22687@coredump.intra.peff.net>
References: <64c62cc942e872b29d7225999e74a07be586674a.1157610743.git.peff@peff.net> <20060907063621.GC17083@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 11:10:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFu6-0008Pc-FQ
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 11:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWIGJKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 05:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWIGJKb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 05:10:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1258 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751188AbWIGJKb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 05:10:31 -0400
Received: (qmail 32268 invoked from network); 7 Sep 2006 05:09:55 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 7 Sep 2006 05:09:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu,  7 Sep 2006 05:10:29 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060907063621.GC17083@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26624>

On Thu, Sep 07, 2006 at 02:36:21AM -0400, Jeff King wrote:

> +static void
> +status_print_updated_cb(struct diff_queue_struct *q,
> +                        struct diff_options *options,
> +                        void *data)
> [...]
> +		if (!shown_header) {
> +			status_print_header("Updated but not checked in",
> +					"will commit");
> +			s->commitable = 1;
> +		}

Sorry, this should set shown_header=1. That's what I get for making a
last minute change and not testing...

-Peff
