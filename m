X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb: Add committags support (take 2)
Date: Wed, 6 Dec 2006 21:35:44 +0100
Message-ID: <200612062135.44658.jnareb@gmail.com>
References: <200612040001.13640.jnareb@gmail.com> <200612062032.58706.jnareb@gmail.com> <7vpsaw3iyp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 20:33:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AAa7en5yWZ3p4UevGlPUS4z6u1dOC+ZzCQkz79B/yc3oY6UN5TEc2uwHgW/t/fB5KRPF/BX9AQmskD76m43cUM/26BkeDvvvqvjimXQ1mrvDQ7QBAmaovX4Xibtm7hvrAA62QHiRvzvhpmmEIpwBLPZ4FdDRRBU2Zv9OCtPFwXk=
User-Agent: KMail/1.9.3
In-Reply-To: <7vpsaw3iyp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33518>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs3Sd-0002oD-Ji for gcvg-git@gmane.org; Wed, 06 Dec
 2006 21:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937612AbWLFUdo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 15:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937611AbWLFUdo
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 15:33:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:21724 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937629AbWLFUdo (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 15:33:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so258008uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 12:33:42 -0800 (PST)
Received: by 10.66.242.20 with SMTP id p20mr1503692ugh.1165437222366; Wed, 06
 Dec 2006 12:33:42 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id y1sm21156862uge.2006.12.06.12.33.41; Wed, 06 Dec
 2006 12:33:41 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> By the way, what is the formal structure of the config file? Perhaps
>> something like the notation used in RFC?
> 
> Is there an RFC for .INI format?

I don't think INI is standarized at all. The format of INI files is not 
well defined. That's why I'd like to know exact format of git INI-like 
config file format.

But what I meant was description of git config file in (used by RFCs)
augmented Backus-Naur Form (BNF) - RFC 4234.
 
>> Is it possible (and doesn't crash current git config parser) having
>>
>>   [gitweb]
>>   	blame = yes
>>   	pickaxe = no
>>   	snapshot = bzip2
>>
>>   [gitweb "committags"]
>>   	message-id = "http://news.gmane.org/find-root.php?message_id="
>>   	mantis = "http://bugs.or.cz/view.php?id="
>>   	url
>>   	sha1
>>
>> in the config file?
> 
> If you are asking about [gitweb] stanza and (seemingly
> overlapping) [gitweb "foo"] stanza, we already have prior
> examples:
> 
> 	[diff]
>         	color = auto
>         [diff "color"]
>         	whitespace = blue reverse
> 
> so your example in the above would be legal (the dash in
> 'message-id' part might be questionable, though).

That's what I was asking for. Thanks for an explanation.

-- 
Jakub Narebski
