From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-cherry should show "+" instead of "-" and vice versa
Date: Mon, 23 Oct 2006 21:33:26 +0200
Message-ID: <20061023193326.GS20017@pasky.or.cz>
References: <200610232003.08861.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 21:33:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc5YC-0001iM-66
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 21:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWJWTd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 15:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751851AbWJWTd2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 15:33:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64165 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751054AbWJWTd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 15:33:28 -0400
Received: (qmail 12204 invoked by uid 2001); 23 Oct 2006 21:33:26 +0200
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610232003.08861.andyparkins@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29867>

Dear diary, on Mon, Oct 23, 2006 at 09:03:08PM CEST, I got a letter
where Andy Parkins <andyparkins@gmail.com> said that...
> In git-cherry.sh:
> 
>   if test -f "$patch/$2"
>   then
>     sign=-
>   else
>     sign=+
>   fi
> 
> Documentation says 'If the change seems to be in the upstream, it is shown on
> the standard output with prefix "+"', however the above does the reverse.  
> When
> the file $patch/$2 exists it is because the patch /is/ in upstream so the sign
> should be "+".
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

See also

	http://news.gmane.org/find-root.php?message_id=<Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi>

Did the documentation ever get fixed or noone cared enough? ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
