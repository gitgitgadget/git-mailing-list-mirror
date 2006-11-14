X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 16:47:39 +0100
Message-ID: <20061114154739.GB5453@diana.vm.bytemark.co.uk>
References: <20061114134958.5326.qmail@science.horizon.com> <ejcl6l$bo0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 15:48:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejcl6l$bo0$1@sea.gmane.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31349>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk0W9-0004yw-L5 for gcvg-git@gmane.org; Tue, 14 Nov
 2006 16:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966135AbWKNPrn convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 10:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966137AbWKNPrn
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 10:47:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:55820 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S966135AbWKNPrm
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 10:47:42 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gk0Vf-00025b-00; Tue, 14 Nov 2006 15:47:39 +0000
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-14 15:53:18 +0100, Jakub Narebski wrote:

> linux@horizon.com wrote:
>
> > Then you could check out an arbitrary version without any of the
> > annoyance above; I could "git checkout tags/foo" or even "git
> > checkout deadbeef~3". I wouldn't be on a current branch (which
> > would necessitate changing "git branch" output), so HEAD would
> > simply contain an object ID directly rather than being a
> > symlink/symref.
>
> And what would happen if you want to checkout other branch? Where
> the ID in the HEAD would go to? HEAD just _has_ to be reference to
> _branch_.

The id that used to be HEAD would not be saved anywhere. It would
still be reachable from your refs, presumably, just like before you
checked it out. (It would not be the case that you had made commits on
an unnamed branch that would now get lost, because the tool would
refuse to commit until you had created a name for the branch.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
