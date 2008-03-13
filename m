From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Thu, 13 Mar 2008 08:10:00 -0400
Message-ID: <20080313121000.GB19485@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213916.GK26286@coredump.intra.peff.net> <7viqzr4lua.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 13:10:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZmGg-0001Wu-QA
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 13:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYCMMKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752618AbYCMMKE
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:10:04 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4515 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752652AbYCMMKD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:10:03 -0400
Received: (qmail 26801 invoked by uid 111); 13 Mar 2008 12:10:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Mar 2008 08:10:01 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2008 08:10:00 -0400
Content-Disposition: inline
In-Reply-To: <7viqzr4lua.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77066>

On Wed, Mar 12, 2008 at 03:30:05PM -0700, Junio C Hamano wrote:

> Perhaps place
> 
>     #ifndef NO_EXTERNAL_GREP
>     #ifndef __unix__
>     #define NO_EXTERNAL_GREP 1
>     #else
>     #define NO_EXTERNAL_GREP 0
>     #endif
>     #endif
> 
> in git-compat-util.h, and make the in-code reference to
> 
>     #if NO_EXTERNAL_GREP
>             ... optimization using external grep ...
>     #endif

I agree that is much nicer. Looks like you have already marked it up in
pu; what is there looks sane.

-Peff
