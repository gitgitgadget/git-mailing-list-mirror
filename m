Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8043B1F609
	for <e@80x24.org>; Wed, 28 Nov 2018 09:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeK1UCy (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 15:02:54 -0500
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:48356 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727382AbeK1UCv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Nov 2018 15:02:51 -0500
Received: from webmail.xs4all.nl ([IPv6:2001:888:0:22:194:109:20:200])
        by smtp-cloud7.xs4all.net with ESMTPA
        id RvjIgXibqfGaRRvjIgGwHZ; Wed, 28 Nov 2018 10:01:56 +0100
Received: from a83-162-234-136.adsl.xs4all.nl ([83.162.234.136])
 by webmail.xs4all.nl
 with HTTP (HTTP/1.1 POST); Wed, 28 Nov 2018 10:01:56 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 28 Nov 2018 10:01:56 +0100
From:   Houder <houder@xs4all.nl>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v1/RFC 1/1] 'git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
In-Reply-To: <nycvar.QRO.7.76.6.1811280944520.41@tvgsbejvaqbjf.bet>
References: <xmqq1s75u9im.fsf@gitster-ct.c.googlers.com>
 <1543384528-4498-1-git-send-email-houder@xs4all.nl>
 <nycvar.QRO.7.76.6.1811280944520.41@tvgsbejvaqbjf.bet>
Message-ID: <327181b03df8abfd7194389c9bc21256@xs4all.nl>
X-Sender: houder@xs4all.nl
User-Agent: XS4ALL Webmail
X-CMAE-Envelope: MS4wfER2O5q1vjh4mAPOtg1mhbJj67QII7v9OyRWrsVhHASfLDfF+dwdiHIkcu/LPrJ937yb2zKRAI5uox9umDct/itdpl31iyPo0iQQP0Pcsdn8mp+ZvMu6
 XDPiW5rWpM/IdpgwDiqPfYntrKlW0uIM7Dw0toa91w0/5AK5itRFeEUbBoBz/nNM+cfpZo/SzqsM0AqVSy9k5dYDKb74dOVluCl1r/LpKwBSwp6ohvvvbeXp
 Oa3VRmg6slL+Ny16WVzQp517blnh4Io9rF5KVK4GoSM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-11-28 09:46, Johannes Schindelin wrote:
> Hi J.H.,
> 
> On Wed, 28 Nov 2018, J.H. van de Water wrote:
> 
>> > > me@work /cygdrive
>> > > $ ls
>> > > c  d
>> > >
>> > > So `/cygdrive` *is* a valid directory in Cygwin.
>> >
>> > That supports the code that does not special case a path that begins
>> > with /cygdrive/ and simply treats it as a full path and freely use
>> > relative path, I guess.  Very good point.
>> 
>> Please read
>> 
>>     https://cygwin.com/cygwin-ug-net/using.html#cygdrive
>>     ( The cygdrive path prefix )
>> 
>> .... you can access arbitary drives on your system by using the 
>> cygdrive path
>> prefix. The default value for this prefix is /cygdrive ...
>> ....
>> 
>> The cygdrive prefix is a >>> virtual directory <<< under which all 
>> drives on
>> a system are subsumed ...
>> ....
>> 
>> The cygdrive prefix may be CHANGED in the fstab file as outlined above 
>> !!!!!
>> ....
>> 
>> To simplify scripting, Cygwin also provides a /proc/cygdrive symlink, 
>> ...
>> 
>> =====
> 
> That's all very interesting, but I fail to see the relevance with 
> regards
> to the issue at hand, namely whether to special-case `/cygdrive` as a
> special prefix that cannot be treated as directory in Git.
> 
> I still maintain that it should not be special-cased, no matter whether 
> it
> is a virtual directory or whether it can be renamed to 
> `/jh-likes-cygwin`
> or whatever.

Ok. Sorry about the noise.

 From your post I got the impression that you believed that there will 
always
be a directory called /cygdrive on Cygwin.

My point: it can have a different name.

Regards,

Henri
