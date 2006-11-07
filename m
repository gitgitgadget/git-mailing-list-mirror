X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: how to show log for only one branch
Date: Tue, 07 Nov 2006 10:21:25 +0800
Message-ID: <454FEDA5.1050607@gmail.com>
References: <454EAEDB.8020909@gmail.com>	<7vk629f6is.fsf@assigned-by-dhcp.cox.net> <454F1175.9080506@gmail.com> <7vslgwcueo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 7 Nov 2006 02:22:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=VSeeyYz7+9UutVWWW6qWYo0MiEyHwTyeyK96oxvBVc3k8fUS/NpQujRCWUg/yJc0Zufj++/gjTV0cit6/eyyTlmHDIne+tAb6WYZ64uqbo/Vv4bIn2hWmMrYpyksz/huate5DT7ltsdUEudvZ1pBTC/PYThKxaYp9Bo5jGFjngA=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
In-Reply-To: <7vslgwcueo.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31040>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhGbl-00036h-87 for gcvg-git@gmane.org; Tue, 07 Nov
 2006 03:22:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753952AbWKGCW3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 21:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbWKGCW3
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 21:22:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:11571 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1753952AbWKGCW2
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 21:22:28 -0500
Received: by wx-out-0506.google.com with SMTP id s14so1246047wxc for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 18:22:28 -0800 (PST)
Received: by 10.70.61.1 with SMTP id j1mr6074280wxa.1162866148008; Mon, 06
 Nov 2006 18:22:28 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id 24sm10264102wrl.2006.11.06.18.22.25; Mon, 06 Nov 2006 18:22:27 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Liu Yubao <yubao.liu@gmail.com> writes:
> 
>> ... For example, I want to know what happened in your
>> git's "next" branch, I hope to get logs like this:
>>     Merge branch 'jc/pickaxe' into next
>>     Merge branch 'master' into next
>>     Merge branch 'js/modfix' into next
>>     ...
>>     some good work
>>     ...
>>     Merge branch ....
>>
>> I just want to *outline* what happened in "next" branch, if I am interested
>> in what have been merged from 'jc/pickaxe' I can follow the merge point again
>> or use something like "git log --follow-all-parents".
> 
> My "next" is a bad example of this, because it is an integration
> branch and never gets its own development.  It is also a bad
> example because I can answer that question with this command
> line:
> 
> 	git log --grep='^Merge .* into next$' next
> 
> and while it is a perfectly valid answer, I know it would leave
> you feeling somewhat cheated.
> 
smart trick, but if the logs aren't consistent enough it's hard to
grep them out.

