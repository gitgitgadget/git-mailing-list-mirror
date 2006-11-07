X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: how to show log for only one branch
Date: Tue, 07 Nov 2006 11:47:54 +0800
Message-ID: <455001EA.5040306@gmail.com>
References: <454EAEDB.8020909@gmail.com> <eink3u$pmh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 03:49:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=CGBSun8AS/yo6HXToLVN2QM8ZVwIamrh3bZzDF7Nu+p0YPYielXC8MwYdVcWRiT1B2xXfROywca50Qffr8mDxA24I3sdmC5lobrkEEQxawvTQN1yZMee5QSDMR/V6Y8m1ocwet9D//7oOIBzPd5qXLjHygs6stGtBScHX1510nA=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <eink3u$pmh$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31044>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhHxM-0007wt-Ty for gcvg-git@gmane.org; Tue, 07 Nov
 2006 04:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753985AbWKGDs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 22:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753986AbWKGDs6
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 22:48:58 -0500
Received: from wx-out-0506.google.com ([66.249.82.237]:59309 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1753985AbWKGDs5
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 22:48:57 -0500
Received: by wx-out-0506.google.com with SMTP id s14so1266643wxc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 19:48:57 -0800 (PST)
Received: by 10.70.118.4 with SMTP id q4mr6209426wxc.1162871336907; Mon, 06
 Nov 2006 19:48:56 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id i10sm7862385wxd.2006.11.06.19.48.54; Mon, 06 Nov 2006 19:48:56 -0800 (PST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> Perhaps what you want is git log --committer=<owner of repo>?
> 
Thanks, it can't meet my requirement, if I create two branches
and merge them, I can't easily tell the track of those two branches.
