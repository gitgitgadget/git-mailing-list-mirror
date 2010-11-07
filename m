From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: import determinism
Date: Sun, 07 Nov 2010 23:45:55 +0100
Message-ID: <m2d3qgu50c.fsf@igel.home>
References: <20101107202535.GA18766@nibiru.local>
	<AANLkTi=mx0AAKo2Asn5XJVcs30-PLuwhTbM=o0y36Wa_@mail.gmail.com>
	<m2lj54u9uj.fsf@igel.home>
	<AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	weigelt@metux.de, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 07 23:46:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFDzu-0004sK-SS
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 23:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0KGWp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 17:45:57 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:38251 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0KGWp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 17:45:56 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 78FCB1C0022A;
	Sun,  7 Nov 2010 23:45:55 +0100 (CET)
Received: from igel.home (ppp-88-217-124-121.dynamic.mnet-online.de [88.217.124.121])
	by mail.mnet-online.de (Postfix) with ESMTP id 6BA7B1C001BA;
	Sun,  7 Nov 2010 23:45:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 31A00CA2A0; Sun,  7 Nov 2010 23:45:55 +0100 (CET)
X-Yow: I'm having fun HITCHHIKING to CINCINNATI or FAR ROCKAWAY!!
In-Reply-To: <AANLkTikXxM=CfU2dKAY9khi1_tAsGDdUEc8S5AxooGH9@mail.gmail.com>
	(Martin Langhoff's message of "Sun, 7 Nov 2010 17:20:17 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160905>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On Sun, Nov 7, 2010 at 4:01 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
>> The committer info in every commit will be the same as the author info,
>> so the repository conversion is completely deterministic.
>
> For cvsimport, it is not deterministic. Given cvs'
> ambiguous/buggy/inconsistent internal semantics around some
> operations, cvsps makes educated guesses about what happened.
>
> Later commits can affect those educated guesses.

The OP was assuming an unchanging repository.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
