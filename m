From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] completion: Use consistent if [...] convention. No
	test.
Date: Wed, 11 Feb 2009 17:25:03 -0500
Message-ID: <20090211222503.GF29955@coredump.intra.peff.net>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com> <1234375406-27099-2-git-send-email-ted@tedpavlic.com> <1234375406-27099-3-git-send-email-ted@tedpavlic.com> <7v63jgg7st.fsf@gitster.siamese.dyndns.org> <49931C3F.4000903@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, spearce <spearce@spearce.org>,
	git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 23:27:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXNXX-0001qi-2U
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 23:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbZBKWZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 17:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbZBKWZH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 17:25:07 -0500
Received: from peff.net ([208.65.91.99]:54607 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbZBKWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 17:25:06 -0500
Received: (qmail 3679 invoked by uid 107); 11 Feb 2009 22:25:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 17:25:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 17:25:03 -0500
Content-Disposition: inline
In-Reply-To: <49931C3F.4000903@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109538>

On Wed, Feb 11, 2009 at 01:43:11PM -0500, Ted Pavlic wrote:

> In Vim, I have "exapndtabs" set by default. I manually turned it off, but 
> during testing, I must have closed Vim and re-opened and forgot to turn it 
> back off.
>
> Some time ago, I suggested adding a vim modeline to the file to handle  
> turning expandtabs off for everyone who edits it with vim. That change  
> got denied.

FWIW, I do this in my .vimrc:

  au BufNewFile,BufRead /path/to/git/repo/* set noet sts=8 sw=8 ts=8

-Peff
