Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F288211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 13:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeK3Apq convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 29 Nov 2018 19:45:46 -0500
Received: from elephants.elehost.com ([216.66.27.132]:47481 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeK3Apq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 19:45:46 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id wATDeHIu019636
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 29 Nov 2018 08:40:17 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Mateusz Loskot'" <mateusz@loskot.net>, <git@vger.kernel.org>
References: <c8fc0da2-c3ff-4985-e4a2-a066a3a6f2af@peter-speer.de> <CABUeae_4yxtxFmi14+OivX-wFQq4Hd5uEV3_WhRMsMHbvSxy7w@mail.gmail.com>
In-Reply-To: <CABUeae_4yxtxFmi14+OivX-wFQq4Hd5uEV3_WhRMsMHbvSxy7w@mail.gmail.com>
Subject: RE: Git Tags
Date:   Thu, 29 Nov 2018 08:40:10 -0500
Message-ID: <001901d487e9$0f9e9d90$2edbd8b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKxaNePjIwf8mCSUHqQyM/re46S6AMpQfZDo5O12aA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 29, 2018 6:56, Mateusz Loskot wrote:
> On Thu, 29 Nov 2018 at 12:50, Stefanie Leisestreichler
> <stefanie.leisestreichler@peter-speer.de> wrote:
> >
> > git tag -a 0.9.0
> > git push origin master
> >
> > In my local repository, when I run "git tag" it is showing me "0.9.0".
> >
> > Then I did (on box B)
> > git clone ssh://user@host:/path/project.git cd project git tag
> >
> > Now git tag is showing nothing.
> >
> > Why is the tag only available in my local repository?
> 
> >From https://git-scm.com/book/en/v2/Git-Basics-Tagging
> "By default, the git push command doesn’t transfer tags to remote servers.
> You will have to explicitly push tags to a shared server after you have created
> them."

git push --tags

and

git fetch --tags

to be symmetrical

Cheers,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.

