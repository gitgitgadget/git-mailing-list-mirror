X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-svnimport: support for partial imports
Date: Thu, 26 Oct 2006 10:47:10 +0200
Message-ID: <20061026084710.GC13780@diana.vm.bytemark.co.uk>
References: <20061025225026.GA13031@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 08:47:37 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Matthias Urlichs <smurf@smurf.noris.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061025225026.GA13031@sashak.voltaire.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30154>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0ta-0002tF-5G for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751755AbWJZIrR convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 04:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWJZIrR
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:47:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:17676 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1751755AbWJZIrR
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:47:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gd0tK-0003di-00; Thu, 26 Oct 2006 09:47:10 +0100
To: Sasha Khapyorsky <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

On 2006-10-26 00:50:26 +0200, Sasha Khapyorsky wrote:

> This adds support for partial svn imports. Let's assume that SVN
> repository layout looks like:
>
>   $trunk/path/to/our/project
>   $branches/path/to/our/project
>   $tags/path/to/our/project
>
> , and we would like to import only tree under this specific
> 'path/to/our/project' and not whole tree under $trunk, $branches,
> etc.. Now we will be be able to do it by using '-P
> path/to/our/project' option with git-svnimport.

Isn't this already doable with "-T trunk/path/to/our/project -t
tags/path/to/our/project -b branches/path/to/our/project"?

--=20
Karl Hasselstr=F6m, kha@treskal.com
