Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 534C21F453
	for <e@80x24.org>; Wed, 20 Feb 2019 11:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBTLLl convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 20 Feb 2019 06:11:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:45517 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfBTLLl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 06:11:41 -0500
Received: from android-574c69d4b059187a ([217.149.160.51]) by mail.gmx.com
 (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lmqxo-1hWpvX0bro-00h3Co; Wed, 20 Feb 2019 12:11:19 +0100
Date:   Wed, 20 Feb 2019 12:11:12 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
References: <20190216114938.18843-1-pclouds@gmail.com> <20190216114938.18843-2-pclouds@gmail.com> <87wolzo7a1.fsf@evledraar.gmail.com> <CACsJy8CR7VGp7htC_wKC9BUCaQsmkp5Zd4+M7bddPL-jKyfDMQ@mail.gmail.com> <xmqq8syb3b3j.fsf@gitster-ct.c.googlers.com> <87h8cy6cme.fsf@evledraar.booking.com> <CACsJy8B15hORnaOdYW8TNE3Gniv9NBJopyLYmHR5iF0U3beq6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Autocrypt: addr=drizzd@gmx.net; keydata=
 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
 ot18p18pwfiv+HM8r6TH1/NTwGg=
Subject: Re: [PATCH 1/1] Introduce "precious" file concept
To:     Duy Nguyen <pclouds@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Per Lundberg <per.lundberg@hibox.tv>,
        Steffen Jost <jost@tcs.ifi.lmu.de>,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Holger Hellmuth <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
From:   Clemens Buchacher <drizzd@gmx.net>
Message-ID: <B168DCB1-7A69-4729-89C7-B513464DD468@gmx.net>
X-Provags-ID: V03:K1:8WsDd1YiNI4uG2X3T+x77D7HWMrEUBWxCsbOUQbQJM5ZmMmKCmN
 D6xbNgQjln84G8dNxeF4yhxAXqdfn79vX4fvck05eDBgwVJgk7zzIEC6NUwVBp+1oeqv34r
 MtFRYY/qFo7Iw3grxfPNxuicZqFLMkunTA5V48eANIlJdKcjHa/pWsV2pSnAJmjF3rmm8r/
 orlJlW6Jz/NTpyR1x7lsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SVy1tlWU6/g=:eh6c2OPviuCwyGOk9LZUC6
 +6HBTcYzQUNavyPcn72KI725Tcuke7fNH3wuVpmJl7UzhZH8NzZI+WkrEvgXwheDhYyYVK7Gl
 JVPqf8mCOim3PEYJHXZxvVL6I+2Wj/gYcgHdRh4xXOwatgMoPP3Yv8qC3e43IPCEqzdt6jLKo
 9f09obzcdxLtZ5tEG+SUgvBCUhm/H9xh4fxn/tilv6T3lwHZFQ7McHXuIjAt2PhdF8UxZRvOd
 b3GuMF0yEe8AgwUlPUoqsV8kSOP+dM4LT6YfkYcXq9b29vFQi5NosYD2L257r/Zye1DM4+Fvu
 PCy13evd7U4gVILfT8OED+K7OAXaqxqNu0ioF7GiM1MlNB31Ln2YNw4JW3Nw/Cq5K2C/T65dn
 af7YdLLWWyXtAhDGawK+igxNSkU+lse244xj7+W6cNWwFk4QI5fWSxgZkUler8n1E/5F7yd0g
 PcYpUVQSHS6taSSXMbSka+SvT0wmlZPivz0SBb8InfJ7oWkndngL81cqozPowqBlVBWyDFsf7
 shN1wWFhUy4MFLvv3lKZZEg5RAaGCH3sUAIt0FbOqbHEiwyMlTqFXeaHTasISNyE4AoCw8NCD
 pKScZfsFL3lepUb3k6OBhXxg5irOAlF5YYlRYFUsz0aYvKFPffHkgxnvW64GD0Rzffl1lVCYE
 f3PzVnV5p37kR9Yy7g+tKC/+56jXyV0/IAnGcHzBG4mXG7DYyKy3i9IRmjXEeG7PsPCyIBpWI
 8J7ABeJIk00GA0NI1XgYjyrI+a7CTzEWn6SV+23ptYzfrRH9motLLvkCHMhBJfGr+B0CPpw8q
 eVqdOlCrrH0Esb/vebn3MyN7lJp6sYnVa5xsmsVSZv2Q5DD6NeN9cnCtmT+P23dQEEJQqsWeA
 mHfP/bhTn/HJHicyPfR+pnwIZljUiDo3gZj14U/+ZM4KLIpm2nV5Oioh0FRskCGoQQRuHMgg0
 ByAO372463g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On February 20, 2019 10:41:51 AM GMT+01:00, Duy Nguyen <pclouds@gmail.com> wrote:
>Making "git checkout/merge" abort while it's working before breaks
>scripts.

Change is always a trade-off. We should not reject change without considering the merits. Once we agree on the desired state, we can think about the migration strategy. 

>And requiring to mark trashable files manually duplicates a
>lot of ignore patterns. Have a look at any .gitignore file, the
>majority of them is for discardable files because "ignored" class was
>created with those in mind (*.o and friends). So now you would need to
>add more or less the same set of ignore rules in .gitattributes to
>mark them trashable, and gitignore/gitattributes rules are not exactly
>compatible, you can't just blindly copy them over. Every time you add
>one more .gitignore rule, there's a good chance you need to add a
>similar rule for trashable attribute.

I agree that ignored precious files are typically a small subset of the ignore files. Maintaining separate rules for ignored files and for trashable files would result in a lot of duplication.

On the other hand, how frequently do we really have to trash ignored files? Trashing a file should only be necessary if a tracked file overwrites an ignored file. When does this happen? I don't think it will happen for *.o files. So in most cases, there is simply no need to specify which files are precious. The default could simply be that all files are precious.

To support more complex use cases, we could specify precious files in addition to ignored files. Only if we specify precious files (and/or enable the ignored-are-trashable config option on a repository level), all other files become trashable.

Functionally this is equivalent the newbie option which you suggest, but I think it is not an issue of newbie vs experienced users but an issue of common vs special use cases.

>Maybe we just add a new "newbie" config knob and turn on the safety
>nets on. Leave the knob on by default. And I will turn it off in my
>~/.gitconfig as soon as it's real.
