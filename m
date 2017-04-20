Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDBE207BE
	for <e@80x24.org>; Thu, 20 Apr 2017 20:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033556AbdDTUYP (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:24:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:52863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033360AbdDTUYO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:24:14 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M3RVA-1cAhy31YkS-00r4Oa; Thu, 20
 Apr 2017 22:24:07 +0200
Date:   Thu, 20 Apr 2017 22:24:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Brandon Williams <bmwill@google.com>
cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 02/11] t0061: run_command executes scripts without a
 #! line
In-Reply-To: <20170420170223.GE142567@google.com>
Message-ID: <alpine.DEB.2.20.1704202223060.3480@virtualbox>
References: <20170417220818.44917-1-bmwill@google.com> <20170418231805.61835-1-bmwill@google.com> <20170418231805.61835-3-bmwill@google.com> <12add885-b56d-4707-57c1-1073fbb7786c@kdbg.org> <9c562827-78f5-ab8f-bf04-5f403672a32d@kdbg.org> <20170419155659.GA132229@google.com>
 <alpine.DEB.2.20.1704201245420.3480@virtualbox> <20170420170223.GE142567@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HI9Lw3e7w+dzL+d77X47+r6YjKtBg0pggcYK9tsMTU6HwcvfqSR
 Y21Thdu8o4aXiykaoCZnxEM6dG59yOpt0YxxR3JqT9PVUHfw1SIGnujglKf2ahN7FcKYmqc
 PxopamYzuNDTXb2MpLCNrQxr6QjOn3LPLegA+A22ZxFfxfH1yt0gzyP02TNyMadu62IU+lG
 dMK1tHeZQHAQnHSmakwAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JtlfBV+4x/8=:2odAfpFd8bpoIb/HPygkZm
 SJB0FdTGhpPGiH6M76usMeXMGeEws0e0wAIP5GSxmVcx0uIdQHnZrOj3S7S6z+x97Ci6/0b6V
 8cHFFZuGGV/drhlzW/MJgWe0H4O52xkkAqfM256epTNtHr6+KHM5uDwbXyw2jlw7CmXKOwZ9Y
 iuAI6jkekxlhDkZ1U9CZa4sflh3jOsU+Sojs2zr5mwawWRPuaMEX95HSXQCBJaORFqXFyo3RC
 hlpdBQjRp+WYkfMOP5dH00Kgk0Pna54vkg2imvARsY+Mottc346OrxO1HqrqjeXu/jWFHRwVm
 fQqla+BvNeyuEDVTzR9mKBuaZO0zPczQAiAqJ/NWH/eich8B8R94615mpECLhb5KGchZu3C8N
 hCrKbz7ixc7PEHvx/jmyuycYFYE0vTwf1C6T/H0AzjW4+6lUJ0QmRYjP6ApNrmVAZT2PTksL/
 enwQslhWkp6fk3pZYwoseSN48+EUGs6JmdafS1JgIJ9wjj6B32/RhJAMuTSfOFbBu0czh/oTK
 QZ5fmPbeOd5CXub5Z72K79mbmFDJUDFznZAkq1TUvbZtqC7gqFtPSh6fe8/BBx17o7sSPE8OY
 v0T1xVUiy9gi+uGp1/FnbwCiQDoVmpL3YbH6B7+E9iu8yz0wQhrrltwC8+2w81nQ4xNWLLZ4E
 0SZpU1anKrlp7vfDGyfsDcr1kuL/PsEh5e0Y52K/fEdL9s3KEVDTnpJmp1PdEse6xP+kX4b4C
 s1TGb2nn159D137gye77ivSXcTKSOrkCWyDkkynt39/JQpRV/gB27TV9OtPzZ1qS9u7NnGy0f
 17AwIhG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brandon,

On Thu, 20 Apr 2017, Brandon Williams wrote:

> On 04/20, Johannes Schindelin wrote:
> > 
> > On Wed, 19 Apr 2017, Brandon Williams wrote:
> > 
> > > On 04/19, Johannes Sixt wrote:
> > > > Am 19.04.2017 um 07:43 schrieb Johannes Sixt:
> > > > >Am 19.04.2017 um 01:17 schrieb Brandon Williams:
> > > > >>Add a test to 't0061-run-command.sh' to ensure that run_command
> > > > >>can continue to execute scripts which don't include a '#!' line.
> > > > >
> > > > >Why is this necessary? I am pretty certain that our emulation
> > > > >layer on Windows can only run scripts with a shbang line.
> > > 
> > > Out of curiosity how did you have t5550 passing on windows then?
> > 
> > This is the reason:
> > 
> > 	1..0 # SKIP no web server found at '/usr/sbin/apache2'
> 
> Hmm, that's interesting.  So do any of the http tests get run on windows
> then?  I wonder if that lack of coverage could be an issue at some
> point in the future.

Possibly. I'll put it at the bottom of my TODO list ;-)

> > As predicted by Hannes, your new test fails miserably on Windows:
> 
> Isn't 'miserably' just a bit harsh ;P haha

Ah, I tried to be funny. So much for my future career as a comedian.

Ciao,
Dscho
