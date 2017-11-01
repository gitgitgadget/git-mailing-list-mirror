Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B0020281
	for <e@80x24.org>; Wed,  1 Nov 2017 10:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbdKAK0F convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 1 Nov 2017 06:26:05 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:46036 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdKAK0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 06:26:03 -0400
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id vA1APpOe015888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 1 Nov 2017 06:25:51 -0400
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Eyjolfur Eyjolfsson'" <eyjolfureyjolfsson@tprg.com>,
        "'Randall S. Becker'" <rsbecker@nexbridge.com>
Cc:     "'Kevin Daudt'" <me@ikke.info>, <git@vger.kernel.org>
References: <CAO-WtQhAPjoWnWyMPi5SkCSUM_y8A=hsbLk-MUfnCSBvWnBRNQ@mail.gmail.com> <20171031212251.GB7777@alpha.vpn.ikke.info> <001801d35292$9871bd10$c9553730$@nexbridge.com> <CAO-WtQheY-cpBwEp1TGbRAT4t7Ao7qDdGdinMBb2eB6AOeuKBA@mail.gmail.com>
In-Reply-To: <CAO-WtQheY-cpBwEp1TGbRAT4t7Ao7qDdGdinMBb2eB6AOeuKBA@mail.gmail.com>
Subject: RE: Is it possible to convert a Json file to xml file with Git
Date:   Wed, 1 Nov 2017 06:25:51 -0400
Organization: PD Inc
Message-ID: <FEF91BF4585C421CB385BCF3A65EB05B@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdNS+Yg+zAzqBYL1QAmaUmX6dBS1KwAAJ+6A
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Eyjolfur Eyjolfsson
> Sent: Wednesday, November 1, 2017 6:10 AM
> To: Randall S. Becker
> Cc: Kevin Daudt; git@vger.kernel.org
> Subject: Re: Is it possible to convert a Json file to xml 
> file with Git
> 
> Hi
> 
> Thank you for your response and help. I am new to Git.

Not a problem, but what you describe is not using git but rather a shell called bash. Bash is like cmd.exe or powershell.exe, it is not GIT. See http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO.html 

> The reason for my question is that I am using Git or Bash.exe  (cURl)
> to call a REST web service (open for test) and retrieving  Json
> from the web service and storing it into file.
> This works fine from the Git Bash command line . My Git Command:

Not a git command, that is a curl command. See https://curl.haxx.se/

> $ curl https://jsonplaceholder.typicode.com/posts -o c:\temper.txt
> 
> I will look into the smudge filter.
> 

You could search for "convert json to xml in LANGUAGE" where language is one you are familiar with. E.g. http://google.com/search?q=convert+json+to+xml+Java

> One more question is there a possibility to call Git Bash with a
> parameter like example
> C:\Git\Git\git-bash.exe  curl
> https://jsonplaceholder.typicode.com/posts -o c:\temper.txt
> 
> The reason I am asking this is that I am using NAV 2009 Classic Client
> and want to lunch the Git Bash with
>  the command  $ curl 
> https://jsonplaceholder.typicode.com/posts -o c:\temper.txt

Again you are using Bash that came with a windows build of Git, just like when the Visual Studio shell gets installed. A place like https://stackoverflow.com/ may be a better resource than this mailing list about GIT.

v/r,

Jason Pyeron

PS: Please do not top post. See http://www.idallen.com/topposting.html

> 
> 
> Best regards
> 
> (e) eyjolfureyjolfsson@tprg.com
> (w) tpretailgroup.com
> 
> 
> On 31 October 2017 at 21:52, Randall S. Becker 
> <rsbecker@nexbridge.com> wrote:
> >> On October 31, 2017 5:23 PM, Kevin Daudt wrote:
> >> > On Tue, Oct 31, 2017 at 05:28:40PM +0000, Eyjolfur 
> Eyjolfsson wrote:
> >> > I have a question.
> >> > Is it possible to convert a Json file to XML with Git
> >>
> >> git is a version control system, which is mostly content 
> agnostic. It
> > knows
> >> nothing about json or xml, let alone how to convert them.
> >>
> >> You might want to use some kind of programming language to do the
> >> conversion.
<snip/>


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- 

