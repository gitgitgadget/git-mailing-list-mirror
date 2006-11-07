X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to show log for only one branch
Date: Tue, 07 Nov 2006 09:21:46 +0100
Organization: At home
Message-ID: <eipflf$k0r$1@sea.gmane.org>
References: <454EAEDB.8020909@gmail.com>	<7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F1175.9080506@gmail.com> <7vslgwcueo.fsf@assigned-by-dhcp.cox.net> <454FEDA5.1050607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 7 Nov 2006 08:21:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 23
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31053>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhMDC-000279-Ax for gcvg-git@gmane.org; Tue, 07 Nov
 2006 09:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754108AbWKGIVf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 03:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbWKGIVf
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 03:21:35 -0500
Received: from main.gmane.org ([80.91.229.2]:28114 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1754108AbWKGIVe (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 03:21:34 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GhMCt-00023G-2y for git@vger.kernel.org; Tue, 07 Nov 2006 09:21:19 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 09:21:19 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 07 Nov 2006
 09:21:19 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Liu Yubao wrote:

> Junio C Hamano wrote:
>> [...]  It is also a bad
>> example because I can answer that question with this command
>> line:
>> 
>>      git log --grep='^Merge .* into next$' next
>> 
>> and while it is a perfectly valid answer, I know it would leave
>> you feeling somewhat cheated.
>> 
> smart trick, but if the logs aren't consistent enough it's hard to
> grep them out.

Well, commit message for merges are generated automatically. And if you set
merge.summary=true in repo config (or your config), then you have shortlog
in merge commit message by default...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

