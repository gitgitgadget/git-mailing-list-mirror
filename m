From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH/RFH] Mark user-manual as UTF-8
Date: Tue, 24 Jul 2007 10:50:31 -0400
Message-ID: <20070724145031.GB24302@fieldses.org>
References: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDLjT-00030y-Qq
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758608AbXGXOuh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 10:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbXGXOug
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:50:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:37893 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764975AbXGXOuf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 10:50:35 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IDLiZ-0006in-Ss; Tue, 24 Jul 2007 10:50:31 -0400
Content-Disposition: inline
In-Reply-To: <7vwswqgs6c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53602>

On Tue, Jul 24, 2007 at 12:46:35AM -0700, Junio C Hamano wrote:
> There have been several complaints against k.org's user-manual
> page.  The document is generated in ISO-8859-1 by the xsltproc
> toolchain (I suspect this is because released docbook.xsl we use
> has xsl:output element that says the output is ISO-8859-1) but
> server delivers it with "charset=UTF-8", and all h*ll breaks
> loose.
> 
> This attempts to force UTF-8 on the generating end.

Thanks for looking into this!  I've seen what I assume is the same
problem sporadically before and been unsuccesful at finding the
source....

--b.
