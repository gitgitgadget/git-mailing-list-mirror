Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D844B20372
	for <e@80x24.org>; Fri,  6 Oct 2017 23:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbdJFXee (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 19:34:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:39826 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbdJFXed (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 19:34:33 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.147.105])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v96NYVI9028006
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 6 Oct 2017 19:34:31 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>
References: <000801d33ea7$04a7c240$0df746c0$@nexbridge.com> <20171006225049.GA19555@aiede.mtv.corp.google.com>
In-Reply-To: <20171006225049.GA19555@aiede.mtv.corp.google.com>
Subject: RE: [Question] Documenting platform implications on CVE to git
Date:   Fri, 6 Oct 2017 19:34:19 -0400
Message-ID: <005b01d33efb$a5668870$f0339950$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ98XxaWILydfV96J0tvRHSO9e+agF+HKGKoXYhIPA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----Original Message-----
On October 6, 2017 6:51 PM, Jonathan Nieder wrote
>Randall S. Becker wrote:
>> I wonder whether there is some mechanism for providing official 
>> responses from platform ports relating to security CVE reports, like
CVE-2017-14867.

>This question is too abstract for me.  Can you say more concretely what you
are trying to do?
>E.g. are you asking how you would communicate to users of your port that
CVE-2017-14867
?does not apply to them?  Or are you asking where to start a conversation
about
>who a bug applies to?  Or something else?

The first one, mostly. When looking at CVE-2017-14867, there are places like
https://nvd.nist.gov/vuln/detail/CVE-2017-14867 where the issue is
discussed. It provides hyperlinks to various platform discussions.
Unfortunately for me, I am not an HPE employee - and even if I was, there is
no specific site where I can publicly discuss the vulnerability. I'm looking
to the group here for advice on how to get the word out that it does not
appear to apply to the HPE NonStop Git port. The question of where to best
do that for any CVE pertaining to git as applicable to the NonStop Port is
question #1.

Question #2 - probably more relevant to the specific issue and this group -
is whether the vulnerability is contained to Git's use of Perl SCM and since
NonStop's Perl does not support SCM, the vulnerability may not be relevant,
but I'm not really enough of a Perl guru to make that determination.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000) 
-- In my real life, I talk too much.



