From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Use tabs for indent in shell scripts
Date: Tue, 01 Aug 2006 02:50:12 -0700
Message-ID: <7vr70023aj.fsf@assigned-by-dhcp.cox.net>
References: <200607292239.11034.jnareb@gmail.com> <ean0a1$irf$1@sea.gmane.org>
	<7vd5bk3mqo.fsf@assigned-by-dhcp.cox.net>
	<200608011134.52006.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 11:50:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7qtH-0004Ld-TH
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 11:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWHAJuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 05:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWHAJuP
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 05:50:15 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26311 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1161025AbWHAJuO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 05:50:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060801095013.EYT2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Aug 2006 05:50:13 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608011134.52006.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 1 Aug 2006 11:34:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24587>

Jakub Narebski <jnareb@gmail.com> writes:

>  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
> -    curl_extra_args="-k"
> +	curl_extra_args="-k"
>  fi

Things like this makes some sense...

>  		if test -n "$use_separate_remote" &&
> -		   branch_name=`expr "z$name" : 'zheads/\(.*\)'`
> +			branch_name=`expr "z$name" : 'zheads/\(.*\)'`
>  		then

... but not this, which is not just indent but an alignment.

>  		case "$2" in
>  		'')
> -		    usage ;;
> +			usage ;;
>  		*/*)
> -		    echo >&2 "'$2' is not suitable for an origin name"
> -		    exit 1
> +			echo >&2 "'$2' is not suitable for an origin name"
> +			exit 1

Also shell scripts tend to become too deeply indented, and 4-column
indentation helps to keep things within typical screen width.

In short, not very enthused.
