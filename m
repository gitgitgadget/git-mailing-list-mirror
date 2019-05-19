Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1230A1F461
	for <e@80x24.org>; Sun, 19 May 2019 00:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfESAJh (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 20:09:37 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:22749 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbfESAJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 20:09:37 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id S9OPhKYCFgI7iS9OPh7gRo; Sun, 19 May 2019 01:09:34 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=XcCI3kNqQuHEl8agLOMA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Missing branches after clone
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        Git Mailing List <git@vger.kernel.org>
References: <5CDA8D37020000A100031319@gwsmtp.uni-regensburg.de>
 <CACsJy8AX9Wp3W=d1=ozF9nZXGE1muooMf7fKCtdOOi1g8QRmig@mail.gmail.com>
 <0c9ec78a-9245-e1df-7ec6-a5d77d1a5261@iee.org>
 <CACsJy8D9wDiTOfKP4sdMFQrR66qa4cLZuqqn32yH83_q0XjKRg@mail.gmail.com>
 <aeb83b28-3db1-f37c-6cb0-6be5622da114@iee.org>
 <CACsJy8Cc+cj0kC5=N+6AGB2UGDWA3uK946vgdhg9Cpx9a7w2wg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <033ba463-dddd-d5b8-903c-9729190c213a@iee.org>
Date:   Sun, 19 May 2019 01:09:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Cc+cj0kC5=N+6AGB2UGDWA3uK946vgdhg9Cpx9a7w2wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGNhsQ42Gb0m42aDu8mSI2hELgeY5t9evsEkQRzj+lOkw1H3PSvmWxl2JWjMjql/MXWVIj7v4PTwcYBBcAZMva8pmJRMM1hKmxer2oRqKObZB9GGXxvF
 vEwhDi/bnQnmjQnn9S7USAYATEhSevLuEtGnY2K/Y8EAxJUZz3+z/pOeJ57yQcpb1JsAuyx7oUrjIjZG5miglqkQj4Pu5XgENOIyN2iXd3wuc4MKLnAKqH62
 xL2Va20y0qbCdyc6DmUB7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/05/2019 13:17, Duy Nguyen wrote:
> On Tue, May 14, 2019 at 6:10 PM Philip Oakley <philipoakley@iee.org> wrote:
>>>> It is a 'branch which tracks a remote', and it is has the 'last time I
>>>> looked' state of the branch that is on the remote server, which may
>>>> have, by now, advanced or changed.
>>>>
>>>> So you need to have the three distinct views in your head of 'My branch,
>>>> held locally', 'my copy of Their branch, from when I last looked', and
>>>> 'Their branch, on a remote server, in a state I haven't seen recently'.
>>> What I was looking for is this. I don't think we have something like
>>> this in the man pages (I only checked a few though) and not even sure
>>> where it should be if it should be added to the man pages, git-branch?
>>> git-remote? git-fetch? git-branch.txt might be the best place because
>>> this is still about branches.
>>>
>> At the moment its in `git help glossary`, but could be improved, and
>> references to it given in the various man pages.
> It does not look easy to link to a specific term/section between man
> pages. The way user-manual.html does it is to embed the whole
> glossary.
>
> I suppose we could still do something similar after breaking down
> glossary.txt (like we do with config.txt) the only include relevant
> terms. Not sure if this a really good idea to pursue.
Mainly I was commenting on the fact that the description is in a guide 
(which isn't well known).
And that we rarely give links to the guides.
For those that end up using the HTML man pages, having hyperlinks to the 
particular section would be useful, though I'm not sure if their is a 
neat way of doing that which is 'nice' for those using the 'man' viewer.
So yes, it's more of a back burner issue, unless some eager tech authors 
suddenly show up;-)
--
Philip
