X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: If merging that is really fast forwarding creates new commit [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 13:17:42 +0100
Organization: At home
Message-ID: <eiptfr$2pd$1@sea.gmane.org>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <454F3BED.9010401@op5.se> <454FFCE6.70408@gmail.com> <4550522D.9060503@shadowen.org> <45507692.7050100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 7 Nov 2006 12:17:52 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 17
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31067>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhPtj-0002Qb-Io for gcvg-git@gmane.org; Tue, 07 Nov
 2006 13:17:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932367AbWKGMRh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 07:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWKGMRg
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 07:17:36 -0500
Received: from main.gmane.org ([80.91.229.2]:11208 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S932367AbWKGMRf (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 07:17:35 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GhPtK-0002N4-Lz for git@vger.kernel.org; Tue, 07 Nov 2006 13:17:23 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 13:17:22 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 07 Nov 2006
 13:17:22 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Liu Yubao wrote:
[...]
I think everything stems from the fact that git repositories which pull/push
with each other _share_ [parts of] DAG. Learn to live with it, or chose
different SCM. 

You want branch a path through DAG, not only as lineage sub-DAG... but
recodring this information is I think costly.

Note also that the pointers to DAG branches are can be name differently in
different repositories (e.g. 'master' in one repository might be 'origin'
in the other, and 'remotes/origin/master' in yet another).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

