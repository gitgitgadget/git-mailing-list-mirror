From: Eckhard Maass <eckhard.maass@gmx.net>
Subject: Re: -B option of git log
Date: Fri, 22 Feb 2013 11:14:36 +0100
Message-ID: <5127450C.5040908@gmx.net>
References: <5126BF50.6020500@gmx.net> <20130222005704.GA24287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 11:20:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8pjg-0001CA-1h
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 11:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703Ab3BVKTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 05:19:44 -0500
Received: from mout.gmx.net ([212.227.15.19]:62330 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754780Ab3BVKTn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 05:19:43 -0500
Received: from mailout-de.gmx.net ([10.1.76.4]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0M38kj-1UxloX0sf1-00sz0A for
 <git@vger.kernel.org>; Fri, 22 Feb 2013 11:15:02 +0100
Received: (qmail invoked by alias); 22 Feb 2013 10:14:39 -0000
Received: from fire2.tngtech.com (EHLO [10.3.2.243]) [217.110.29.210]
  by mail.gmx.net (mp004) with SMTP; 22 Feb 2013 11:14:39 +0100
X-Authenticated: #1609611
X-Provags-ID: V01U2FsdGVkX1/RAthVev/RFnn47ktQnYCL1nFZykDZiloMeigWbB
	4Qg93a/xImsBFQ
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130222005704.GA24287@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216828>

On 02/22/2013 01:57 AM, Jeff King wrote:
> I think the problem is that your test file is so tiny that it falls
> afoul of git's MINIMUM_BREAK_SIZE heuristic of 400 bytes (which prevents
> false positives on tiny files). Try replacing your "Lorem ipsum" echo
> with something like "seq 1 150", and I think you will find the result
> you are expecting.
Thanks. Two points, though:

With bigger files, I do get something like:
| M100  d
| R100  d       e

The rename is fine. But I am a bit puzzled mit the M - I, somehow,
would have expected an A for add and not a M.

Secondly, would it be a good idea to enhance the documentation on
that point to clarify this minimum size?

SEcki
