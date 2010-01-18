From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit: match explicit-ident semantics for summary and
 template
Date: Sun, 17 Jan 2010 20:47:35 -0500
Message-ID: <20100118014735.GA6831@coredump.intra.peff.net>
References: <20100117193401.GA28448@coredump.intra.peff.net>
 <201001172153.44413.j6t@kdbg.org>
 <7viqb0xubf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 02:47:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWgig-0001j7-Oj
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jan 2010 02:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998Ab0ARBrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 20:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327Ab0ARBrl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 20:47:41 -0500
Received: from peff.net ([208.65.91.99]:59084 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab0ARBrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 20:47:40 -0500
Received: (qmail 31808 invoked by uid 107); 18 Jan 2010 01:52:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 17 Jan 2010 20:52:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2010 20:47:35 -0500
Content-Disposition: inline
In-Reply-To: <7viqb0xubf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137355>

On Sun, Jan 17, 2010 at 02:03:48PM -0800, Junio C Hamano wrote:

> We could say something like
> 
> 	if (!(user_ident_explicitly_given & IDENT_EMAIL_GIVEN))
> 
> and it probably is a safer change on platforms with GECOS available, but
> then wouldn't msysgit folks have to fork this code?

I hadn't thought to be specific to "email must be given". That is, I had
assumed if you gave a name but not email, you would also be considered
competent enough to avoid the warning. But I really can't see anybody
doing that, so the semantics you suggest above are fine by me.

As far as Windows goes, I have no opinion on the correct behavior. But
if they are going to do something different, your encapsulation makes
sense to me.

-Peff
