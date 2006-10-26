X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: an option to make "git-diff Z A" prints Z's diff before A's
Date: Thu, 26 Oct 2006 10:42:21 +0200
Message-ID: <20061026084221.GB13780@diana.vm.bytemark.co.uk>
References: <871wowzx15.fsf@rho.meyering.net> <7vd58g9pfs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 08:42:45 +0000 (UTC)
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vd58g9pfs.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30153>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd0os-00029z-2T for gcvg-git@gmane.org; Thu, 26 Oct
 2006 10:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965246AbWJZImb convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 04:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965254AbWJZImb
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 04:42:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14092 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S965246AbWJZIma
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 04:42:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gd0of-0003cO-00; Thu, 26 Oct 2006 09:42:21 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 2006-10-25 12:16:07 -0700, Junio C Hamano wrote:

> The thing is, "git diff -- Z A" does *not* mean:
>
>       I know I have a file called Z and a file called A; please give
>       diff for these files.
>
> What it means is:
>
>       Please give me the diff as usual, but I care about paths that
>       match these patterns, Z or A.

A related question: is there a way to limit the path to Z, but
excluding Z/B? That is, I'm interested in the changes in Z, but not
the changes in its subdirectory B.

--=20
Karl Hasselstr=F6m, kha@treskal.com
