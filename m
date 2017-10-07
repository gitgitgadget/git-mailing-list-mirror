Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76A7420372
	for <e@80x24.org>; Sat,  7 Oct 2017 00:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbdJGAEw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 6 Oct 2017 20:04:52 -0400
Received: from elephants.elehost.com ([216.66.27.132]:15193 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbdJGAEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 20:04:51 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.147.105])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v9704ZJx028673
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 Oct 2017 20:04:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>
References: <000801d33ea7$04a7c240$0df746c0$@nexbridge.com> <20171006225049.GA19555@aiede.mtv.corp.google.com> <005b01d33efb$a5668870$f0339950$@nexbridge.com> <20171006234442.GB19555@aiede.mtv.corp.google.com>
In-Reply-To: <20171006234442.GB19555@aiede.mtv.corp.google.com>
Subject: RE: [Question] Documenting platform implications on CVE to git
Date:   Fri, 6 Oct 2017 20:04:24 -0400
Message-ID: <006601d33eff$d8d8b620$8a8a2260$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ98XxaWILydfV96J0tvRHSO9e+agF+HKGKAfMiDNgCs5ThgqFQ89Rw
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On October 6, 2017 7:45 PM  Jonathan Nieder wrote: Cc: git@vger.kernel.org
>Randall S. Becker wrote:
>> The first one, mostly. When looking at CVE-2017-14867, there are 
>> places like
>> https://nvd.nist.gov/vuln/detail/CVE-2017-14867 where the issue is 
>> discussed. It provides hyperlinks to various platform discussions.
>> Unfortunately for me, I am not an HPE employee - and even if I was, 
>> there is no specific site where I can publicly discuss the 
>> vulnerability. I'm looking to the group here for advice on how to get 
>> the word out that it does not appear to apply to the HPE NonStop Git 
>> port. The question of where to best do that for any CVE pertaining to 
>> git as applicable to the NonStop Port is question #1.

>How do people find out about the HPE NonStop Git port?  Where is it distributed? 

It is available at http://ituglib.connect-community.org/apps/Ituglib/SrchOpenSrcLib.jsf but we have limited abilities to modify anything but that page. There is a brief release note but nothing sufficient to have a discussion. 

>Does that distribution point allow you to publish release notes or other documentation?

Not enough for what I think are our needs.
 
> Do you have a web page?  That's another place you can publish information. 
> http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2017-14867
> links to lots of resources that are not from the Git project.
> The oss-security list <http://www.openwall.com/lists/oss-security/>
> allows anyone to participate.  It is a place that people often collaborate to figure out the impact of a published
> vulnerability, how to mitigate it, etc.  There are other similar mailing lists elsewhere, too.

Thanks, I'll take these to the team.

>> Question #2 - probably more relevant to the specific issue and this 
>> group - is whether the vulnerability is contained to Git's use of Perl 
>> SCM and since NonStop's Perl does not support SCM, the vulnerability 
>> may not be relevant, but I'm not really enough of a Perl guru to make that determination.

>What is Perl SCM?  I don't know what you're talking about.

Base Perl does not have a lot of capability beyond a simple interpreter. The CPAN project,  https://www.cpan.org/, provides implementations of useful modules, including Source Code Management (SCM) modules that enable things like cvsserver AFAIK, and Mercurial to run. Without it (being the ability to arbitrarily add CPAN modules, which is an issue on NonStop), Perl tends to be a bit handcuffed and blindfolded. 😉

Thanks for the suggestions,
Randall

