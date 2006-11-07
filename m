X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: If merging that is really fast forwarding creates new commit
 [Was: Re: how to show log for only one branch]
Date: Tue, 07 Nov 2006 20:08:11 +0800
Message-ID: <4550772B.1040308@gmail.com>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <Pine.LNX.4.64.0611060734490.25218@g5.osdl.org> <45503553.3020605@gmail.com> <455055DD.2090903@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 12:09:31 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=czDxT3oD+Mv4ERa4YZeRV2ILW3h5fT7pQXsy3qMIKA4WMfeWJ53hmmwfLR7dEeYKK6+RpLJRyvzfhccEDbgfLgwWqx4U8cRjYtd2Jf0Yw8TdhpT9FC9tofvwTHvvxxW20CEaF539VYisnRnjdmEsAuZL2vetIDwlg4MQu0s41VM=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <455055DD.2090903@shadowen.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31066>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhPlW-0001A6-LM for gcvg-git@gmane.org; Tue, 07 Nov
 2006 13:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932426AbWKGMJP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 07:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWKGMJP
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 07:09:15 -0500
Received: from nz-out-0102.google.com ([64.233.162.194]:16680 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S932426AbWKGMJO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 07:09:14 -0500
Received: by nz-out-0102.google.com with SMTP id s1so955461nze for
 <git@vger.kernel.org>; Tue, 07 Nov 2006 04:09:14 -0800 (PST)
Received: by 10.35.70.17 with SMTP id x17mr2915485pyk.1162901353660; Tue, 07
 Nov 2006 04:09:13 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id p57sm6212333pyb.2006.11.07.04.09.11; Tue, 07 Nov 2006 04:09:13 -0800 (PST)
To: Andy Whitcroft <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

Andy Whitcroft wrote:
> 
> One thing to remember, when you merge the destination into which you
> merge will be HEAD^1, so by just following that you can get junio's view
> of his branch as he made it.
> 
> This is doesn't terminate properly, sucks the performance of your
> machine and generally should be erased rather than run; but you get the
> idea:
> 
> let n=0
> while git-show --pretty=one -s "next~$n"
> do
>         let "n=$n+1"
> done | less
> 
> -apw
> 
This is not a right way to view a branch track in git, see Junio's explanation
