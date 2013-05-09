From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] t5004: avoid using tar for checking emptiness of
 archive
Date: Thu, 09 May 2013 21:12:39 +0200
Message-ID: <518BF527.3070609@lsrfire.ath.cx>
References: <518BA058.6050300@lsrfire.ath.cx> <518BA10B.2080003@lsrfire.ath.cx> <CAPig+cTidjz4D1vZ7Aci4YZK8ph9HJ1vMqZ1-n2hVPbLuf4AKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, BJ Hargrave <bj@bjhargrave.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 09 21:12:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaWGm-0005wG-1u
	for gcvg-git-2@plane.gmane.org; Thu, 09 May 2013 21:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab3EITMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 May 2013 15:12:44 -0400
Received: from india601.server4you.de ([85.25.151.105]:51506 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab3EITMn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 15:12:43 -0400
Received: from [192.168.2.105] (p4FFDB471.dip0.t-ipconnect.de [79.253.180.113])
	by india601.server4you.de (Postfix) with ESMTPSA id D262845E;
	Thu,  9 May 2013 21:12:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <CAPig+cTidjz4D1vZ7Aci4YZK8ph9HJ1vMqZ1-n2hVPbLuf4AKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223771>

Am 09.05.2013 20:21, schrieb Eric Sunshine:
> On Thu, May 9, 2013 at 9:13 AM, Ren=E9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>>          $ tar tf tenk.tar; echo $?
>>          tar: Cannot identify format. Searching...
>>          tar: End of archive volume 1 reached
>>          tar: Sorry, unable to determine archive format.
>
> Missing "echo $?" output.

Huh, where did that go?  It's 1.

Thanks for catching this omission.

Ren=E9
