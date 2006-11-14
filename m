X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: when is a remote a branch?
Date: Tue, 14 Nov 2006 21:44:10 +0100
Message-ID: <20061114204410.GK7201@pasky.or.cz>
References: <ej7fra$8ca$2@sea.gmane.org> <200611121831.18851.jnareb@gmail.com> <20061114202835.GJ7201@pasky.or.cz> <200611142136.17517.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 20:44:49 +0000 (UTC)
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611142136.17517.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31371>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk597-0002Om-6S for gcvg-git@gmane.org; Tue, 14 Nov
 2006 21:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966346AbWKNUoN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 15:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966348AbWKNUoN
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 15:44:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2745 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S966347AbWKNUoM (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 15:44:12 -0500
Received: (qmail 18855 invoked by uid 2001); 14 Nov 2006 21:44:10 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Tue, Nov 14, 2006 at 09:36:16PM CET, Jakub Narebski wrote:
> Petr "Pasky" Baudis wrote:
> > On Sun, Nov 12, 2006 at 06:31:18PM CET, Jakub Narebski wrote:
> >>
> >> By the way, with introduction of branches and remotes in config file,
> >> you can say:
> >>  [branch "localbranch"]
> >> 	remote = someremote
> >>  [remote "someremote"]
> >> 	fetch = remotebranch:localbranch
> >> 	push  = remotebranch:localbranch
> >> 
> >> and that would be equivalent to example branches file from
> >> the beginning of this email.
> > 
> > According to the documentation, this is not really useful since this
> > just tells what should git fetch default to when on branch
> > "localbranch". But "localbranch" is still just a branch representing a
> > state in a remote repository, so you should never be _on_ it in a sane
> > setup, but instead on a different branch which tracks it.
> 
> Oh. Can you "git fetch Localbranch" _without_ repository named 
> "localbranch" in above case?

So that it would be equivalent to git fetch someremote, and also fetch
any other branches associated with that remote?

I would hope not. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
