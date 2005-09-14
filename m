From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree into another rather than two trees into merge base
Date: Wed, 14 Sep 2005 19:46:33 +0200
Message-ID: <200509141946.35002.blaisorblade@yahoo.it>
References: <200509102027.28812.blaisorblade@yahoo.it> <1126427087.8457.33.camel@localhost.localdomain> <43257BB3.5020506@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 19:50:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFbNp-0006rf-OI
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 19:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVINRtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 13:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVINRtT
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 13:49:19 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:28330 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1030273AbVINRtS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 13:49:18 -0400
Received: (qmail 52861 invoked from network); 14 Sep 2005 17:48:58 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=OGdIt+ueGqwxpNS2VbV6vhI68pVm+q6Ws7nE8nH0MMvL4C1A/znGHXUTN/GaHJc5Z9UVRjyFNlPGGEjc1e095KqMlfVicPGMd+uNWpSvDw5YmNpg6tJgyDjHkv4U1uXTq1GfrjLX/aPqa577eiFfJvtFb+jWlGn27S3grGFG18I=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@62.11.80.49 with login)
  by smtp003.mail.ukl.yahoo.com with SMTP; 14 Sep 2005 17:48:56 -0000
To: cel@citi.umich.edu
User-Agent: KMail/1.8.1
In-Reply-To: <43257BB3.5020506@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8546>

On Monday 12 September 2005 14:59, Chuck Lever wrote:
> Catalin Marinas wrote:
> > On Sat, 2005-09-10 at 20:27 +0200, Blaisorblade wrote:

> >>Today I was pushing my patch stack (which was against Linux 2.6.13) on
> >> top of the latest snapshot I have (i.e. upstream will likely have some
> >> mega of patches). And it was *really* slow (say it pushed 8 patches in 5
> >> minutes).

> > That's indeed very slow. How may files are modified in each patch? Do
> > you run it over NFS? Also for profiling, it is useful to run a 'stg
> > status' just to warm up the cache a little bit.

> i've probably seen similar behavior with git-update-index, but i never
> bothered to measure it.  blaisorblade, how are you profiling git?

I'm not, I just did the "testing" (actually I was simply using StGIT) I 
noticed and reported this behaviour (I even had time to run top to watch what 
was happening).

As said in the other answer, yes, I verified that it wasn't only for time 
spent getting cache-hot, and I'm not running on NFS, nor running big things 
in background.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
