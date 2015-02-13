From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 0/3] nd/multiple-work-trees updates
Date: Thu, 12 Feb 2015 22:17:14 -0500
Message-ID: <54DD6CBA.5030501@gmail.com>
References: <1420278087-14613-1-git-send-email-pclouds@gmail.com> <xmqqlhk2pwle.fsf@gitster.dls.corp.google.com> <54DD3C6B.7050408@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Max Kirillov <max@max630.net>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 04:17:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM6ks-0003dD-8Y
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 04:17:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbbBMDRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2015 22:17:18 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:63625 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbbBMDRR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 22:17:17 -0500
Received: by mail-qc0-f173.google.com with SMTP id w7so12002622qcr.4
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 19:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8vZidb0yifH++rR1r7SVr7AKnNNK3Def2m8aYFUCTJ8=;
        b=Oq5bP4bcG2zsTUvdBXH71r5jyWR77i/3n9T/bfvL9mt1zStDnMHQC8nnXbucM/8jZi
         dd/DHp2Gn2/lS41NsCYtKjhMNfYBxKvHbQDXMYTKDE+EqVBJzurSq0kqpytGr4kSE7wJ
         Q/UWR7KWu5Ndczxyogd5sxZZB7lyfVc8mk0TnxtWzquw1cjZCtjcuUo4HmGjFfesL/+X
         +lwPTXIXSEKXs2rwt2+x0ie+ligXkBmb0BbgihX6nwWhgw/R/aNxecR7QX99Qcc4bSvM
         j/R3tcg/ezKORci1KyHxAQbJU3OcRhQ1kNsRc8CObOhDX5tG0q0yXufame/LUsvqbAdn
         VyOw==
X-Received: by 10.140.192.15 with SMTP id n15mr1298941qha.28.1423797437126;
        Thu, 12 Feb 2015 19:17:17 -0800 (PST)
Received: from marklaptop.lan (pool-108-28-8-37.washdc.fios.verizon.net. [108.28.8.37])
        by mx.google.com with ESMTPSA id u20sm4117405qah.12.2015.02.12.19.17.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Feb 2015 19:17:15 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <54DD3C6B.7050408@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263795>

On 02/12/2015 06:51 PM, Jens Lehmann wrote:
> Am 13.02.2015 um 11:57 schrieb Junio C Hamano:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> These patches are on top of what's in 'pu'. They add
>>> --ignore-other-worktrees and make a note about current submodule
>>> support status. I don't think submodule support is ready yet even
>>> with Max Kirillov's series [1]. His 03/03 is already fixed in 'pu'
>>> though, so only 01/03 and 02/03 are new.
>>>
>>> [1] http://thread.gmane.org/gmane.comp.version-control.git/261107
>>
>> With the understanding (perhaps a strongly-worded paragraph in the
>> release notes) that this is not suitable for submodule users yet,
>> is this in a good enough shape to go to 'next'?
>
> No objections from my side (and maybe we should also add a warning
> that *all* worktree-related configuration - e.g. EOL options - are
> currently always shared between all worktrees).
>
> Adding submodule support can then be done in another series (and
> renaming core.worktree to something else is definitely *not* the
> way to do that! ;-).
>
I concur the patch series is good enough for next. Better multiple=20
worktree support for submodules is, I think, a sizeable topic that will=
=20
take a while to settle, so should be worked after this base is integrat=
ed.

Mark
