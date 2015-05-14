From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 20:20:23 +0200
Organization: gmx
Message-ID: <c2fd3e038c821ec340c085a825baabc7@www.dscho.org>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net> <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
 <20150514042544.GA9351@peff.net>
 <9350a00074264bb847210410a6f6c340@www.dscho.org>
 <20150514173828.GA7966@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 20:21:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysxkg-0007sV-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933364AbbENSUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:20:54 -0400
Received: from mout.gmx.net ([212.227.15.15]:53672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbbENSUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:20:53 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MF5FT-1Z0NKD1iln-00GJ2j; Thu, 14 May 2015 20:20:26
 +0200
In-Reply-To: <20150514173828.GA7966@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:RdkFfPyQgHZdnieXSWols/RwgCpjd0kQzyJDk4MH8ioEVxKqpVC
 0un9+ZrjkuMLEKCoADAtVYbBV1wWWsnse6ZWZD1XWAJx8AxqBSpvG/xbr4tmPbXpdIKU0qI
 oZdZhsl4CZaSfdsW05kY4frwFtpSNVe59pjhMeQ59NnBp9cqE4ewsNdyuaYLkssjGDSIpdb
 jDMTJLHHQJOizZtxCd3sA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269062>

Hi Peff,

On 2015-05-14 19:38, Jeff King wrote:
> On Thu, May 14, 2015 at 09:43:56AM +0200, Johannes Schindelin wrote:
> 
>> > Yeah, I tried what you wrote earlier in [1], but it didn't work. But I
>> > just realized it has misplaced quotes. Doing:
>> >
>> >   make ... ASCIIDOC_EXTRA="-a 'litdd=&#45;&#45;'"
>> >
>> > seems to work OK.
>>
>> Oh darn, I really meant to include this link:
>>
>> https://github.com/git-for-windows/MINGW-packages/blob/af36666c829f64847737e783c34ab20402030648/mingw-w64-git/PKGBUILD#L71
>>
>> which documents how Git for Windows defines `litdd`.
> 
> Hmm, you use the same "stuck" parameter -alitdd=..., whereas it only
> worked for me with a space between the "-a" and the attribute. I wonder
> if this is from different asciidoctor versions.
> 
> My asciidoctor just comes from the Debian package. Looks like it's over
> a year old at this point. I should probably be testing with something
> more recent.

We installed asciidoctor via `gem` and have version 1.5.2.

Ciao,
Dscho
