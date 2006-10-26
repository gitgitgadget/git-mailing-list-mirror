X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] git-svnimport: support for partial imports
Date: Thu, 26 Oct 2006 12:54:28 +0200
Message-ID: <20061026105428.GA16372@diana.vm.bytemark.co.uk>
References: <20061025225026.GA13031@sashak.voltaire.com> <20061026084710.GC13780@diana.vm.bytemark.co.uk> <20061026103120.GA15502@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 10:54:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Matthias Urlichs <smurf@smurf.noris.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061026103120.GA15502@sashak.voltaire.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30185>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd2sk-0007Xv-B1 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 12:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423237AbWJZKyj convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 06:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423239AbWJZKyj
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 06:54:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:35341 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1423237AbWJZKyi
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 06:54:38 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gd2sW-0004GT-00; Thu, 26 Oct 2006 11:54:28 +0100
To: Sasha Khapyorsky <sashak@voltaire.com>
Sender: git-owner@vger.kernel.org

On 2006-10-26 12:31:20 +0200, Sasha Khapyorsky wrote:

> On 10:47 Thu 26 Oct, Karl Hasselstr=F6m wrote:

> > Isn't this already doable with "-T trunk/path/to/our/project -t
> > tags/path/to/our/project -b branches/path/to/our/project"?
>
> In such case git-svnimport will not be able to resolve branches and
> tags names - note that actual SVN paths are:
>
>   branches/<branch-name>/path/to/our/project
>   tags/<tag-name>/path/to/our/project

Aahh, right. I didn't think of that.

--=20
Karl Hasselstr=F6m, kha@treskal.com
