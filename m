From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 1/2] Show html help with git-help --html
Date: Tue, 5 Jun 2007 21:34:51 +0200
Message-ID: <20070605193451.GG17377@planck.djpig.de>
References: <20070605183420.GA8450@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 21:35:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hveo9-00052d-IA
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 21:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380AbXFETe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 15:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758671AbXFETe7
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 15:34:59 -0400
Received: from planck.djpig.de ([85.10.192.180]:4709 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755380AbXFETe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 15:34:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 57B2688105;
	Tue,  5 Jun 2007 21:34:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwgU0vojA2Xy; Tue,  5 Jun 2007 21:34:52 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 2A637881B4; Tue,  5 Jun 2007 21:34:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070605183420.GA8450@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49220>

On Tue, Jun 05, 2007 at 06:34:20PM +0000, Nguyen Thai Ngoc Duy wrote:
> +core.help::
> +	If 'html', it is equivalent to 'git-help' with option --html.
> +	If 'auto', it tries to open html files first. If that attempt fails
> +	(the html program does not exist or the program return non-zero
> +	value), then it will fall back to man pages. If 'man', always use
> +	man pages as usual.

This should mention the default value. (Which is 'man', if I read the
code correctly, isn't it?)

> +core.htmlprogram::
> +	Specify the program used to open html help files when 'git-help'
> +	is called with option --html or core.help is other than 'man'.
> +	By default, xdg-open will be used.
> +	Special strings '%p', '%f' and '%b' will be replaced with html
> +	full path, file name and git command (without .html suffix)
> +	respectively. If none is given, '%p' will be automatically appended
> +	to the command line.

htmlprogram sounds kludgy to me. I would've used htmlcommand or perhaps
htmlviewer. But I'm no native English speaker, so I might be entirely
wrong about that.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
