Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ACDD1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 19:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeCWTfZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 15:35:25 -0400
Received: from mail.netzguerilla.net ([217.11.57.120]:33041 "EHLO
        mail.netzguerilla.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbeCWTfY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 15:35:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.netzguerilla.net (Postfix) with ESMTP id 2BC0D100013;
        Fri, 23 Mar 2018 20:35:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netzguerilla.net
Received: from mail.netzguerilla.net ([IPv6:2a00:1828:2000:612::25])
        by localhost (sal.netzguerilla.net [IPv6:::1]) (amavisd-new, port 10024)
        with ESMTP id daQVpqOCiH7x; Fri, 23 Mar 2018 20:35:21 +0100 (CET)
Received: from [IPv6:2003:dd:ff23:7e01:24c6:2a95:3528:d2ee] (p200300DDFF237E0124C62A953528D2EE.dip0.t-ipconnect.de [IPv6:2003:dd:ff23:7e01:24c6:2a95:3528:d2ee])
        by mail.netzguerilla.net (Postfix) with ESMTPSA id 81947100012;
        Fri, 23 Mar 2018 20:35:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=projektwerkstatt.de;
        s=fckp; t=1521833721;
        bh=95It+32JOuziBnJSrQRavlaGaQ7GXkZzqj+aZ1EinnU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RribXmz/kipE//5IVMv2OeUHChr2Lp8vOkJQ68BO71Kj4gv3x6sbNKZ1hCNCzPT3e
         4KZ+2k8c7P3PPONTQCYYH69eD6G9yQ1evu0bl4+jAP3xNQw7zgJ5gkEoFRUC9StHTF
         F1GQjFYDYIBGD7Ad/TcPTusdFBRfPelT30tt2TMFlfMoToqXvkg8n6M03bjQ8ztt3F
         jsO3Lu940dGjUw6ZSVQTlKT90ByWBOTiTRpd8s8lkVp4AAkVDPuICvcShiK7UY5huY
         5pZSh0JgsEZuuSrUV6F4FnSwS9Cm1xoSbdrUFqPLblcQUXV49s7+/GhEn4I6MRQRsQ
         wd8toGCr1UB1w==
Subject: Re: user-manual: patch proposals and questions
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
References: <3166da20-14f8-50bf-3913-03b18673203d@projektwerkstatt.de>
 <16afd6f7-110f-18c0-f7f4-9cadf0b69db9@projektwerkstatt.de>
 <CAPig+cTxgnUUrdCD3fUeM=90mLNhOTHOwtL=_Gd6AH8owiyV7A@mail.gmail.com>
From:   kalle <kalle@projektwerkstatt.de>
Message-ID: <35be0ad1-17d0-fe63-498d-04b75e31790f@projektwerkstatt.de>
Date:   Fri, 23 Mar 2018 20:35:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTxgnUUrdCD3fUeM=90mLNhOTHOwtL=_Gd6AH8owiyV7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

thank you for your answer and hints.
kalle

Am 19.03.2018 um 01:27 schrieb Eric Sunshine:
> On Sun, Mar 18, 2018 at 7:49 PM, kalle <kalle@projektwerkstatt.de> wrote:
>> 1.I wonder, why the "user-manual" is so hidden on the (official?) site
>> git-scm.com [it is accessible at git-scm.com/docs/user-manual ,but is
>> not viewable in /docs ]
> 
> The git-scm.com website is maintained as a distinct project[1] at
> Github; it is not directly related to the Git project itself. A good
> way to voice your concern about the website is either to open an issue
> ticket[2] or submit a pull request[3] if you have a specific change in
> mind.
> 
> [1]: https://github.com/git/git-scm.com
> [2]: https://github.com/git/git-scm.com/issues
> [3]: https://github.com/git/git-scm.com/pulls
> 
>> 2.I did not receive an answer to my mail. Maybe it could have to do with
>> a possible stopped maintainment of the 'user-manual'
> 
> More likely it was because your email was not composed in a way for
> people to digest and respond to it easily. There are some things you
> can do to help make it easier for people to respond:
> 
> * Send patches inline rather than attachments since it is much easier
> for people to respond to them directly when inline. When they are
> attachments, people are forced to open the attachment, then copy/paste
> parts of the patch back into the email for response, and most people
> won't bother with such effort. Also, make each patch a separate email
> with a meaningful commit message ("git format-patch" and "git
> send-email" can help with this).
> 
> * For your questions about documentation, quote the section of
> documentation you want to talk about directly in your email, then ask
> a question about it. This saves people the effort of manually having
> to open the file and locate the line or paragraph in question. Also,
> line numbers change as changes are made to files, so the line number
> you cite might not match the line number in a version of the file
> someone else is looking at.
> 
>> 3.it would be for non-graphics-users to have the Git-Pro-book in
>> text-format.
> 
> Like the website, the Pro Git book is a distinct project[4], not
> directly related to the Git project. To suggest making the book
> available as plain text, you can open an issue ticket[5] or submit a
> pull request[6] if you implement it yourself.
> 
> [4]: https://github.com/progit/progit2
> [5]: https://github.com/progit/progit2/issues
> [6]: https://github.com/progit/progit2/pulls
> 
> 
>> -------- Weitergeleitete Nachricht --------
>> Betreff: user-manual: patch proposals and questions
>> Datum: Tue, 6 Mar 2018 00:08:55 +0100
>> Von: kalle <kalle@projektwerkstatt.de>
>> An: git@vger.kernel.org
>>
>> The patches are attached.
>> Further some questions:
>>
>> -see the explanations of the branch command, ca. line 280: wouldn't it
>> be better to use other words than 'references'?
>> -sentence "it shows all commits reachable from the parent commit": it
>> seems wrong to me. The last commit is also shown.
>> - chapter "Browsing revisions": it seems counterintuitive to me to have
>> two different logics for the meaning of "branch1..branch2" and
>> "branch1...branch2", according to whether it's the argument of `git log'
>> or `git diff'
>> -section "Check whether two branches point at the same history": 'git
>> diff origin..master' -> shouldn't it be rather 'git diff
>> branch1..branch2'? … or rewrite the example with branch1=origin and
>> branch2=master.
>>
>> greetings,
>> kalle
