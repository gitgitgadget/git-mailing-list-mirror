From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation - pt-BR.
Date: Mon, 5 Oct 2009 06:09:10 -0400
Message-ID: <20091005100910.GA866@coredump.intra.peff.net>
References: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
 <7vhbuek3ma.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 12:18:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mukeg-0006l0-7G
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 12:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbZJEKJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 06:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932518AbZJEKJ5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 06:09:57 -0400
Received: from peff.net ([208.65.91.99]:59756 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932512AbZJEKJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 06:09:57 -0400
Received: (qmail 16174 invoked by uid 107); 5 Oct 2009 10:12:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 06:12:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 06:09:10 -0400
Content-Disposition: inline
In-Reply-To: <7vhbuek3ma.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129549>

On Sun, Oct 04, 2009 at 06:53:49PM -0700, Junio C Hamano wrote:

> Not reading Portuguese, I have two comments.
> 
>  - How well does AsciiDoc and its manpage backend work with these standard
>    section names localized?
> 
>  - The length of the underline must match the section header word it
>    underlines.
> 
> Has anybody actually tried to format this document, either before or after
> your patch?

No, I didn't, and I should have when I picked up the patch in the first
place. You are right, asciidoc barfs (both for html and xml generation):

  ERROR: gittutorial.txt: line 5: first section must be named NAME
  ERROR: gittutorial.txt: line 9: second section must be named SYNOPSIS

-Peff
