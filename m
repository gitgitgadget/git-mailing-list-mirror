X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git tag: don't complain of empty messages
Date: Wed, 15 Nov 2006 17:05:22 +0100
Message-ID: <455B3AC2.10107@xs4all.nl>
References: <ejfc1t$6am$1@sea.gmane.org> <Pine.LNX.4.63.0611151657570.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 16:05:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0611151657570.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31449>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkNGT-000727-7v for gcvg-git@gmane.org; Wed, 15 Nov
 2006 17:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030624AbWKOQFY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 11:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWKOQFY
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 11:05:24 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:46862 "EHLO
 smtp-vbr5.xs4all.nl") by vger.kernel.org with ESMTP id S1030624AbWKOQFX
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 11:05:23 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kAFG5KSJ054197; Wed, 15 Nov 2006 17:05:20 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin escreveu:
> Hi,
> 
> On Wed, 15 Nov 2006, Han-Wen Nienhuys wrote:
> 
>> GIT refuses to set annotated tags without a comment. I think this is a silly
>> restriction when the message is explicitly set to the empty string.
> 
> I think that this behaviour is on purpose: The tag will be identified 
> (like all objects in git) by its contents. The rationale: the filename 
> does not matter, since the tag _object_ is not identified by it. So, in 
> case you lose your .git/refs/tags/ directory, you can still reconstruct 
> the tags with "git-fsck-objects --full".

Without a message, the tag can still be identified by its name, which is 
in the tag object contents.

-- 
