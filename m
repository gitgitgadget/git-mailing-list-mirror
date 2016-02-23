From: =?UTF-8?Q?Stefan_Fr=c3=bchwirth?= <stefan.fruehwirth@uni-graz.at>
Subject: Re: whither merge-tree?
Date: Tue, 23 Feb 2016 10:49:34 +0100
Message-ID: <56CC2B2E.6070203@uni-graz.at>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
 <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
 <20160223050210.GA17767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 10:49:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY9bG-0008MF-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 10:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbcBWJtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 04:49:42 -0500
Received: from EX07HTCA01.UNI-GRAZ.AT ([143.50.13.79]:36396 "EHLO
	ex07htca01.uni-graz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbcBWJti (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 04:49:38 -0500
Received: from EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) by
 ex07htca01.pers.ad.uni-graz.at (2002:8f32:d4f::8f32:d4f) with Microsoft SMTP
 Server (TLS) id 8.3.406.0; Tue, 23 Feb 2016 10:49:35 +0100
Received: from [143.50.156.78] (143.50.156.78) by EX13MS01.pers.ad.uni-graz.at
 (2002:8f32:dbf::8f32:dbf) with Microsoft SMTP Server (TLS) id 15.0.1076.9;
 Tue, 23 Feb 2016 10:49:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160223050210.GA17767@sigill.intra.peff.net>
X-ClientProxiedBy: EX13MS04.pers.ad.uni-graz.at (2002:8f32:dc2::8f32:dc2) To
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287038>

On 23.02.2016 at 06:02 Jeff King wrote:
>> Let's wait and see how many "please don't"s we hear, perhaps, before
>> deciding to go 3.?
>
> I'm guessing we won't see much either way. Even Stefan, the original
> reporter, does not seem to actively be using it, but rather relaying a
> report.

I _am_ actively using it. Maybe I was unclear on that topic. I'm in 
favour of keeping it, because this means I don't have to rewrite Chris' 
Code in order to be able to use the Python library that uses merge-tree 
(Acidfs). But as a sensible human being I want what's best in the long 
run. I leave that up to you as I have no way of assessing that.

So that's a "please don't" leave the code as-is but provide a 
(transitional) solution that fixes the reported bug and has the best 
chances of not causing any more headaches :)

> We'd probably get more response by doing 2 for now, then adding a
> deprecation warning to the manpage (and possibly the program itself) for
> the next release.

A deprecation warning would be very welcome.

Thanks,
Stefan
