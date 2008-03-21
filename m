From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Easier setup for the vim contribs.
Date: Thu, 20 Mar 2008 21:46:27 -0400
Message-ID: <20080321014627.GB1613@coredump.intra.peff.net>
References: <1206031364.1717.11.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 02:47:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcWLf-0001mP-2Y
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 02:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbYCUBqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 21:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbYCUBqb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 21:46:31 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3362 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751723AbYCUBqa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 21:46:30 -0400
Received: (qmail 13167 invoked by uid 111); 21 Mar 2008 01:46:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Mar 2008 21:46:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Mar 2008 21:46:27 -0400
Content-Disposition: inline
In-Reply-To: <1206031364.1717.11.camel@omicron.ep.petrobras.com.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77694>

On Thu, Mar 20, 2008 at 01:42:44PM -0300, Victor Bogado da Silva Lins wrote:

> Just copy all files in the vim contrib directory to your .vim and it
> will configure the syntax.

I think this is a good change, but...

> +  2.  Auto-detect the editing of git commit files:
> +      $ mkdir -p $HOME/.vim/ftdetect
> +	  $ cp ftdetect/gitcommit.vim $HOME/.vim/ftdetect

There is a slight tabs vs spaces indentation error here.

-Peff
