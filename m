From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Diff only file at point by default
Date: Mon, 25 Aug 2008 15:21:40 +0200
Message-ID: <873aktnsbf.fsf@lysator.liu.se>
References: <87vdxtpjkd.fsf@lysator.liu.se>
	<7v3akvw7gz.fsf@gitster.siamese.dyndns.org>
	<87bpzh8msk.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 15:25:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXc1u-0000uE-SY
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 15:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbYHYNVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Aug 2008 09:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753834AbYHYNVn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 09:21:43 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:53800 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763AbYHYNVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 09:21:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 8996622D4080;
	Mon, 25 Aug 2008 15:21:41 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21843-01-26; Mon, 25 Aug 2008 15:21:41 +0200 (CEST)
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 284832013C8A;
	Mon, 25 Aug 2008 15:21:41 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id A824B7B4039; Mon, 25 Aug 2008 15:21:40 +0200 (CEST)
In-Reply-To: <87bpzh8msk.fsf@wine.dyndns.org> (Alexandre Julliard's message of "Mon\, 25 Aug 2008 11\:30\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93620>

Alexandre Julliard <julliard@winehq.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>>
>>> Use prefix (C-u) to diff all marked files instead.
>>>
>>> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
>>> ---
>>>  contrib/emacs/git.el |   13 +++++++++----
>>>  1 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> For anyone who has used pcvs (or dsvn) this makes much more sense. =
The
>>
>> Looks sensible to me; Alexandre?
>
> Looks OK to me, but I think you should apply the same treatment to al=
l
> the other diff functions. Also the documentation string needs a bit m=
ore
> work.

It's the only one I use, so I didn't think about any other diff
commands. But I'll have a look.

--=20
David K=C3=A5gedal
