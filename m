From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] repack: improve documentation on -a option
Date: Sat, 30 Jun 2007 13:15:51 +0200
Message-ID: <20070630111551.GR12721@planck.djpig.de>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz> <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 30 13:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4aw3-0000s8-7k
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 13:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbXF3LQJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 07:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbXF3LQI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 07:16:08 -0400
Received: from planck.djpig.de ([85.10.192.180]:2966 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900AbXF3LQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 07:16:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id D161A88105;
	Sat, 30 Jun 2007 13:16:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NcONRNDLcW2w; Sat, 30 Jun 2007 13:15:52 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id E9540881B4; Sat, 30 Jun 2007 13:15:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11831937813223-git-send-email-sam.vilain@catalyst.net.nz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51212>

On Sat, Jun 30, 2007 at 08:56:12PM +1200, Sam Vilain wrote:
>  -a::
>  	Instead of incrementally packing the unpacked objects,
> -	pack everything available into a single pack.
> +	pack everything referenced into a single pack.
>  	Especially useful when packing a repository that is used
> -	for private development and there is no need to worry
> -	about people fetching via dumb file transfer protocols
> -	from it.  Use with '-d'.
> +	for private development and there no need to worry

Got "is" lost here intentionally? The change doesn't make sense
to me.

> +	about people fetching via dumb protocols from it.  Use
> +	with '-d'.  This will clean up the objects that `git prune`
> +	leaves behind, but `git fsck-objects --full` shows as
> +	dangling.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
