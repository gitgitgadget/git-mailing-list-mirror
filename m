X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 23:07:13 +0100
Message-ID: <20061117220713.GH7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <455E1BF1.1030003@midwinter.com> <7virhdiwon.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 22:07:37 +0000 (UTC)
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7virhdiwon.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31735>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlBrl-0000go-65 for gcvg-git@gmane.org; Fri, 17 Nov
 2006 23:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753309AbWKQWHR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 17:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbWKQWHR
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 17:07:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:64898 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1753309AbWKQWHP (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 17:07:15 -0500
Received: (qmail 12345 invoked by uid 2001); 17 Nov 2006 23:07:13 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Fri, Nov 17, 2006 at 10:35:04PM CET, Junio C Hamano wrote:
> Unfortunately the only way to know if there will be a file-level
> conflict is to try one, and stashing away the current state just
> in case it conflicted is a performance penalty, so this probably
> should stay as an option just like "-m" to the "checkout".

I think it would be just great if it worked at least for fast-forwarding
case; I think this is where it is actually most useful. Cogito tries to
support even the three-way case as long as the changes touch different
files, but I'm not sure if it was a good idea to begin with.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
