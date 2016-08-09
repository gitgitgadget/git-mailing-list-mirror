Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F7D1FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 10:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbcHIKTU (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 06:19:20 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51511 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751591AbcHIKTT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2016 06:19:19 -0400
X-AuditID: 1207440e-dafff70000000931-ea-57a9ae195a77
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D2.67.02353.91EA9A75; Tue,  9 Aug 2016 06:19:05 -0400 (EDT)
Received: from [192.168.69.130] (p5B10434B.dip0.t-ipconnect.de [91.16.67.75])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u79AJ051016420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 9 Aug 2016 06:19:01 -0400
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Duy Nguyen <pclouds@gmail.com>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de>
 <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <CACsJy8DeSv_ALHR+HrViEptgYCYhXu2ZczMmhzZfHGAwZumnzg@mail.gmail.com>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <111a9cbe-a174-b8c0-23e5-f7f08635aa6e@alum.mit.edu>
Date:	Tue, 9 Aug 2016 12:19:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DeSv_ALHR+HrViEptgYCYhXu2ZczMmhzZfHGAwZumnzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsUixO6iqCu5bmW4QeMsK4sZy/6xWHRd6Way
	aOi9wmzxZO5dZosVV+cwW/Qv72Kz+L8g3+LxwyWsFt1T3jJa/GjpYbbonCpr8emEm8Xmze0s
	FmfeNDI68Hns+HyB1ePZy8lMHjtn3WX3+PAxzmPBplKP5UvXMXrcem3r8fBVF7vHs949jB4X
	Lyl7LH7g5fF5k1wATxSXTUpqTmZZapG+XQJXxv5d65kK1nNUHG7YzdbA+Juti5GDQ0LAROLg
	5NguRi4OIYGtjBLHPnczQjhnmCQaex6DFQkL5Epcf5PaxcjJISKgJPGmYxszRE0jm8TmJ/vY
	QRxmgbMsErv+LWYEqWIT0JVY1NPMBGLzCthLfPp1HsxmEVCR+HJ3LTOILSoQIrHtZgMbRI2g
	xMmZT1hAbE6BQIlj2+6C1TMLqEv8mXeJGcKWl9j+dg7zBEb+WUhaZiEpm4WkbAEj8ypGucSc
	0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2MkOji28HYvl7mEKMAB6MSD++F5SvChVgT
	y4orcw8xSnIwKYnyTl69MlyILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/bSqAcb0piZVVqUT5M
	SpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoODQ+DKwSOzGaVY8vLzUpUkeGPXAA0RLEpNT61I
	y8wpQShl4uAEWcQDtGg9SA1vcUFibnFmOkT+FKOilDjvNZDrBEASGaV5cL2wpPiKURzoLWHe
	PSDtPMCECtf9CmgwE9DgJNUVIINLEhFSUg2M3bKSX3TOLT77ONu66+fD3vQ1C0XbPq59EtCW
	YbhDfZnIPod9h2u5Zm55n/ox0Svf5UygxJXXSkHbbm45GjohPVdhXkb5gY/cAhsSDa1FXwia
	tF3689o0RturpDi8dZOs8WsdPsuIVTN6VibELvBTEo6I2i3T16Mtwzz5m05Jeun0G+9jp5kp
	sRRnJBpqMRcVJwIACMd6hGUDAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/09/2016 06:22 AM, Duy Nguyen wrote:
> On Tue, Aug 9, 2016 at 12:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> On 08/04/2016 05:58 PM, Johannes Schindelin wrote:
>>> [...]
>>> Even requiring every contributor to register with GitHub would be too much
>>> of a limitation, I would wager.
>>> [...]
>>
>> Is it *really* so insane to consider moving collaboration on the Git
>> project to GitHub or some other similar platform?
> 
> In the very unlikely event that github is shut down, how do we get all
> review comments out of it, assuming that we will use pull requests for
> review?

I don't have any experience with these tools, but a quick search turns
up the following possibilities (among others):

* github-backup (by Joey Hess): https://github.com/joeyh/github-backup
* python-github-backup: https://github.com/josegonzalez/python-github-backup
* BackHub (commercial service): https://backhub.co/
* Import GitHub project into GitLab:
http://docs.gitlab.com/ce/workflow/importing/import_projects_from_github.html

Michael

