X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: http git and curl 7.16.0
Date: Sun, 17 Dec 2006 12:32:35 +0100
Message-ID: <20061217113235.GJ25274MdfPADPa@greensroom.kotnet.org>
References: <20061118080708.428cbff6@athlon>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 17 Dec 2006 11:33:11 +0000 (UTC)
Cc: Git List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061118080708.428cbff6@athlon>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34685>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvuGM-0001b0-1N for gcvg-git@gmane.org; Sun, 17 Dec
 2006 12:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752463AbWLQLc7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 06:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbWLQLc7
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 06:32:59 -0500
Received: from smtp15.wxs.nl ([195.121.247.6]:39849 "EHLO smtp15.wxs.nl"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752463AbWLQLc6
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 06:32:58 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp15.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0JAF00N291EB2F@smtp15.wxs.nl> for
 git@vger.kernel.org; Sun, 17 Dec 2006 12:32:36 +0100 (CET)
Received: (qmail 8981 invoked by uid 500); Sun, 17 Dec 2006 11:32:35 +0000
To: George Sherwood <pilot@beernabeer.com>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 08:07:08AM +0400, George Sherwood wrote:
> I seem to be having a problem doing an http checkout with git built
> with curl 7.16.0 enabled.  If I build against curl 7.16.0 and try a
> clone, I get:
> 
> git clone http://dmlb2000.homelinux.org/~dmlb2000/git-repos/local/castfs.git
> error: Unable to start request error: Could not interpret heads/master
> as something to pull
> 
> If I rebuild git against curl 7.15.5 then I get:
[..]
> and the checkout finishes.
> 
> Has any one else seen this?

FWIW, I've seen the same with curl 7.16.0 on a Solaris 9 machine.
It worked fine with curl 7.15.0.

