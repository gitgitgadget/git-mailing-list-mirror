From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unapplied patches reminder
Date: Sun, 18 Oct 2009 16:32:05 -0700
Message-ID: <7vtyxwgtxm.fsf@alter.siamese.dyndns.org>
References: <20091019052030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: "Carlos R. Mafra" <crmafra@aei.mpg.de>,
	=?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Oct 19 01:32:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzfEk-0005uX-Ox
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 01:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbZJRXcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 19:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755602AbZJRXcP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 19:32:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591AbZJRXcO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 19:32:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 593A17CC5B;
	Sun, 18 Oct 2009 19:32:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=WDL57WLo0KcDJEbIhHxhq2hn0
	k8=; b=ghWakQc/J1YNWnlaxz70hzqsxfNDrARcMWhismDuZlvwNt5pirJfPGoCA
	cE1qZipgtBXDEj2F5aMI38ZshuSxkXwSIivxiUdBlRObEGr7rhoysM0xZFt81Hw6
	9IVEwPDyMDUX45ezP7y/y24c5C3mn5Q9YO4NuMU/80entXjpzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=gPa38LD6S3zfGrJRWcz
	P39jq61jwhabiwCG1VZaQS/utqbW9BCDKcKO5wC8/wFpXHjzhMcWP2c5xK5t38MJ
	4xv2nOr47B0kWl9BIg2MsoIXLkE3jEMZ/ucMXtWmKz63DG0b3Cz+n8SpmiXrmz3s
	jHM9syLTDlLlZQ5QJIiT4laQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 15FFF7CC55;
	Sun, 18 Oct 2009 19:32:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5FE897CC44; Sun, 18 Oct 2009
 19:32:07 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7722F5CC-BC3E-11DE-90AF-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130624>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Junio, I saw these patches and thought what they try to do were=20
> sensible, but I don't them in your tree. I didn't see much discussion=
=20
> on most of them, either.
>
> Because I don't read C very well, I may have listed some patches=20
> here that you may have discarded because the code was no good, and=20
> if so I apologize for wasting your time, but I thought at least=20
> some of them should be salvaged.
> ...
> From:	"Carlos R. Mafra" <crmafra@aei.mpg.de>
> Subject: [PATCH] Makefile: clean block-sha1/ directory instead of moz=
illa-sha1/
> Date:	Sun, 11 Oct 2009 15:32:19 +0200
>
>     'make clean' should remove the object files from block-sha1/
>     instead of the non-existent mozilla-sha1/ directory.

This was lost in the noise, and it is an obviously correct patch.

Thanks for a reminder.

> From:	Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
> Subject: [PATCH] push: fix usage: --tags is incompatible with --all a=
nd --mirror
> Date:	Thu, 15 Oct 2009 18:39:05 +0200
> Message-ID: <4AD75029.1010109@gmail.com>
>
>     Correct the usage text to make it clear that --tags cannot
>     be combined with --all or --mirror.

Ditto.

> From: Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx>
> Subject: [PATCH] describe: load refnames before calling describe()
> Date: Sat, 17 Oct 2009 18:30:48 +0200
> Message-ID: <4AD9F138.3080405@lsrfire.ath.cx>
>
>     Get rid of the static variable that was used to prevent loading a=
ll
>     the refnames multiple times by moving that code out of describe()=
,
>     simply making sure it is only run once that way.

Ditto.
