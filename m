From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Wed, 13 May 2015 09:43:54 +0200
Organization: gmx
Message-ID: <b7b8419e6210f7d3eeb748dc31809d86@www.dscho.org>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net> <20150513045650.GA6070@peff.net>
 <xmqqzj59aw4c.fsf@gitster.dls.corp.google.com>
 <20150513053706.GA7783@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 09:44:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsRKs-0004QK-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 09:44:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbbEMHoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 03:44:07 -0400
Received: from mout.gmx.net ([212.227.15.18]:65141 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686AbbEMHoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 03:44:05 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MdKDb-1Ya5XD2sxn-00IU8F; Wed, 13 May 2015 09:43:56
 +0200
In-Reply-To: <20150513053706.GA7783@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:TkU0Tz/nnI6a/ODIO1cBPspmKATlcmb+OlwG04yv6qS8xm/XmTN
 /Bj7+y26VtnbZspjJHI+k3fBdyjEP0La3SGx4voBzxLhYLYOpX2PDm2wjEnqKJAQ3Mo9YEy
 /KofXORPbJkaM8rN6YKXSoedwkV4xraph47mPkTGEWxE4f0SIL2rlGyonhZOr4QX8x2gE6T
 Z1VK+24+2w9fegzDRF7Dg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268944>

Hi,

On 2015-05-13 07:37, Jeff King wrote:
> On Tue, May 12, 2015 at 10:23:47PM -0700, Junio C Hamano wrote:
> 
>> Jeff King <peff@peff.net> writes:
>>
>> > Here are the patches. They do not include the code-fence fixes from
>> > Jean-Noel and myself that were already posted, but could easily go on
>> > top.
>>
>> Thanks. Will queue.
>>
>> Why are you guys using AsciiDoctor again?  Speed over accuracy is an
>> acceptable answer, as I know how slow my documentation codechain is.
> 
> I'm not sure who "you guys" is.

I would like to believe that I am included in said group, because we recently switched to use AsciiDoctor in Git for Windows 2.x. In msysGit times, we could not even run AsciiDoc (and neither AsciiDoctor), instead we relied on Junio publishing the artifacts in the git-htmldocs repository.

The difference of speed is noticable, although it has to be pointed out that compiling the documentation still takes roughly 5x (!!!) as long as compiling Git's source code itself.

By the way, we have two patches in our fork that are needed here to use Asciidoctor successfully: https://github.com/git-for-windows/git/compare/893292c41%5E...893292c41%5E2

I would like to put them on top of this patch series. Objections?

Ciao,
Dscho
