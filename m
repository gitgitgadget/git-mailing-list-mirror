From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/8] asciidoc fixups
Date: Thu, 14 May 2015 09:43:56 +0200
Organization: gmx
Message-ID: <9350a00074264bb847210410a6f6c340@www.dscho.org>
References: <1431451400-1447-1-git-send-email-jn.avila@free.fr>
 <xmqqfv71zlaz.fsf@gitster.dls.corp.google.com>
 <20150513021556.GA4160@peff.net> <20150513045650.GA6070@peff.net>
 <20150513224131.GC425227@vauxhall.crustytoothpaste.net>
 <20150514042544.GA9351@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 09:44:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsnoQ-0005M5-Gz
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 09:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbbENHoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 03:44:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:64691 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbbENHoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 03:44:04 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LiDKt-1ZXNXh2Cu3-00nRKj; Thu, 14 May 2015 09:43:58
 +0200
In-Reply-To: <20150514042544.GA9351@peff.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:uknZTjY/qOSKruYg9h+CFMSV/fgtQXeqeX6hJU+jvQARYnqu8ka
 ZavKEgBj6ijKVcbc3JSwmd5pMV4FJ0IysnwgCEvzBzE9rBqwQyNoIJxOBxVLiAdBkeznbob
 itbSDiOJKoYeXcJnLCvN3T39tT3WeFQvEEi1orcxqcQ2TLPsrgyxsM18LW/WwNdL3+Gt/jU
 lUk4aFrV8DvCHXrSm1anA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269027>

Hi Brian and Peff,

On 2015-05-14 06:25, Jeff King wrote:
> On Wed, May 13, 2015 at 10:41:31PM +0000, brian m. carlson wrote:
> 
>> I've been in contact with Dan Allen, the lead on the Asciidoctor
>> project.  There are a few things that he pointed out.
> 
> Thanks. I was hoping you would get involved. :)
> 
>> >   - asciidoctor does not render {litdd}, which is our invention; locally
>> >     this may be because I did not have the right incantation, but it is
>> >     also broken on git-scm.com. I think the right fix is to define that
>> >     attribute for the site renderer (so not a bug in our sources, and
>> >     not an asciidoctor bug)
>>
>> I passed this as a command-line argument when using asciidoctor to
>> generate the docs: -a litdd=--.  For the site, I would recommend just
>> defining it there, as you suggested.
> 
> Yeah, I tried what you wrote earlier in [1], but it didn't work. But I
> just realized it has misplaced quotes. Doing:
> 
>   make ... ASCIIDOC_EXTRA="-a 'litdd=&#45;&#45;'"
> 
> seems to work OK.

Oh darn, I really meant to include this link:

https://github.com/git-for-windows/MINGW-packages/blob/af36666c829f64847737e783c34ab20402030648/mingw-w64-git/PKGBUILD#L71

which documents how Git for Windows defines `litdd`.

Sorry!
Dscho
