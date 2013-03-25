From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Mon, 25 Mar 2013 16:53:04 +0100
Message-ID: <515072E0.4030103@web.de>
References: <201303231340.29687.tboegi@web.de> <CAPig+cR0HdQq4P=MWg7xkFLMzNimitty_Bj7mVx+w3eoi9bZ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, j6t@kdbg.org,
	Git List <git@vger.kernel.org>, ramsay@ramsay1.demon.co.uk
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 16:53:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK9iM-0005fI-Jx
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 16:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604Ab3CYPxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 11:53:09 -0400
Received: from mout.web.de ([212.227.15.3]:63332 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758602Ab3CYPxI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 11:53:08 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MejSy-1U0HNZ14ki-00OIuS; Mon, 25 Mar 2013 16:53:05
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CAPig+cR0HdQq4P=MWg7xkFLMzNimitty_Bj7mVx+w3eoi9bZ3g@mail.gmail.com>
X-Provags-ID: V02:K0:fm+M97sp7KsAqQtg5Gy/hUTDt04IVy3sZWOI7GgPe8U
 h9J0s2CtwLlue+eIgR5nLV9412/4onPlm+rA1b1ekD612n2uDT
 Pq644pLkDZnpeRxEz9v0IOLOvWwF8xRNARy0OtgDI2BFdNHRyX
 B6XiCvJnbkzD2crdmYPrEOj8pB8k694PzFIO/OBtePcjaY2gAc
 Q6NHoTYyS8M2CMuohllSw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219036>

On 24.03.13 03:49, Eric Sunshine wrote:
> On Sat, Mar 23, 2013 at 8:40 AM, Torsten B=F6gershausen <tboegi@web.d=
e> wrote:
>> Subject: [PATCH] Make core.sharedRepository work under cygwin 1.7
[..]
>=20
> s/failes/fails/
>=20
Thanks for review,
I will send a new patch in a minute.

It is actually 2 patches,
- The fix as discussed here
- A small refactoring of set_shared_perm() in path.c,
  which I found while digging in the code.
