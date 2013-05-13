From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt
 string
Date: Mon, 13 May 2013 13:11:43 +0200
Message-ID: <20130513111143.GU2331@goldbirke>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
 <1368289513-8700-2-git-send-email-artagnon@gmail.com>
 <7v61ynsci8.fsf@alter.siamese.dyndns.org>
 <CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com>
 <20130513091718.GA21636@goldbirke>
 <CALkWK0m+mG39W7RqU-9KfPWLnaey5pL+jvfdZg49ixsASE+QoQ@mail.gmail.com>
 <20130513110551.GT2331@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 13:12:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbqgH-0005ee-PU
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 13:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab3EMLMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 07:12:34 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:57991 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417Ab3EMLMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 07:12:33 -0400
Received: from localhost6.localdomain6 (goldbirke.fzi.de [141.21.50.31])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Mb5Ch-1UwOSC3u6F-00K6J6; Mon, 13 May 2013 13:11:43 +0200
Content-Disposition: inline
In-Reply-To: <20130513110551.GT2331@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:4/uxmWlsy8lnGyoT0E94msNmWYoVgaE2OQQvIKsEchy
 AtW9v4xgzi8+KRx597qPYmLwgVOisIcrV8A9RBCI3DHRe/uFkj
 d4sqAOZNdSXg/0wNTu11yjPAKgIgs8rjYQwzOX9drbbLjkHunI
 yV35cCL036ooKLio/3be17IgyvLDADf3ci0qXYQ4BqddQyCcVj
 ekzuA1T0snNTII6GsUrp3vtS5UTooy6rZ/1NYr+rN0c5Gfxsay
 kG2InkFT4wHDsfls8nhXWI5qA8e/wZZ6sQNn8/MYp7XDoA57QB
 sdnrgNusrSFaUKPf0DCpgpa2YPgvGBR1lyT5+bZ7D0lkBDt+6c
 5NVHB1s3tpAVx4uzmuLs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224120>

On Mon, May 13, 2013 at 01:05:51PM +0200, SZEDER G=E1bor wrote:
> On Mon, May 13, 2013 at 03:43:43PM +0530, Ramkumar Ramachandra wrote:
> > If we can agree that it's just a matter of taste, we should both be
> > able to have what we want.  Any suggestions on how to make this
> > configurable?
>=20
> The same way we make other things configurable in the prompt: specify
> the GIT_PS1_HIDESTATESEPARATOR or something similar variable to strip
> that space from the prompt.

Or perhaps better yet: use a variable, e.g. GIT_PS1_STATESEPARATOR or
whatever, to specify what should separate the branch name from the
repo state, defaulting to a space to keep the current behavior.


G=E1bor
