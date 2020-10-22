Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99998C388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFFB24630
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 14:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504396AbgJVOzl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 22 Oct 2020 10:55:41 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24681 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503652AbgJVOzk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 10:55:40 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.189.82] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 09MEtb05008706
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Oct 2020 10:55:38 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Adrien Berchet'" <adrien.berchet@gmail.com>,
        <git@vger.kernel.org>
References: <CAKuTeyftpz8mQiiy2S56pxmW0fzCENAQ8=gmaTE5a-Ef5g216g@mail.gmail.com>
In-Reply-To: <CAKuTeyftpz8mQiiy2S56pxmW0fzCENAQ8=gmaTE5a-Ef5g216g@mail.gmail.com>
Subject: RE: [bug] Cloning SSH repo into /tmp
Date:   Thu, 22 Oct 2020 10:55:31 -0400
Message-ID: <000601d6a883$66d8e180$348aa480$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMqDjtu6hmKiRxIwMY8YurVYTJEqab86bgQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 22, 2020 6:28 AM, Adrien Berchet wrote:
> I encountered a quite weird bug when I tried to clone a repository into the
> /tmp folder (I just wanted to test something, so I was working in /tmp).
> 
> I run the following command in /tmp :
>     git clone ssh://[user]@[host]/project/[project_name]
> and I got the following error:
>     fatal: the protocol '/tmp/ssh' is not supported
> 
> I got the same result if a run the following command from /tmp directory:
>     git clone ssh://[user]@[host]/project/[project_name] /tmp/project_name
> 
> Nevertheless, the command works in other directories. Even the second
> command works when run from another directory (this command: git clone
> ssh://[user]@[host]/project/[project_name] /tmp/project_name).
> 
> It is very specific and can easily be worked around so it is no big deal but I
> preferred reporting this in case it hides something else.

What platform are you running on? I have experienced similar when /tmp is linked to a separate file system with complex ACLs.

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



