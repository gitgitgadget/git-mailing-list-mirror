From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] clone: detect extra arguments
Date: Sat, 31 Oct 2009 12:32:27 +0100
Message-ID: <200910311232.27278.johan@herland.net>
References: <20091029081030.GA11213@progeny.tock>
 <20091030144525.GA22583@coredump.intra.peff.net>
 <20091030145108.GA881@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 12:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4CHO-0007Ty-2t
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 12:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520AbZJaLcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2009 07:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757507AbZJaLcZ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Oct 2009 07:32:25 -0400
Received: from smtp.getmail.no ([84.208.15.66]:57768 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757504AbZJaLcY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Oct 2009 07:32:24 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSD00K41MQ4L060@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 31 Oct 2009 12:32:28 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSD00G02MQ3CK20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 31 Oct 2009 12:32:28 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.31.112126
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <20091030145108.GA881@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131839>

On Friday 30 October 2009, Jeff King wrote:
> On Fri, Oct 30, 2009 at 10:45:25AM -0400, Jeff King wrote:
> > But looking at the usage message, there is some potential for cleanup.
> 
> Also, we should probably do this (I did it as a patch on master, though,
> as it is an independent fix):
> 
> -- >8 --
> Subject: [PATCH] clone: fix --recursive usage message
> 
> Looks like a mistaken cut-and-paste in e7fed18a.

Yes. Please fix my screwup.

> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Johan Herland <johan@herland.net>

> ---
>  builtin-clone.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 5762a6f..436e8da 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -61,7 +61,7 @@ static struct option builtin_clone_options[] = {
>  	OPT_BOOLEAN('s', "shared", &option_shared,
>  		    "setup as shared repository"),
>  	OPT_BOOLEAN(0, "recursive", &option_recursive,
> -		    "setup as shared repository"),
> +		    "initialize submodules in the clone"),
>  	OPT_STRING(0, "template", &option_template, "path",
>  		   "path the template repository"),
>  	OPT_STRING(0, "reference", &option_reference, "repo",
> 

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
