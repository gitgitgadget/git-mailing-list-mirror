X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Show project's README.html if available
Date: Tue, 24 Oct 2006 21:19:15 +0200
Message-ID: <20061024191915.GV18879@pasky.or.cz>
References: <20061024113057.GA20017@pasky.or.cz> <524029.7339.qm@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 24 Oct 2006 19:19:53 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <524029.7339.qm@web31812.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30003>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcRo2-0001ZW-MH for gcvg-git@gmane.org; Tue, 24 Oct
 2006 21:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751472AbWJXTTT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006
 15:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbWJXTTT
 (ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 15:19:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18104 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1751472AbWJXTTS (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 15:19:18 -0400
Received: (qmail 29044 invoked by uid 2001); 24 Oct 2006 21:19:15 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

On Tue, Oct 24, 2006 at 09:09:03PM CEST, Luben Tuikov wrote:
> --- Petr Baudis <pasky@suse.cz> wrote:
> > > Why not instead re-submit a patch implementing what was discussed
> > > in this thread bearing the same name:
> > > 
> > > http://marc.theaimsgroup.com/?t=116044914900001&r=1&w=2
> > 
> > This implements
> > 
> > 	http://marc.theaimsgroup.com/?l=git&m=116047939517299&w=2
> > 
> > I see no other ideas I could take there except various naming proposals
> > and perhaps using File::Copy but I'll wait until someone does a
> > gitweb-wide change for the latter.
> > 
> > I don't really care _what_ name it bears, but I'd like to have it
> > included. :-)
> 
> People have suggested that this functionality be folded into the
> "Description" column, where the description printed is the
> first line of the description file "description" and if clicked
> on, it shows the whole "descrption" file.

Please look at the mail the mail I referred was a reply to:

	http://marc.theaimsgroup.com/?l=git&m=116047773825208&w=2

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
