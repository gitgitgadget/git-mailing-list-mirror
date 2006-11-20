X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 21 Nov 2006 00:02:34 +0100
Organization: At home
Message-ID: <ejtc3e$tod$2@sea.gmane.org>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Mon, 20 Nov 2006 23:01:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 26
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31952>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmI8l-0004P7-Ml for gcvg-git@gmane.org; Tue, 21 Nov
 2006 00:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966405AbWKTXBY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966879AbWKTXBY
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 18:01:24 -0500
Received: from main.gmane.org ([80.91.229.2]:4743 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S966405AbWKTXBX (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 18:01:23 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GmI8W-0004Ll-Ge for git@vger.kernel.org; Tue, 21 Nov 2006 00:01:12 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 00:01:12 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 21 Nov 2006
 00:01:12 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> By the way, in todo branch, in Subpro.txt, there is talk about adding
>> link to submodule trees in _commit object_... well link to submodule tree
>> or commit, with the "mount point".
> 
> That was shot down by Linus and I agree with him.  "bind" was a
> bad idea because binding of a particular subproject commit into
> a tree is a property of the tree, not one of the commits that
> happen to have that tree.
  
"bind" was kind of "mount tree" idea; I agree that adding subproject
commits to trees is better idea than adding commits or trees to
superproject commit object.

By the way, what permissions get the subproject tree?

I wonder if it makes sense to be able to add tag objects instead
of commit objects to trees (depeel to tree or blob)...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

