X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 16:32:58 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611141627200.2591@xanadu.home>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <ejdapj$vc0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Ey2lklRRJueR5sPtK9Rrwg)"
NNTP-Posting-Date: Tue, 14 Nov 2006 21:33:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <ejdapj$vc0$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31379>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk5tv-0003ip-Oh for gcvg-git@gmane.org; Tue, 14 Nov
 2006 22:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966375AbWKNVdA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 16:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966373AbWKNVdA
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 16:33:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19157 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S966375AbWKNVc7 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 16:32:59 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J8Q001BNP6Y8GH5@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Tue,
 14 Nov 2006 16:32:58 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Ey2lklRRJueR5sPtK9Rrwg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 14 Nov 2006, Jakub Narebski wrote:

> Nicolas Pitre wrote:
> 
> > If the fetch+merge behavior (which I think should really be refered as 
> > pull+merge) is still desirable, then it should be called git-update and 
> > be no more than a single shell script line such as
> > 
> >         git_pull && git_merge"
> > 
> > This is really what most people expect from such a command name based 
> > on obvious historical reasons.  The lack of any branch argument to 
> > git-pull and git-merge could be defined as using the first defined 
> > remote branch by default.  But having git-pull performing merges is IMHO 
> > overloading the word and goes against most people's expectations.
> 
> By the way, is anyone doing _remote_ octopus pull (true pull, not with . as
> repository)?
> 
> We can always have --merge arguments to git-pull, and --fetch argument to
> git-merge.

That would be a complete abomination if you want my opinion.

Please let git-pull actually pull stuff from a remote place, and 
git-merge actually merge stuff only.  Let's keep simple concepts mapped 
to simple commands please.  Nothing prevents _you_ from scripting more 
involved operations with a single command of your liking afterwards.


Nicolas

