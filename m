From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/5 v2] Worktree/Gitdir at root directory
Date: Fri, 12 Feb 2010 17:00:14 +0100
Message-ID: <4B757B0E.4010402@kdbg.org>
References: <1265899403-15904-1-git-send-email-pclouds@gmail.com> <4B752BA1.9080105@kdbg.org> <4B755229.6000502@jonny.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:00:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfxwT-00005H-US
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988Ab0BLQAY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 11:00:24 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:44489 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756869Ab0BLQAY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 11:00:24 -0500
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E9705CDF8C;
	Fri, 12 Feb 2010 17:00:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B755229.6000502@jonny.eng.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139716>

Jo=C3=A3o Carlos Mendes Lu=C3=ADs schrieb:
> Johannes Sixt wrote:
>> I don't see any regressions in may tests on Windows, but I actually=20
>> don't know what to test (the chroot test doesn't work on Windows). I=
=20
>> did test on the root of a partition
>>
>>    T:\> git init
>>    T:\> cd foo
>>    T:\foo> git add bar
>>
>> and it works as expected.
>=20
> Beware: My first proposed patch "worked" at this level, but failed=20
> completely when I wanted to commit.   Try more operations just to be =
sure.

I tried commit, fetch, checkout, and they work as expected.

-- Hannes
