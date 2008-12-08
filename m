From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] gitk: Starting translation for Norwegian
Date: Mon, 8 Dec 2008 08:45:58 -0800
Message-ID: <20081208164558.GH31551@spearce.org>
References: <20081203225411.GA12563@frsk.net> <20081208163103.GF31551@spearce.org> <20081208163854.GA21631@frsk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fredrik Skolmli <fredrik@frsk.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:47:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9jGV-0004tV-CU
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYLHQp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbYLHQp7
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:45:59 -0500
Received: from george.spearce.org ([209.20.77.23]:33987 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbYLHQp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:45:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2F93D38200; Mon,  8 Dec 2008 16:45:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081208163854.GA21631@frsk.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102556>

Fredrik Skolmli <fredrik@frsk.net> wrote:
> On Mon, Dec 08, 2008 at 08:31:03AM -0800, Shawn O. Pearce wrote:
> > Can you resend as an attachment?  The email encoding is listed as
> > iso-8859-1 but the file content looks to be UTF-8.  msgfmt doesn't
> > like it after the patch is applied.
> 
> Sure, does this file work?

Nope, after application I'm still getting multibyte errors from
msgfmt:

  $ make V=1
  msgfmt --statistics --tcl -l nb -d po/ po/nb.po
  po/nb.po:56:15: invalid multibyte sequence
  ...

Looking at the MIME data mutt is reporting the attachment is
still iso-8859-1.  I guess its time to fix your mail client,
or gzip the patch and send the .gz attachment instead...

-- 
Shawn.
