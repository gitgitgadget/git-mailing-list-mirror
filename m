From: Jeff King <peff@peff.net>
Subject: Re: Draft release notes for 1.5.4 as of -rc1
Date: Thu, 20 Dec 2007 07:12:34 -0500
Message-ID: <20071220121234.GB417@coredump.intra.peff.net>
References: <7vhciers0o.fsf@gitster.siamese.dyndns.org> <4769DDC9.1030108@unixsol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Georgi Chorbadzhiyski <gf@unixsol.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 13:14:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5KI0-0001uG-2B
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 13:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763111AbXLTMMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 07:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763330AbXLTMMi
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 07:12:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3544 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763325AbXLTMMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 07:12:37 -0500
Received: (qmail 9107 invoked by uid 111); 20 Dec 2007 12:12:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Dec 2007 07:12:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2007 07:12:34 -0500
Content-Disposition: inline
In-Reply-To: <4769DDC9.1030108@unixsol.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68997>

On Thu, Dec 20, 2007 at 05:13:13AM +0200, Georgi Chorbadzhiyski wrote:

> >  * "git peek-remote" is deprecated, as "git ls-remote" was written in C
> >    and works for all transports, and will be removed in the future.
> 
> For me it is not clear from the above which command will be removed. If
> I understand it correctly probably this should sound better:
> 
>    * "git peek-remote" is deprecated and will be removed in the future.
>       The command was replaced by "git ls-remote" which works for all
>       transports.

Agreed. A rewording is in the patch I just sent.

-Peff
