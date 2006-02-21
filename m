From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Add new git-rm command with documentation
Date: Tue, 21 Feb 2006 17:14:46 -0500
Message-ID: <20060221221446.GA20744@spearce.org>
References: <87u0ass7tj.wl%cworth@cworth.org> <43FB8F31.9090302@people.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 23:15:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBfme-0004PK-56
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 23:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWBUWOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 17:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWBUWOz
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 17:14:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42145 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932714AbWBUWOx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 17:14:53 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FBfmL-0005ab-1N; Tue, 21 Feb 2006 17:14:41 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id D5E6C20FBA0; Tue, 21 Feb 2006 17:14:46 -0500 (EST)
To: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Content-Disposition: inline
In-Reply-To: <43FB8F31.9090302@people.pl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16561>

How about supporting -- to break out of the option loop?  The rest
of the script will support files named --help just fine but the
option parser will just spit out usage information.

[...]
> +while : ; do
> +  case "$1" in
> +    -n)
> +	show_only=true
> +	;;
> +    -v)
> +	verbose=--verbose
> +	;;
> +	-f)
> +	remove_files=true
> +	;;
> +    -*)
> +	usage
> +	;;
> +    *)
> +	break
> +	;;
> +  esac
> +  shift
> +done
[...]

Also I don't think the -f option's whitespace matches the others...

-- 
Shawn.
