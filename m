Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B8A5201C8
	for <e@80x24.org>; Wed, 15 Nov 2017 17:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbdKORNF (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 12:13:05 -0500
Received: from mout.web.de ([212.227.15.3]:52727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933218AbdKORNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 12:13:00 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlWRb-1eo4kP1ZOp-00bGjx; Wed, 15
 Nov 2017 18:12:58 +0100
Date:   Wed, 15 Nov 2017 18:12:58 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ashish Negi <ashishnegi33@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Changing encoding of a file : What should happen to CRLF in file
 ?
Message-ID: <20171115171258.GA12963@tor.lan>
References: <CAJ_+vJ6FXXda4fe7=1YxtDGR2d8CqP4KXN+YR6+mdQ+5jQQXug@mail.gmail.com>
 <8b3225ce-a4aa-56ee-5296-6cc7528556d1@web.de>
 <CAJ_+vJ5J250CtzVg4QwEusddviDSYuJhubsbTJyv5Nc2conAfA@mail.gmail.com>
 <CAJ_+vJ7Yfcpz5252M4XJnDmEDCANp+eJ7RLJJF8TCcTxexZEUA@mail.gmail.com>
 <f9dc6482-587d-50a9-d649-aed63be18fad@web.de>
 <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ_+vJ6SxLOmZfG79Sa-vskBR-XG=C97--PB-vpijjUKym=jYw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:Ue/z0dToIBnxQlSJt14IoIrxKoPDglugomA6CPxDudmXRABUliy
 da7Pgb8rr/9PqEI60xKin8BojpiLHH134MXNJNA4eU3Rz9mNwH0pvzD7iZE9A5YhEpPJ18N
 bexWHSLVXydtiPcDdmZhEMB2fnutkrR2Zky4iYw3ruhy08M8ymixibWSoVnSUEnaVFzhROF
 JSrO7qD9mVvYIaW7Kkhaw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vHBeB36QgjI=:a7Mbj/AaNZayWb9rBPeqSG
 t6ky+z7qEJyF4URVD++SQTVvN/5seVKcyN7BWTJU8weh2oQJb1zyyw1Im7kVhOPzAyQcIlrB/
 qD3XdKOKZvrdVzPtmA47Gm9+cPaZfPA26b49TUkJVh1fwOAbGfRTEv8MSKo+N7fOMh4r1MYD2
 8k/pTpxNI29/RHxgeZque6yAFjENSRdaxAWnbeGEjEVp9KBi/6W/KCodld2SDg0iHyf0LaRHX
 p9ryGSq1Owsr8juQOkq1xQ+DDBbfQ2BPjPz3lwUPbfXW9aj6NIp1/jq3KRi6YOV9Pxovr64TZ
 83h9BEeskDNfEszmarLTMoBCBGFxS4CKf2uXnj9WLo028foHcRmqWCnZuueBXrXYJVWBXc2px
 Jo48TvqnX5WMS0l5r33m59oM+mKPXyyC4MEQLGu8r52YgK8KpGET6J9Qst0hrdZ38qwR2X/AH
 f6U0ud59t0qCkSI88rUQJubaLS+z7Rb68Ug805LJum78YbfNopZHmq3KJ9KnKqHbgI6TaHp/9
 EtLbxYm/btazFAOo3kp17qjk7J184+F4KYzKgfOLizaOLYrsTIAGl7RO/MlUH7G8smyNl9BCn
 YuPNONrB5EVhhk9QSwtcITStWmCPP+qu+njBXUOScmwiDbMAJkyKAswICp7pfKhAttxjcyn++
 4rY/HpQosEdCLL+TozhK2XaWoY3PjbNyK9R+J+GbXUcmcCQ8E204wL6c4VEBWDnPlRkBXoUBr
 Uab1lMn/buU5p1NGWgIFoNgSl5jHAsYaE0rraRHQcW8GeFfoTqVnabNAHNLO9Tsiq7SXtIFL5
 mqxqZ81O9LB3p4Yd54SXeU/avK2DA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 01:41:42PM +0530, Ashish Negi wrote:
> > If you commit the file, it will be stored with LF in the index,
> This is what i believe is not happening.
> 
> Lets do this with a public repository and steps which are reproducible.
> I have created a repo : https://github.com/ashishnegi/git_encoding
> 
> If you clone this repo in linux and run `git status`, you will find
> that file is modified.

This is what what I get:

 git ls-files --eol
i/lf    w/lf    attr/text=auto          .gitattributes
i/crlf  w/crlf  attr/text=auto          file_name.txt

(And you get the same, I think)
Newer versions of Git (>=2.10) will -not- treat file_name.txt as changed,
older versions do.
What does "git --version" say on your Linux machine ?

However, if you want to fix it, you want to either end up with

A)
git ls-files --eol
i/lf    w/lf    attr/text=auto          .gitattributes
i/lf    w/crlf  attr/text=auto          file_name.txt

or
B)
git ls-files --eol
i/lf    w/lf    attr/text=auto          .gitattributes
i/crlf  w/crlf  attr/-text              file_name.txt

(The "attr/-text" means "don't change the line endings")

Both A) or B) will work, typically A) is preferred.

You should be able to achive A) :
 git rm --cached file_name.txt  && git add file_name.txt 
rm 'file_name.txt'
warning: CRLF will be replaced by LF in file_name.txt.
The file will have its original line endings in your working directory.

git ls-files --eol
i/lf    w/lf    attr/text=auto          .gitattributes
i/lf    w/crlf  attr/text=auto          file_name.txt

[snip the rest]
