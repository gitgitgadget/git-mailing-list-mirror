X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: check if a commit is ascendent of a specific commit
Date: Sat, 11 Nov 2006 13:12:59 +0100
Message-ID: <20061111121259.GB11224@diana.vm.bytemark.co.uk>
References: <fcaeb9bf0611110308l577d70bfo5046d7d7eb09ac58@mail.gmail.com> <ej4ba6$oqt$1@sea.gmane.org> <fcaeb9bf0611110331q53522c50sda399d4a7916636d@mail.gmail.com> <200611111256.20157.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sat, 11 Nov 2006 12:13:26 +0000 (UTC)
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611111256.20157.jnareb@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31216>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GirjV-0000Py-HL for gcvg-git@gmane.org; Sat, 11 Nov
 2006 13:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424568AbWKKMND convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006 07:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424569AbWKKMND
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 07:13:03 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:49929 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1424568AbWKKMNB
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 07:13:01 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GirjI-0003Ma-00; Sat, 11 Nov 2006 12:13:00 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-11 12:56:19 +0100, Jakub Narebski wrote:

> Dnia sobota 11. listopada 2006 12:31, Nguyen Thai Ngoc Duy napisa??:
>
> > Yes. That's what I want. I am tempted to edit older commits just
> > because I forgot to add some entries to .gitignore that I should
> > have added sooner :-)
>
> In pure git you would have to create new branch at the commit you
> want to amend, amend the commit (in this branch), and rebase (or
> cherry-pick if you need to edit other commits too) the rest, then
> rename branch. Or if you don't want ot loose reflog, tag/branch
> current branch, then reset (rewind) current branch to the commit you
> want to amend, then cherry-pick.
>
> Or you can use cg-admin-rewritehist tool from Cogito.

In case the history you want to edit is linear (that is, merge-free),
StGIT is an excellent tool. It is very easy to go back to a previous
commit (stg pop), amend it (stg refresh), and replay the following
commits on top of the amended commit (stg push).

--=20
Karl Hasselstr=F6m, kha@treskal.com
