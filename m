X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: David Lang <dlang@digitalinsight.com>
Subject: Re: Can git be tweaked to work cross-platform, on FAT32?
Date: Tue, 19 Dec 2006 13:57:52 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0612191357020.18007@qynat.qvtvafvgr.pbz>
References: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
NNTP-Posting-Date: Tue, 19 Dec 2006 22:15:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <0MKwpI-1GuWVF2znk-0006fC@mrelayeu.kundenserver.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34859>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwnFN-0002Xt-E7 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 23:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933048AbWLSWP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 17:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933049AbWLSWP1
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 17:15:27 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:37912 "HELO
 warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
 id S933047AbWLSWPZ (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 17:15:25 -0500
Received: from wlvims02.diginsite.com by warden.diginsite.com via smtpd (for
 vger.kernel.org [209.132.176.167]) with SMTP; Tue, 19 Dec 2006 14:15:24 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by
 wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Tue, 19
 Dec 2006 14:15:11 -0800
To: "Florian v. Savigny" <lorian@fsavigny.de>
Sender: git-owner@vger.kernel.org

On Wed, 13 Dec 2006, Florian v. Savigny wrote:

> I would like to use git to develop a somewhat larger Perl project
> which I would need to test and develop under both Linux and Windows,
> i.e. I would need a repository on a FAT32 partition (to my knowledge,
> still the only filesystem that can be fully accessed from both OSes -
> correct me if I'm wrong)

there are drivers available for windows to let it access ext2/3 partitions. I 
don't know if that would help any in this situation.

David Lang
