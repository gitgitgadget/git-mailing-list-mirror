X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 10:51:06 +0100
Message-ID: <20061103095106.GB16721@diana.vm.bytemark.co.uk>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca> <20061103081232.GB15972@diana.vm.bytemark.co.uk> <20061103042540.192bbd18.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 3 Nov 2006 09:51:46 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103042540.192bbd18.seanlkml@sympatico.ca>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30809>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfvhv-0001MX-4z for gcvg-git@gmane.org; Fri, 03 Nov
 2006 10:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752784AbWKCJvW convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006 04:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752785AbWKCJvW
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 04:51:22 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:18957 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1752784AbWKCJvW
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 04:51:22 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gfvha-0004et-00; Fri, 03 Nov 2006 09:51:06 +0000
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On 2006-11-03 04:25:40 -0500, Sean wrote:

> Yeah.. Although fetching multiple remotes makes more sense as an
> optimization, especially when using a separate remotes namespace.

That's what "git fetch" is for. :-)

> Perhaps the real confusion is created because the only porcelain
> level merge command current in Git is "git pull .". A separate name
> might make things easier to grasp.

Indeed. Having pull =3D fetch + merge and not having a porcelain merge
command is not good, usability-wise. As is, one _has_ to learn the
weird ways of pull even if one is only interested in using separate
commands to fetch and merge.

--=20
Karl Hasselstr=F6m, kha@treskal.com
