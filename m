From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] Added test case for stg refresh
Date: Thu, 22 Nov 2007 08:59:17 +0100
Message-ID: <871waivhgq.fsf@virtutech.se>
References: <87tznfvqb4.fsf@lysator.liu.se> <87oddnvpzf.fsf@virtutech.se>
	<20071121231553.GA19422@diana.vm.bytemark.co.uk>
	<b0943d9e0711211531v2f7b9c0bl99033c0bd58971c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 08:59:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv6yG-0006XG-8k
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 08:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbXKVH7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 02:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbXKVH7N
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 02:59:13 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:44500 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbXKVH7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 02:59:11 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 04B26200A223;
	Thu, 22 Nov 2007 08:59:10 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 11655-01-35; Thu, 22 Nov 2007 08:59:09 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 6E58D200A1EA;
	Thu, 22 Nov 2007 08:59:09 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 6E3B07B406A; Thu, 22 Nov 2007 08:59:17 +0100 (CET)
In-Reply-To: <b0943d9e0711211531v2f7b9c0bl99033c0bd58971c7@mail.gmail.com> (Catalin Marinas's message of "Wed\, 21 Nov 2007 23\:31\:45 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65748>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 21/11/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> On 2007-11-21 11:43:00 +0100, David K=C3=A5gedal wrote:
>>
>> > David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>> >
>> > > This test case fails on the kha/experimental branch. Using "stg
>> > > refresh -p <patch>" can cause all sorts of wieirdness, and there
>> > > is no test case for it.
>
> I noticed the weirdness few days ago and fixed it in
> e8813959aa3a7c41ffef61d06068b10519bd4830 (though no test caught it).
> Do you still see problems after this commit?

The problem I see is that there still is no test case. That is bad and
means that it could break again tomorrow without anyone noticing.

Luckily, I just wrote one for you :-)

--=20
David K=C3=A5gedal
