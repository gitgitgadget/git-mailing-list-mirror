From: Petr Baudis <pasky@suse.cz>
Subject: Re: On blame/pickaxe
Date: Tue, 17 Oct 2006 02:44:29 +0200
Message-ID: <20061017004429.GC20017@pasky.or.cz>
References: <7vr6xddm7h.fsf@assigned-by-dhcp.cox.net> <20061016022159.GZ20017@pasky.or.cz> <7v8xjgvjys.fsf@assigned-by-dhcp.cox.net> <200610161602.49811.Josef.Weidendorfer@gmx.de> <453393E5.3020203@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 17 02:44:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZd4M-0006wE-UE
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422992AbWJQAoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422994AbWJQAoc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:44:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17312 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422992AbWJQAob (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:44:31 -0400
Received: (qmail 20131 invoked by uid 2001); 17 Oct 2006 02:44:29 +0200
To: Andy Whitcroft <apw@shadowen.org>
Content-Disposition: inline
In-Reply-To: <453393E5.3020203@shadowen.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29009>

Dear diary, on Mon, Oct 16, 2006 at 04:15:01PM CEST, I got a letter
where Andy Whitcroft <apw@shadowen.org> said that...
> Josef Weidendorfer wrote:
> > Hi,
> > 
> > this blame-passing thing really looks very promising and powerful.
> > 
> > On Monday 16 October 2006 08:43, you wrote:
> >> If the user is not prepared to see code movement, pickaxe can be
> >> run without -M nor -C to get the classic blame output.

Ok, so in this case -M and -C does not mean just looking for
copies/movements in other files but inside the same file as well.

Perhaps we might want to differentiate those two cases since searching
in all files might be significantly slower.

> > Another blame-passing heuristic would be very interesting for code:
> > "Ignore white-space changes".
> > This way, commits which only do some reindentations simply are skipped.
> > 
> > It looks like such a thing would just be a matter of passing "-b" to
> > executions of "diff" in the blame-passing algorithm.
> 
> I am thinking that that is probabally going to need to be optional, for
> example python the indentation is everything to the meaning of the code.

(OTOH, just today I was retrieving some code from deep inside a script
to a common function, which of course caused massive indentation shift.
So it is very desirable in order to catch these. But more we get
involved in this, the more we will probably want to know about the
syntax of the content we are digging in.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
