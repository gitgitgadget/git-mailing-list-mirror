From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH] add series editor support.
Date: Mon, 30 Jul 2007 14:27:56 -0400
Message-ID: <20070730182756.GA14278@filer.fsl.cs.sunysb.edu>
References: <20070730100512.GA14637@dnb.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Jeff Sipek <jsipek@cs.sunysb.edu>, git@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 20:28:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFZyV-0002Qg-Ud
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 20:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761543AbXG3S2H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760522AbXG3S2G
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 14:28:06 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:51415 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518AbXG3S2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 14:28:04 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6UIRuPV014621;
	Mon, 30 Jul 2007 14:27:56 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6UIRubw014619;
	Mon, 30 Jul 2007 14:27:56 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <20070730100512.GA14637@dnb.sw.ru>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54248>

On Mon, Jul 30, 2007 at 02:05:12PM +0400, Dmitry Monakhov wrote:
> Usually we have to edit series file directly (via editor).
> I think it is not bad idea to let guilt export this service.
> IMHO "guilt-series -e" it the best way to do it.
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>

Applied with a small cleanup to make things a little bit more consistent (
[ ! -z "$edit" ]   vs.  [ "$edit" = "t" ] ).

Thanks,

Josef 'Jeff' Sipek.

-- 
Failure is not an option,
It comes bundled with your Microsoft product.
