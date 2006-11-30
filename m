X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Thu, 30 Nov 2006 17:05:11 +0100
Organization: At home
Message-ID: <ekmvc6$inf$1@sea.gmane.org>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home> <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org> <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org> <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org> <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net> <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <ekmkoe$a52$1@sea.gmane.org> <ekmlf4$ask$3@sea.gmane.org> <m2odqpm0d6.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Thu, 30 Nov 2006 16:04:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32762>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoOH-0003lu-Af for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030641AbWK3QD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030642AbWK3QD5
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:03:57 -0500
Received: from main.gmane.org ([80.91.229.2]:53735 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030641AbWK3QD5 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:03:57 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpoNn-0003df-59 for git@vger.kernel.org; Thu, 30 Nov 2006 17:03:31 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 17:03:31 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 17:03:31 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Seth Falcon wrote:

> Jakub Narebski <jnareb@gmail.com> writes:

>> By the way, I think that git-commit should also watch the return code
>> from the editor, so you can ^C it to abort git-commit --amend.
> 
> For those using emacsclient, I don't think ^C will work.  Is there
> another way to undo an amended commit?  If not, is there any sense in
> detecting a magic comment to abort the ammend commit?

You can ^C the git-commit invocation.

And I guess ORIG_HEAD would help, and reflog certainly would help
reverting (undoing) amend of a commit.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

