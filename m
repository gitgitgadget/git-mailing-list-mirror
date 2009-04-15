From: Jeff King <peff@peff.net>
Subject: Re: "git cat-file <sha1>" shows usage but should not?
Date: Wed, 15 Apr 2009 13:36:41 -0400
Message-ID: <20090415173640.GB25480@coredump.intra.peff.net>
References: <49E61067.6060802@hartwork.org> <20090415165420.GB24528@coredump.intra.peff.net> <49E611A5.8090602@hartwork.org> <20090415170444.GA24717@coredump.intra.peff.net> <alpine.LNX.2.00.0904151827530.14321@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Pipping <webmaster@hartwork.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu93z-0001mi-Tg
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 19:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbZDORgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 13:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbZDORgr
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 13:36:47 -0400
Received: from peff.net ([208.65.91.99]:41839 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbZDORgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 13:36:46 -0400
Received: (qmail 27844 invoked by uid 107); 15 Apr 2009 17:36:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 15 Apr 2009 13:36:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2009 13:36:41 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0904151827530.14321@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116638>

On Wed, Apr 15, 2009 at 06:33:10PM +0100, Julian Phillips wrote:

> On Wed, 15 Apr 2009, Jeff King wrote:
>
>> static const char * const cat_file_usage[] = {
>> -	"git cat-file [-t|-s|-e|-p|<type>] <sha1>",
>> -	"git cat-file [--batch|--batch-check] < <list_of_sha1s>",
>> +	"git cat-file {-t|-s|-e|-p|<type>} <object>",
>> +	"git cat-file [--batch|--batch-check] < <list_of_objects>",
>
> Shouldn't that read:
>
> +	"git cat-file {--batch|--batch-check} < <list_of_objects>",
>
> since, like the previous line, you are required to supply one of the two  
> options?

Oops, yes, it should.

-Peff
