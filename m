From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git send-email brakes patches with very long lines
Date: Thu, 17 Jan 2008 10:32:52 -0500
Message-ID: <20080117153252.GD2816@coredump.intra.peff.net>
References: <478F2994.9080708@users.sourceforge.net> <478F5478.7000200@users.sourceforge.net> <478F5798.6020405@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ryan Anderson <ryan@michonline.com>
To: Adam Piatyszek <ediap@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Jan 17 16:33:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFWkB-0005cL-Pi
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 16:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbYAQPc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 10:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbYAQPc4
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 10:32:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3858 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbYAQPc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 10:32:56 -0500
Received: (qmail 4090 invoked by uid 111); 17 Jan 2008 15:32:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 17 Jan 2008 10:32:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2008 10:32:52 -0500
Content-Disposition: inline
In-Reply-To: <478F5798.6020405@users.sourceforge.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70869>

On Thu, Jan 17, 2008 at 02:26:48PM +0100, Adam Piatyszek wrote:

> RFC2822 (Internet Message Format) states:
>
>   2.1.1. Line Length Limits
>
>     There are two limits that this standard places on the number of
>     characters in a line. Each line of characters MUST be no more than
>     998 characters, and SHOULD be no more than 78 characters, excluding
>     the CRLF.
> [...]
>
> Now, the question is. Don't you think that "git send-email" should at  
> least warn users that they are trying to send emails with patches that  
> will be broken at the end?

It could actually QP-encode the data in that case, I think. git-mailinfo
appears to have code to handle the decoding.

-Peff
