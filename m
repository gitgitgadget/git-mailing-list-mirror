X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] make 'git add' a first class user friendly interface to the index
Date: Sat, 02 Dec 2006 11:11:14 +0100
Organization: At home
Message-ID: <ekrjc9$8uc$1@sea.gmane.org>
References: <Pine.LNX.4.64.0612011444310.9647@xanadu.home> <7vpsb36yem.fsf@assigned-by-dhcp.cox.net> <87veku3i0j.wl%cworth@cworth.org> <7vlklq20n5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Sat, 2 Dec 2006 10:09:44 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33017>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqRoP-00088L-F6 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 11:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759421AbWLBKJc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 05:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759422AbWLBKJc
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 05:09:32 -0500
Received: from main.gmane.org ([80.91.229.2]:54993 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1759421AbWLBKJc (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 05:09:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GqRoF-00086X-9x for git@vger.kernel.org; Sat, 02 Dec 2006 11:09:27 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 11:09:27 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sat, 02 Dec 2006
 11:09:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:

> By the way, aren't people disturbed that "git rm" does not
> default to "-f" -- I rarely use the command myself but that
> makes it feel even more awkward that "git rm foo" does not
> remove the file "foo".

But _only_ if file is unmodified. I think that "git rm" meaning
"remove this file from version control, but not from working area"
is a good thing; if you want to remove file, just /usr/bin/rm it.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

