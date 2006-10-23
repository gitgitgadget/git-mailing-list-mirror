From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/1] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 01:21:17 +0200
Message-ID: <20061023232117.GV20017@pasky.or.cz>
References: <200610230037.57183.jnareb@gmail.com> <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net> <200610240008.08325.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 01:21:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc96g-0001eJ-0O
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 01:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWJWXVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 19:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057AbWJWXVT
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 19:21:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42630 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751990AbWJWXVS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 19:21:18 -0400
Received: (qmail 8215 invoked by uid 2001); 24 Oct 2006 01:21:17 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610240008.08325.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29900>

Dear diary, on Tue, Oct 24, 2006 at 12:08:08AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> @@ -3307,19 +3303,19 @@ sub git_commitdiff {
>  		} elsif (scalar @{$co{'parents'}} == 1) {
>  			# single parent commit
>  			$formats_nav .=
> -				' (parent: ' .
> +				' (' .
>  				$cgi->a({-href => href(action=>"commitdiff",
>  				                       hash=>$co{'parent'})},
> -				        esc_html(substr($co{'parent'}, 0, 7))) .
> +				        'parent') .
>  				')';
>  		} else {
>  			# merge commit
>  			$formats_nav .=
> -				' (merge: ' .
> +				' (' .
>  				join(' ', map {
>  					$cgi->a({-href => href(action=>"commitdiff",
>  					                       hash=>$_)},
> -					        esc_html(substr($_, 0, 7)));
> +					        'parent');
>  				} @{$co{'parents'}} ) .
>  				')';
>  		}

For people not used to git, it would be more informative to keep the
'merge' text there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
