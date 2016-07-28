Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F301F858
	for <e@80x24.org>; Thu, 28 Jul 2016 13:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824AbcG1Nqd (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 09:46:33 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53137 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751792AbcG1Nqb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2016 09:46:31 -0400
X-AuditID: 12074411-a07ff70000000932-15-579a0ca34819
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 43.F5.02354.3AC0A975; Thu, 28 Jul 2016 09:46:11 -0400 (EDT)
Received: from [192.168.69.130] (p5790682D.dip0.t-ipconnect.de [87.144.104.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u6SDk96G006772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 28 Jul 2016 09:46:10 -0400
Subject: Re: Find a topic branch containing a commit
To:	Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
References: <CACsJy8CMnywB8AdmLxB8LnsznHrMTieoezhaQS=2r1pnM8ONZA@mail.gmail.com>
 <CAGZ79kY5UrjSj8xbjB+MvTE2xUyt+te1RKN6Bf0WiEA23iZ7wg@mail.gmail.com>
 <CACsJy8CKLmjW82TJHUoqrM1smmiP=dcDqvOpN_QDPePEy0ZuJw@mail.gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <a7cd0ee3-8281-b220-1acc-c9516325ecde@alum.mit.edu>
Date:	Thu, 28 Jul 2016 15:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CKLmjW82TJHUoqrM1smmiP=dcDqvOpN_QDPePEy0ZuJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqLuFZ1a4waqbphZdV7qZLLqnvGW0
	2Ly5ncWB2WPnrLvsHgs2lXp83iQXwBzFZZOSmpNZllqkb5fAlXHn7GL2gs/cFX3dZxkbGLdw
	djFyckgImEjcuzWTqYuRi0NIYCujxI0VMxkhnPNMEstbXjKDVAkDVZ1c/oUFxBYRcJOY0beV
	HaLoHqPE6u2P2EESzAJaEpt/fgOz2QR0JRb1NDOB2LwC9hK3vy8Bi7MIqErsv/eBEcQWFQiR
	2HazgQ2iRlDi5MwnYAs4BQIlbrVeZYaYqS7xZ94lKFteYvvbOcwTGPlnIWmZhaRsFpKyBYzM
	qxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFCglRwB+OMk3KHGAU4GJV4eC2e
	zQgXYk0sK67MPcQoycGkJMobFjozXIgvKT+lMiOxOCO+qDQntfgQowQHs5IIbwn7rHAh3pTE
	yqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IEbwc3UKNgUWp6akVaZk4JQpqJ
	gxNkOA/Q8CSQGt7igsTc4sx0iPwpRkUpcd6VIAkBkERGaR5cLyyJvGIUB3pFmPckSBUPMAHB
	db8CGswENLg4dgbI4JJEhJRUA2PBnJ/tVi+9F33bzSv81sHpusWBvSVPvskwK3KkRCio3dNe
	I7k2c/WPFZv9P/7aLN7h87979/pdWutt/i25udbspfqkOne5BYzJtlb3J8kL9T58qFzCuu6X
	648KNvH1fefuL7dsEvX6wpFVM+eSW+T0aI6unKb6K0ntqVqZa4pYvR3X8Kw5ek2JpTgj0VCL
	uag4EQCEcOEW/QIAAA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 07/27/2016 08:03 PM, Duy Nguyen wrote:
> On Wed, Jul 27, 2016 at 7:50 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Wed, Jul 27, 2016 at 10:42 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> Before I start doing anything silly because I don't know it can
>>> already be done without waving my C wand like a mad man...
>>>
>>> I often do this: find a commit of interest, the commit itself is not
>>> enough so I need a full patch series to figure out what's going, so I
>>> fire up "git log --graph --oneline" and manually search that commit
>>> and trace back to the merge point, then I can "git log --patch". Is
>>> there an automatic way to accomplish that? Something like "git branch
>>> --contains" (or "git merge --contains")?
>>
>> https://github.com/mhagger/git-when-merged ?
> 
> Beautiful. If it had an option to show a topic (i.e. git-log from
> merge base to merge point) I would be ecstatic.

That's a good idea. I just created a pull request to add that feature:

    https://github.com/mhagger/git-when-merged/pull/13

Let me know what you think!

> Michael, any plans on
> bringing this in C Git? For many topic-based projects this would be
> very helpful addition, and I think it's not so hard to do it in C
> either.

I had no such plans, and I don't have time to work on that now. But I
certainly don't object if somebody else wants to work on it. It might
make a nice GSoC-sized project (though I'm not volunteering to be a
mentor at this time :-P ).

Michael

