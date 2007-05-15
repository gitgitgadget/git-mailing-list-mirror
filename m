From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 15 May 2007 00:50:44 -0400
Message-ID: <20070515045044.GB2805@fieldses.org>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org> <20070515042200.GA10884@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 06:50:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnozw-00079Q-G7
	for gcvg-git@gmane.org; Tue, 15 May 2007 06:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757118AbXEOEus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 00:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757309AbXEOEur
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 00:50:47 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44382 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758463AbXEOEur (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 00:50:47 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hnozk-0000q9-4P; Tue, 15 May 2007 00:50:44 -0400
Content-Disposition: inline
In-Reply-To: <20070515042200.GA10884@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47312>

On Tue, May 15, 2007 at 12:22:00AM -0400, Jeff King wrote:
> Your original mail _does_ claim utf-8 for me. I wonder if Karl's mail is
> getting munged by something along the path (my path is straight from vger to a
> qmail server that I know is doing no munging). The headers I received, for
> reference:

Hm.  Yes, so if I send that patch to myself with git-send-email, I see
the same thing as you:

...
> From:   "J. Bruce Fields" <bfields@citi.umich.edu>
> To:     Junio C Hamano <junkio@cox.net>
> Cc:     git@vger.kernel.org,
>         Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Subject: [PATCH 01/10] Add a birdview-on-the-source-code section to the user man
> ual
> Date:   Mon, 14 May 2007 11:21:20 -0400
> Message-Id: <11791560893572-git-send-email->
> X-Mailer: git-send-email 1.5.1.4.19.g69e2
> Content-Type: text/plain; charset=utf-8
> Content-Transfer-Encoding: 8bit
...

But the mail I got through the git list yesterday has some odd stuff in
it:

>From git-owner@vger.kernel.org Mon May 14 11:22:01 2007
Received: from vger.kernel.org ([209.132.176.167])
	by fieldses.org with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1HncN6-00051C-Mh
	for bfields@fieldses.org; Mon, 14 May 2007 11:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbXENPVe (ORCPT <rfc822;bfields@fieldses.org>);
	Mon, 14 May 2007 11:21:34 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
MIME-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbXENPVc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:32 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54954 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315AbXENPVb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:31 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMb-0004z0-E7; Mon, 14 May 2007 11:21:29 -0400
From:	"J. Bruce Fields" <bfields@citi.umich.edu>
To:	Junio C Hamano <junkio@cox.net>
Cc:	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date:	Mon, 14 May 2007 11:21:20 -0400
Message-Id: <11791560893572-git-send-email->
X-Mailer: git-send-email 1.5.1.4.19.g69e2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org
Status: RO

Any idea how that happened?

--b.
