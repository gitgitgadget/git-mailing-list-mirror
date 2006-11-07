X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: If merging that is really fast forwarding creates new commit
Date: Tue, 07 Nov 2006 11:42:07 +0800
Message-ID: <4550008F.8030809@gmail.com>
References: <454EAEDB.8020909@gmail.com> <7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F31D7.1030202@gmail.com> <20061106133923.GB1151@robert.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 03:43:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=A2CoHBfQYHaQ1+XuSVHM7IPdWF3b5aGA0/q3sf8Gi5OYAO6OnGHY6vuiOgPO9jIdD2slr/aV6yaT4XvMYUoknaoFtudl1WVh8hzDZ3nmLYksqymkEvYFLdh5kF+Qhds4RTfHubtBYA8SO4ELO/sm/TksoP78XleG8dlgjCMQTCU=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <20061106133923.GB1151@robert.daprodeges.fqdn.th-h.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31043>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhHry-0007MN-4E for gcvg-git@gmane.org; Tue, 07 Nov
 2006 04:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753976AbWKGDnL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 22:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753977AbWKGDnL
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 22:43:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:59045 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1753976AbWKGDnK
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 22:43:10 -0500
Received: by wx-out-0506.google.com with SMTP id s14so1265301wxc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 19:43:10 -0800 (PST)
Received: by 10.70.15.15 with SMTP id 15mr6200649wxo.1162870989528; Mon, 06
 Nov 2006 19:43:09 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id h34sm9565643wxd.2006.11.06.19.43.07; Mon, 06 Nov 2006 19:43:09 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Rocco Rutte wrote:
> Hi,
> 
> * Liu Yubao [06-11-06 21:00:07 +0800] wrote:
> 
>> Then, what bad *logical* problem will happen if a merging that is 
>> really a fast forwarding creates a new commit?
> 
> I don't know what you expect by "logical" nor if I get you right, but if 
> fast-forward merge a branch to another one, both branches now have 
> exactly the same hash. If you create a commit object for a fast-forward 
> merge, both tip hashes not identical anymore... which is bad.
Not so bad, you can know they point to same tree objects.

Fast forwarding style merge will blow away the *track* of your branch,
and this track is useful, that is why reflog appears.
> 
> The identical hash important so that you really know they're identical 
> and for future reference like ancestry.
I guess you have mixed identical commits with identical trees. Trees
is what we really need.

Fake commit doesn't mess the ancestry relation, you can refer to
my previous mail replied to Andreas Ericsson in this topic.
> 
>   bye, Rocco
