From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/3] nd/multiple-work-trees updates
Date: Fri, 13 Feb 2015 12:51:07 +1300
Message-ID: <54DD3C6B.7050408@web.de>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com> <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Mark Levedahl <mlevedahl@gmail.com>,
	Max Kirillov <max@max630.net>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 00:51:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM3XX-0006DK-9Z
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 00:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbbBLXvS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2015 18:51:18 -0500
Received: from mout.web.de ([212.227.17.11]:61966 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbbBLXvS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 18:51:18 -0500
Received: from [192.168.1.64] ([122.61.97.93]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0MNtTz-1YFi0p3bZb-007Xt2; Fri, 13 Feb 2015 00:51:13
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:x3uLXKHSehFHWopm7BbXL4FE1xWGCQo1dS0awIyG82WclY96TkK
 svKUAslyJzWDrniKnOygaxpQyaoKS0/BmBt1CvNtV+mTQrZrDDtUIO2ULDOGNvgY/AsBkZ3
 002TF2jrdYGXwLCkxR7wCI7dtyN3CPNjjuTsEv/RO1Qv53U/Ta8B8XjsMY37MiNmqFzQHWr
 Nc4thC2f73OCSSFUF/Uyw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263791>

Am 13.02.2015 um 11:57 schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> These patches are on top of what's in 'pu'. They add
>> --ignore-other-worktrees and make a note about current submodule
>> support status. I don't think submodule support is ready yet even
>> with Max Kirillov's series [1]. His 03/03 is already fixed in 'pu'
>> though, so only 01/03 and 02/03 are new.
>>
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/261107
>
> With the understanding (perhaps a strongly-worded paragraph in the
> release notes) that this is not suitable for submodule users yet,
> is this in a good enough shape to go to 'next'?

No objections from my side (and maybe we should also add a warning
that *all* worktree-related configuration - e.g. EOL options - are
currently always shared between all worktrees).

Adding submodule support can then be done in another series (and
renaming core.worktree to something else is definitely *not* the
way to do that! ;-).
