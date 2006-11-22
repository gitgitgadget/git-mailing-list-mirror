X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: make HTML links out of http/https URLs in changelogs
Date: Wed, 22 Nov 2006 21:56:52 +0100
Message-ID: <20061122205652.GL7201@pasky.or.cz>
References: <4563777C.4050108@openvz.org> <20061122000655.GJ7201@pasky.or.cz> <45641195.2000804@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 22 Nov 2006 20:57:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45641195.2000804@openvz.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32102>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmz9O-00087X-9Z for gcvg-git@gmane.org; Wed, 22 Nov
 2006 21:56:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755910AbWKVU4z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 15:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756061AbWKVU4z
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 15:56:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:48561 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1755910AbWKVU4y (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 15:56:54 -0500
Received: (qmail 18968 invoked by uid 2001); 22 Nov 2006 21:56:52 +0100
To: Kir Kolyshkin <kir@openvz.org>
Sender: git-owner@vger.kernel.org

On Wed, Nov 22, 2006 at 10:00:05AM CET, Kir Kolyshkin wrote:
> Petr Baudis wrote:
> >On Tue, Nov 21, 2006 at 11:02:36PM CET, Kir Kolyshkin wrote:
> >  
> >>Slightly tested on http://git.openvz.org/. Applicable to git-1.4.4.
> >>    
> >
> >...but in git's gitweb view it will make this <a
> >href="http://git.openvz.org/.">http://git.openvz.org/.</a>. :-)
> Not a problem actually since "." means "current directory", so it will 
> work fine (and I have checked that) :)
> Sure there is a room for improvement for this regex -- and I am 
> collecting those.

But "http://git.openvz.org/index.html." might not work so fine, nor
"http://git.openvz.org/,"...

Bad URLs matchers which don't snip unlikely (!= invalid!) characters
from the end of the URL are my pet peeve. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
