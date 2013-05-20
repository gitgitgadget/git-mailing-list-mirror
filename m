From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/6] t5000: factor out check_tar
Date: Mon, 20 May 2013 22:22:56 +0200
Message-ID: <519A8620.4070602@lsrfire.ath.cx>
References: <1369043909-59207-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1369043909-59207-4-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAPig+cSPV08=LcQ4vziE5+HmN3LtBVp7F4mb83--Mub_e2A7qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 20 22:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeWbv-0006Ad-Ed
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 22:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757967Ab3ETUXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 May 2013 16:23:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:56520 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756961Ab3ETUXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 16:23:04 -0400
Received: from [192.168.2.105] (p4FFDBA8C.dip0.t-ipconnect.de [79.253.186.140])
	by india601.server4you.de (Postfix) with ESMTPSA id D5237FD;
	Mon, 20 May 2013 22:23:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAPig+cSPV08=LcQ4vziE5+HmN3LtBVp7F4mb83--Mub_e2A7qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224980>

Am 20.05.2013 21:54, schrieb Eric Sunshine:
> On Mon, May 20, 2013 at 5:58 AM, Ren=E9 Scharfe
> <rene.scharfe@lsrfire.ath.cx> wrote:
>> +check_tar() {
>> +       tarfile=3D$1.tar
>> +       listfile=3D$1.lst
>> +       dir=3D$1
>> +       dir_with_prefix=3D$dir/$2
>> +
>> +       test_expect_success ' extract tar archive' '
>
> s/' extract/'extract/

It might be a bit hackish, but I added that single space here and in th=
e=20
three other cases intentionally in order to designate sub-tests.

Ren=E9
