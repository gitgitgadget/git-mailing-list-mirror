From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.0.rc1
Date: Sun, 31 Jan 2010 02:32:08 -0500
Message-ID: <20100131073208.GA15268@coredump.intra.peff.net>
References: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 08:35:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbUL8-0001RS-8G
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 08:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab0AaHcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 02:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275Ab0AaHcN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 02:32:13 -0500
Received: from peff.net ([208.65.91.99]:40639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab0AaHcM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 02:32:12 -0500
Received: (qmail 318 invoked by uid 107); 31 Jan 2010 07:32:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 31 Jan 2010 02:32:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2010 02:32:08 -0500
Content-Disposition: inline
In-Reply-To: <7vaavvi4r5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138531>

On Sat, Jan 30, 2010 at 02:53:34PM -0800, Junio C Hamano wrote:

>  * Various commands given by the end user (e.g. diff.type.textconv,
>    and GIT_EDITOR) can be specified with command line arguments.  E.g. it
>    is now possible to say "[diff "utf8doc"] textconv = nkf -w".

Does this deserve a mention in the "behavior changes" section, too, as
it may be breaking certain configs (most likely those with full paths to
filters which have spaces in them)?

-Peff
