From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 2/5] git-config: add --remote option for reading config from remote repo
Date: Fri, 4 May 2007 23:03:40 +0200
Message-ID: <20070504210339.GB30324@planck.djpig.de>
References: <11782762032207-git-send-email-skimo@liacs.nl> <1178276203127-git-send-email-skimo@liacs.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Fri May 04 23:03:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk4wO-0005pH-79
	for gcvg-git@gmane.org; Fri, 04 May 2007 23:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031688AbXEDVDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 17:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031701AbXEDVDo
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 17:03:44 -0400
Received: from planck.djpig.de ([85.10.192.180]:3928 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031688AbXEDVDn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 17:03:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 5C460274014;
	Fri,  4 May 2007 23:03:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mo+moEqJdmAQ; Fri,  4 May 2007 23:03:40 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 30182274013; Fri,  4 May 2007 23:03:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1178276203127-git-send-email-skimo@liacs.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46215>


Some comments on the documentation:

On Fri, May 04, 2007 at 12:56:40PM +0200, Sven Verdoolaege wrote:
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] name [value [value_regex]]

maybe something more like

'git-config' [ scope ]

where you mention later that scope can be --system | --global | --remote
would be more readable...

> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --add name value
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --replace-all name [value [value_regex]]
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --get name [value_regex]
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --get-all name [value_regex]
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --unset name [value_regex]
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --unset-all name [value_regex]
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --rename-section old_name new_name
> +'git-config' [--system | --global | --remote=[<host>:]<directory ]
> +	     [type] --remove-section name
> +'git-config' [--system | --global | --remote=[<host>:]<directory ] -l | --list
>  
>  DESCRIPTION
>  -----------
> @@ -80,6 +89,10 @@ OPTIONS
>  	Use system-wide $(prefix)/etc/gitconfig rather than the repository
>  	.git/config.
>  
> +--remote=[<host>:]<directory
> +	Use remote config instead of the repository .git/config.
> +	Only available for reading options.

Why did you add it to all options in the SYNOPSYS then?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
