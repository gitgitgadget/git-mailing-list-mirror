From: =?UTF-8?Q?Stefan_Fr=c3=bchwirth?= <stefan.fruehwirth@uni-graz.at>
Subject: Re: [PATCH] merge_blobs: use strbuf instead of manually-sized
 mmfile_t
Date: Fri, 19 Feb 2016 13:48:01 +0100
Message-ID: <56C70F01.9060609@uni-graz.at>
References: <56C2459B.5060805@uni-graz.at>
 <20160216011258.GA11961@sigill.intra.peff.net>
 <20160216050915.GA5765@flurp.local>
 <20160216055043.GB28237@sigill.intra.peff.net>
 <xmqqmvr0mjmc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 13:48:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWkTi-0000NR-R6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 13:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376AbcBSMsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 07:48:05 -0500
Received: from EX07HTCA01.UNI-GRAZ.AT ([143.50.13.79]:25256 "EHLO
	ex07htca01.uni-graz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757175AbcBSMsE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 07:48:04 -0500
Received: from EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) by
 ex07htca01.pers.ad.uni-graz.at (2002:8f32:d4f::8f32:d4f) with Microsoft SMTP
 Server (TLS) id 8.3.406.0; Fri, 19 Feb 2016 13:48:02 +0100
Received: from [143.50.233.116] (143.50.233.116) by
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Fri, 19 Feb 2016 13:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqmvr0mjmc.fsf@gitster.mtv.corp.google.com>
X-ClientProxiedBy: EX13MS04.pers.ad.uni-graz.at (2002:8f32:dc2::8f32:dc2) To
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286712>

On 2016-02-16 at 22:27 Junio C Hamano wrote:

> Three, I know the existence of the program is not more than "we
> could do something like this" illustration by Linus, and its output
> is in no way _designed_ to be so.  We know today that it does not do

Well, then it is just really sad that the manpage doesn't say so. This 
should be corrected immediately in order to prevent someone to build 
more (e.g.) libraries on top of it.

Stefan
