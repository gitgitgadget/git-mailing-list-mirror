From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] Documentation: Note file formats send-email accepts
Date: Fri, 20 Feb 2009 16:04:40 -0800
Message-ID: <20090221000440.GA7258@kroah.com>
References: <20090219035106.GG4505@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 01:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LafOA-0003JS-M6
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 01:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbZBUAFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 19:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbZBUAFF
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 19:05:05 -0500
Received: from kroah.org ([198.145.64.141]:35694 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751754AbZBUAFE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 19:05:04 -0500
Received: from localhost (c-76-105-230-205.hsd1.or.comcast.net [76.105.230.205])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by coco.kroah.org (Postfix) with ESMTPSA id 764374903F;
	Fri, 20 Feb 2009 16:05:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090219035106.GG4505@inocybe.teonanacatl.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110907>

On Wed, Feb 18, 2009 at 10:51:06PM -0500, Todd Zullinger wrote:
> +There are two formats accepted for patch files:
> +
> +1. mbox format files
> ++
> +This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
> +formatting are ignored.
> +
> +2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl'
> +script

You're kidding me, right?  I really don't believe anyone uses any
patches in that format, I haven't used that script in so long I just
noticed that I didn't even have a copy of it anywhere.

So if for some reason you are trying to be backwards compatible to my
old code, don't do it on my behalf.

thanks,

greg k-h
