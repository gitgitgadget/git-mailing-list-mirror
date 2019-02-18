Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PI_DNOT,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48AAB1F453
	for <e@80x24.org>; Mon, 18 Feb 2019 17:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfBRR0l convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 18 Feb 2019 12:26:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:35454 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730154AbfBRR0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Feb 2019 12:26:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ACB6DACEF;
        Mon, 18 Feb 2019 17:26:39 +0000 (UTC)
Date:   Mon, 18 Feb 2019 18:26:38 +0100
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Senol Yazici'" <sypsilon@googlemail.com>, <git@vger.kernel.org>
Subject: Re: [RFE] Demilitarize Documentation (was RE: Delivery Status
 Notification (Failure))
Message-ID: <20190218182638.6a30b53b@kitsune.suse.cz>
In-Reply-To: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
References: <001601d4c7aa$460c0e70$d2242b50$@nexbridge.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Mon, 18 Feb 2019 11:51:57 -0500
"Randall S. Becker" <rsbecker@nexbridge.com> wrote:

> On February 18, 2019 11:13, I wrote:
> > To: 'Senol Yazici' <sypsilon@googlemail.com>; git@vger.kernel.org
> > Subject: RE: Delivery Status Notification (Failure)
> > 
> > On February 18, 2019 5:47, Senol Yazici  
> > > I just stumbled over following page
> > >
> > > https://git-scm.com/about/distributed
> > >
> > > and was wondering if it is possible to
> > >
> > > - demilitarise that “dictator/lieutenant” thing and
> > > - de-religionise that “blessed” thing
> > >
> > > I did not had the feeling that git is “pro military”, or is against “non  
> > religious”  
> > > developers/users.  

I have not. Using common terminology to describe a concept makes it
easier to understand.

'dictator' is not military at all. 'lieutenant' is often used in
military context but according to The Collaborative International
Dictionary of English v.0.48 the most common meaning is "An officer who
supplies the place of a superior in his absence; a representative of,
or substitute for, another in the performance of any duty."

> > 
> > I think there is a point here. In some of my customers, we have
> > replaced these terms with the following (the Repository is optional
> > in the second two):
> > 
> > * Blessed: Repository of Record

I think 'Blessed' is way easier to understand than 'Repository of
Record'. Also 'blessed' is not necessarily connected to religion. For
example, you can get your parent's blessing even when they are not
religious, whatever it's worth.

> > * Dictator: Committer [Repository]
> > * Lieutenant: Contributor [Repository]
> > 
> > This seems more closely aligned with the real roles being applied to activities
> > associated with the repositories involved.
> > 
> > Taking a lesson from other Open Source projects, Jenkins has deprecated
> > Master/Slave in favour of Controller/Agent. This seems not only more
> > acceptable to some, but in my view more descriptive. 

Of course, master/slave can have connotations with some not so nice
historical episodes.

I think that to some 'agent' might be less acceptable because it might
have connotation with some other not so nice historical episodes which
are described with some literary license in the '1984' novel.

As far as descriptivity goes both terminologies are misleading in
different ways. Only when you are aware that it has changed it makes
things actually clearer.

> The terms on the page
> > above do not actually make any descriptive sense to a newbie. And confusion
> > could ensue from the dictionary definitions:
> > 
> > * Lieutenant: an aide or representative of another in the performance of
> > duty : assistant (not what that repository is for)
I beg to differ. That's exactly what the repository is for.
> > * Dictator: one holding complete autocratic control : a person with unlimited
> > governmental power (not how the git team behaves)
If you are the sole person with the right to change the 'blessed' or
'master' repository then this describes the role quite well.

Thanks

Michal
