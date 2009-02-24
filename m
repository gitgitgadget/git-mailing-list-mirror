From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2] bash completion: add --format= and --oneline options for "git log"
Date: Tue, 24 Feb 2009 17:47:50 +0200
Message-ID: <878wnvbzvd.fsf@iki.fi>
References: <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
	<94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
	<7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
	<20090224130626.6117@nanako3.lavabit.com>
	<20090224045041.GA4615@coredump.intra.peff.net>
	<7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
	<20090224054524.GE4615@coredump.intra.peff.net>
	<20090224185913.6117@nanako3.lavabit.com> <871vtonlmv.fsf_-_@iki.fi>
	<87zlgcq7rq.fsf_-_@iki.fi> <20090224153913.GT22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	felipe.contreras@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:49:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzXR-0000uI-Ut
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbZBXPsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbZBXPsP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:48:15 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:41074 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755288AbZBXPsO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:48:14 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B89057941B6; Tue, 24 Feb 2009 17:48:08 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LbzVe-0001NH-0x; Tue, 24 Feb 2009 17:47:50 +0200
In-Reply-To: <20090224153913.GT22848@spearce.org> (Shawn O. Pearce's message of "Tue\, 24 Feb 2009 07\:39\:13 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111303>

On 2009-02-24 07:39 (-0800), Shawn O. Pearce wrote:

> Teemu Likonen <tlikonen@iki.fi> wrote:
>> On 2009-02-24 13:02 (+0200), Teemu Likonen wrote:
>> 
>> > I like this change and would immediately switch to using --format= and
>> > --oneline instead of --pretty=. I think we should add these bash
>> > completions too.
>> 
>> And let's add --format= completion for "git show" too. I think --oneline
>> completion is not needed with "git show" even though it works.
>
> What version of git supports "git log --format" ?
>
> 'cause I can't find evidence that it is implemented in any current
> version that Junio would apply this patch to.

This is meant to be a part of Nanako's patch series:

    http://thread.gmane.org/gmane.comp.version-control.git/111278
