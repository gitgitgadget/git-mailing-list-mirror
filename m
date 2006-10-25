X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about commit message conventions
Date: Wed, 25 Oct 2006 17:23:51 +0200
Message-ID: <453F8187.9060208@op5.se>
References: <200610241549.48238.t.toedter@gmx.net> <20061024140856.GH5639@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 15:24:08 +0000 (UTC)
Cc: Tobias Toedter <t.toedter@gmx.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <20061024140856.GH5639@harddisk-recovery.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30066>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gckbn-0004mJ-2i for gcvg-git@gmane.org; Wed, 25 Oct
 2006 17:23:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030470AbWJYPXz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 11:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWJYPXz
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 11:23:55 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:18630 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030470AbWJYPXz (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 11:23:55 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id EA4C16BD05; Wed,
 25 Oct 2006 17:23:53 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 75D2B6BCF0; Wed, 25 Oct 2006 17:23:51 +0200 (CEST)
To: Erik Mouw <erik@harddisk-recovery.com>
Sender: git-owner@vger.kernel.org

Erik Mouw wrote:
> On Tue, Oct 24, 2006 at 03:49:44PM +0200, Tobias Toedter wrote:
> 
>> On the other hand, concerning the approval of other developers, what's the 
>> difference between "Signed-off-by:" and "Acked-by:"? Are there any 
>> more "*-by:" fields that are in use?
> 
> Acked-by is usually used when someone (not the upstream maintainer the
> patch was send to) agrees with the patch. I.e.: (s)he says the content
> of the patch is OK without actually acknowledging something about the
> right to submit.
> 

If you sift through the Linux kernel, you will find numerous patches 
where subsystem maintainers have acked patches sent to them. I *think* 
this usually means that they have reviewed the patch and approve of it, 
but not modified it. The Ack is then solely for Linus' benefits and 
tells him that at least one pair of eyes have already gone over the patch.

Subsys maintainers sometimes also add Signed-off-by: lines, which I 
assume means they have tweaked the patch somewhat or somehow 
collaborated with the author in producing it. I know Junio signs off 
patches he modifies, and I'm guessing this habit is inherited from the 
kernel workflow which was most likely encouraged by Linus when he was 
the Git maintainer.

Lots of guesswork here, but in a sane world I can't be too far off the 
mark ;-)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
