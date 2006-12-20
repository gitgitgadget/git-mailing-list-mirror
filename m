X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Change in git-svn dcommit semantics?
Date: Wed, 20 Dec 2006 06:47:45 -0500
Message-ID: <360A3F7A-0849-4BCE-8550-1F05BB9821C5@silverinsanity.com>
References: <m2mz5jegka.fsf@ziti.local> <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com> <Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de> <C2881A17-27F7-467C-B353-189BB7DBFD1E@silverinsanity.com> <7v3b7bnz6q.fsf@assigned-by-dhcp.cox.net> <emb77h$cf2$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 20 Dec 2006 11:47:58 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <emb77h$cf2$1@sea.gmane.org>
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34917>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwzvM-0006Xz-I6 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 12:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752877AbWLTLrt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 06:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbWLTLrt
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 06:47:49 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:37405 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1752877AbWLTLrt (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 06:47:49 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 5B59B1FFC02B; Wed, 20 Dec 2006
 11:47:48 +0000 (UTC)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org


On Dec 20, 2006, at 6:38 AM, Jakub Narebski wrote:

> Junio C Hamano wrote:
>
>> The --full-diff option helps because it shows the diff for other
>> files (that do not have different number of substring COLLISION
>> in the pre and postimage) in the same commit as well.
>
> Yet another undocumented option. Sigh...

I'd send in a patch to fix that (little gnome work is what I do in  
Wikipedia, and seems to be what I do here), but the option seems to  
be in setup_revision.c:setup_revisions, which is used in several  
places.  Is there a central place to put that in the documentation?   
Should there be?

