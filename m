From: Gerrit Pape <pape@smarden.org>
Subject: Re: git-clone: Unobvious error messages when update-server-info
	has not been run
Date: Tue, 18 Dec 2007 12:23:05 +0000
Message-ID: <20071218122305.6582.qmail@8b22a037a8fc83.315fe32.mid.smarden.org>
References: <20071217105541.GG14889@albany.tokkee.org> <20071217124359.GA20800@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Harl <sh@tokkee.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 18 13:23:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4bTe-0001cs-FR
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 13:23:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbXLRMWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 07:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbXLRMWs
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 07:22:48 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:37559 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752926AbXLRMWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 07:22:48 -0500
Received: (qmail 6583 invoked by uid 1000); 18 Dec 2007 12:23:05 -0000
Content-Disposition: inline
In-Reply-To: <20071217124359.GA20800@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68736>

On Mon, Dec 17, 2007 at 07:43:59AM -0500, Jeff King wrote:
> git-clone is supposed to detect this condition, but there was a bug in
> the error checking code. Can you confirm that this patch fixes it?
> 
> Gerrit, I think was caused by your f28dd477 (it is a funny shell
> interaction that the non-followed case branch resets $?, but it behaves
> the same with bash and dash).

Yes, I didn't expect that, but can confirm the problem and the fix.

Thanks, Gerrit.
