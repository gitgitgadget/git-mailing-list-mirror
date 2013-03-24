From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 3/4] drop some obsolete "x = x" compiler warning hacks
Date: Sun, 24 Mar 2013 08:17:26 +0100
Message-ID: <514EA886.3090801@web.de>
References: <20130321110338.GA18552@sigill.intra.peff.net> <20130321111028.GC18819@sigill.intra.peff.net> <20130321204709.GL29311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 08:18:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJfC0-0002WO-Q4
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 08:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab3CXHRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 03:17:44 -0400
Received: from mout.web.de ([212.227.17.12]:65168 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719Ab3CXHRo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 03:17:44 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Mf0pJ-1U4cNK1pRB-00OLvS; Sun, 24 Mar 2013 08:17:27 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130321204709.GL29311@google.com>
X-Provags-ID: V02:K0:dOfomtUola7aAcF4evjeZx4fyDDji6PbnbaQYd1QrlH
 zXHnp3UlpX8hs0mIku5y2+cpgyh/hXbdVvrvRN5IBtpx9Rhmay
 VjtcVJleluta9OGyZ2MYx/6eNWN6u70KccivY1CzV3l9YfBxOp
 2nDP0isjRwOkZhtrGq0xrf8R7RsykFnrAh1jluMxS9kAc/T00z
 +V+vefd9N6HXYByT/mpUQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218943>

On 21.03.13 21:47, Jonathan Nieder wrote:
> Jeff King wrote:
>=20
>> And 4.3 was old enough for me to say "I do not care if you can run w=
ith
>> -Wall -Werror or not", let alone 4.2.
>=20
> Changes like this can only reveal bugs (in git or optimizers) that
> were hidden before, without regressing actual runtime behavior, so fo=
r
> what it's worth I like them.
>=20
> I think perhaps we should encourage people to use
> -Wno-error=3Duninitialized, in addition to cleaning up our code where
> reasonably recent optimizers reveal it to be confusing.
>=20
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

I got 2 warnings, but reading the comments I feel that

Mac OS 10.6 and i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1 (Apple Inc. b=
uild 5666) (dot 3)

is outdated ;-)


builtin/cat-file.c: In function ~cmd_cat_file~:
builtin/cat-file.c:196: warning: ~contents~ may be used uninitialized i=
n this function
builtin/cat-file.c:196: note: ~contents~ was declared here


fast-import.c: In function =91parse_new_commit=92:
fast-import.c:2438: warning: =91oe=92 may be used uninitialized in this=
 function
fast-import.c:2438: note: =91oe=92 was declared here
