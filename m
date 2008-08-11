From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] builtin-revert: Make use of merge_recursive()
Date: Mon, 11 Aug 2008 23:46:39 +0200
Message-ID: <20080811214639.GA28340@leksak.fem-net>
References: <20080811190924.GR18960@genesis.frugalware.org> <1218491096-28756-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 11 23:47:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSfEx-00076B-HH
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 23:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbYHKVqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 17:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbYHKVqp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 17:46:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:59940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751567AbYHKVqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 17:46:44 -0400
Received: (qmail invoked by alias); 11 Aug 2008 21:46:43 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp040) with SMTP; 11 Aug 2008 23:46:43 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1//B8A9Phr/Czv2a/qye5fhm3o/4A0tJTEgmdUB4g
	OpRP+3d/f1wpga
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KSfDr-0007Us-VP; Mon, 11 Aug 2008 23:46:39 +0200
Content-Disposition: inline
In-Reply-To: <1218491096-28756-1-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92007>

Sorry, I forgot to change this to [PATCH v2] or something.

And...

Stephan Beyer wrote:
> diff --git a/merge-recursive.h b/merge-recursive.h
> index f37630a..a9eead3 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -1,6 +1,8 @@
>  #ifndef MERGE_RECURSIVE_H
>  #define MERGE_RECURSIVE_H
>  
> +extern struct commit *make_virtual_commit(struct tree *tree,
> +					  const char *comment);
>  int merge_recursive(struct commit *h1,
>  		    struct commit *h2,
>  		    const char *branch1,

Is this a mistake that some forward declarations in header files are not
declared "extern"?

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
