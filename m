From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge, pull: introduce '--diffstat' option
Date: Sun, 6 Apr 2008 09:53:05 -0400
Message-ID: <20080406135304.GA24269@coredump.intra.peff.net>
References: <20080403103056.GD6673@coredump.intra.peff.net> <1207406935-22144-1-git-send-email-szeder@ira.uka.de> <200804051835.54097.tlikonen@iki.fi> <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 06 15:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiVJt-0005Gz-GQ
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 15:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYDFNxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 09:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYDFNxK
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 09:53:10 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1872 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbYDFNxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 09:53:09 -0400
Received: (qmail 18247 invoked by uid 111); 6 Apr 2008 13:53:06 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Apr 2008 09:53:06 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Apr 2008 09:53:05 -0400
Content-Disposition: inline
In-Reply-To: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78893>

On Sat, Apr 05, 2008 at 11:51:51AM -0700, Junio C Hamano wrote:

> I'd favor, in the longer run:
> 
>  * --stat option to mean "show the diffstat between ORIG_HEAD and merge
>    result" (i.e. current --summary);
> 
>  * perhaps a new configuration merge.stat to control the default for the
>    above;
> 
>  * merge.log configuration to mean "add list of one-line log to the merge
>    commit message" (i.e. current merge.summary);
> 
>  * perhaps a --log option to override the config default for each
>    invocation.
> 
>  * deprecate --summary and merge.summary and remove them long after people
>    are used to the above new set.

I'll add a belated "yes I agree" to this. This is what I was trying to
describe earlier in the thread, but for some reason couldn't think of
the obvious name "log" to replace merge.summary. :)

-Peff
