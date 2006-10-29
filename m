X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 29 Oct 2006 19:39:05 +0100
Message-ID: <200610291939.06270.jnareb@gmail.com>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <ei2563$m1u$1@sea.gmane.org> <20061029182454.GT17019@over-yonder.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 29 Oct 2006 18:39:34 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bNFbeGxwT/jhIzAnC4qZ13wDhsYx+86UwjCoasgRJoWN0+KP2+3stMAwR66ibNtqr+E/kBdWYzvEk6C7crRoQBrI7RpG5v3hF4z6rpC/zXkf1vEZBX2lkYBzWf1ZLSnf/HylI++yCA2BQJIlcfNBqCYA+Dz5KsAfHyrOv1j5lb4=
User-Agent: KMail/1.9.3
In-Reply-To: <20061029182454.GT17019@over-yonder.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30437>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeFZ2-0005V5-3X for gcvg-git@gmane.org; Sun, 29 Oct
 2006 19:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965324AbWJ2SjR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 13:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWJ2SjR
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 13:39:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:15677 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S932405AbWJ2SjQ
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 13:39:16 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1001636ugm for
 <git@vger.kernel.org>; Sun, 29 Oct 2006 10:39:14 -0800 (PST)
Received: by 10.67.97.7 with SMTP id z7mr2856694ugl; Sun, 29 Oct 2006
 10:39:14 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id 28sm1970951ugc.2006.10.29.10.39.14; Sun, 29 Oct
 2006 10:39:14 -0800 (PST)
To: "Matthew D. Fuller" <fullermd@over-yonder.net>
Sender: git-owner@vger.kernel.org

Matthew D. Fuller wrote:
> On Sun, Oct 29, 2006 at 01:01:07PM +0100 I heard the voice of
> Jakub Narebski, and lo! it spake thus:
>>
>> Do you really often compile and run other branch while developing on
>> other?
> 
> Yes.  And I do the same with older revisions along a given branch too,
> where is where [lightweight] checkouts come in handy.

Well, if you don't _work_ on other branch, you can alwaych checkout
the other branch or any given revision from a separate directory
using
  git --git-dir=<path to repo> tar-tree <revision> | tar xf -
for example.
-- 
Jakub Narebski
