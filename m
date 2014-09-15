From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] git svn updates for master
Date: Mon, 15 Sep 2014 11:01:06 -0700
Message-ID: <xmqq7g149319.fsf@gitster.dls.corp.google.com>
References: <20140914082110.GA6666@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Lawrence =?utf-8?Q?Vel=C3=A1zquez?= <vq@larryv.me>,
	Andrej Manduch <amanduch@gmail.com>,
	Monard Vong <travelingsoul86@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 15 20:01:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTaaR-0007mG-CV
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 20:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbaIOSBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Sep 2014 14:01:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62716 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751229AbaIOSBK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 14:01:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48D793AC05;
	Mon, 15 Sep 2014 14:01:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5GxOf6SXWhsM
	v7eZi6UoKjH6/5M=; b=Uc0XTtJKAcf8ycGch6q+h4+ouRMuX+HhCcFdf3J3v0Uf
	3RixG+++/HuhWXDpfJaDnW55hs8DlrndGLoTvJ5Xk4PkN4g4SgFO4fF/UOfrBAq7
	4xgvS0vBEspYIPV3HdtUXKLz0BTyMA7xdBxcJVnb8Rs4NkcxbgxSewNo90i9MGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OLM8jn
	ZCjoiXqpZiNc6X2IhB6FCp97ogTe52stliBCCRDRkthCahqhxAZpwraLY4cyhYE5
	tSdRusRBERRhvQ6ryQ0A/+RGb4sMWsnzGenftbGJxABCGxz8jaY4Lx1qpI2AT8CF
	F3zlNtSvgYLtlhmmp7dwee8dJjUmEcWebf22o=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E93743AC04;
	Mon, 15 Sep 2014 14:01:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 431693AC01;
	Mon, 15 Sep 2014 14:01:08 -0400 (EDT)
In-Reply-To: <20140914082110.GA6666@dcvr.yhbt.net> (Eric Wong's message of
	"Sun, 14 Sep 2014 08:21:10 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44E27584-3D02-11E4-88BF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257060>

Eric Wong <normalperson@yhbt.net> writes:

> Hi Junio, a couple of small changes and fixes.  Most of these should =
be
> suitable for maint, too.

Thanks.  As you said "Most", not "All", I'll pull it to 'master' for
the next release but not for the maintenance track.



>
> The following changes since commit ce1d3a93a6405b8a0313491df3099919ed=
3d150f:
>
>   Update draft release notes to 2.2 (2014-09-11 11:19:47 -0700)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git master
>
> for you to fetch changes up to 30d45f798d1a4b14759cd977b68be4476d66ea=
17:
>
>   git-svn: delay term initialization (2014-09-14 08:08:54 +0000)
>
> ----------------------------------------------------------------
> Eric Wong (3):
>       git svn: info: correctly handle absolute path args
>       git svn: find-rev allows short switches for near matches
>       git-svn: delay term initialization
>
> Lawrence Vel=C3=A1zquez (1):
>       git-svn.txt: Remove mentions of repack options
>
> Monard Vong (1):
>       git-svn: branch: avoid systematic prompt for cert/pass
>
>  Documentation/git-svn.txt | 17 ++-----------
>  git-svn.perl              | 65 +++++++++++++++++++++++++++++++++++--=
----------
>  t/t9119-git-svn-info.sh   | 30 ++++++++++++++++++++++
>  3 files changed, 81 insertions(+), 31 deletions(-)
