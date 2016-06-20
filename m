Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF1B20179
	for <e@80x24.org>; Mon, 20 Jun 2016 11:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104AbcFTLyR (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 07:54:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:57503 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574AbcFTLx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 07:53:57 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LvDpe-1bN2kA2p8s-010NAU; Mon, 20 Jun 2016 13:53:48
 +0200
Date:	Mon, 20 Jun 2016 13:50:27 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/7] Let log-tree and friends respect diffopt's `file`
 field
In-Reply-To: <cover.1466420060.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1606201349060.22630@virtualbox>
References: <cover.1466244194.git.johannes.schindelin@gmx.de> <cover.1466420060.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2R1sdJG/N3HVxAABsm4xrKgwpXFciqfZ4dYHIZmZASIFp0KRKkd
 cNwHcUoMUQEW9ob7xR5p1CGdft6AWROiwqrSDCAodBu8sf/CTpJOReKgKl2sLp59Omss1Nr
 x2aTG0DuQsXroTf31f+lY8tsGV/8g88PyWFA700BTHEvD8cA9K3FjI5XqWJMOvUyJNbBgnz
 zufZPMiWtzNJJbvGF8NPA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:WrcWKFrPQFI=:GVUl4ALMZCSucHp/F/c3sW
 cbX6bBXfrtsccp/bJxPLTVXFO+QG/A/zsUsSZULnzVpX3BG87Bq6ClXv0espVs8KOB6TEtguo
 hohXp5W3abmhklplzK1+2XlIFxw8P5CAKLD9B1UrPehk/e9DlHSKvJDk79pmBDwEvgIeZeN0D
 HkEdJWP2HfZ3kjnuWOMFMosYiM6BzpGZZg9ictrLSDjESe0a5IkGEL8EALxWR2yR/WWeLjKYx
 5DEUB2TBwozZEFYFX/NqfkjET50owEoC3nQfaLXL6ilHSznNN6gfL6ayOD49wHgmHi4Ey8npi
 1liEUBEEwLF5NMg1ZE+4yKVrmLDInp4lqZEtgXJ1JyYkWFiCADCqeTGAyUcQfjr+7zUacB3bm
 3OxOI+Sm+ic3b3156S+msbt0GgQZx7knovcQgVRzB5+EAwglONA35hL9O8ZxemN/cMSQ6Ts7O
 uHtKKOnA4xuhSbSpmO7yDH6WMj9R4k/DwvA4A7hJnbd2nmjYVOJP5hpWevrYV0Fcq6RSgVfPk
 cj02HF5s2J65JuNmmhZ6ZGHDJ55jXbUYRtoQgIDYrvPhKA1zyeOAdU65u+CzelviiXVHyTAFJ
 U6Sk1M3c5ZBwV4W318ciz8OzYKJ94XinPMrjW1tCVCDBIKIeRhEjPeko3SyWnxU8FwbVxyQjw
 10JK27nzu6jI05mVWU832fiXwPdOqZScaLIEOJO7SnOgak2OeeRINTTiWJXf/ffH14j5VywfC
 HEr2cMUWeLCOH9jsqion4+lp5v03wqFUE6E5UzDcBZjxFeGBx0WPsVOTFQcoVXEFq2wXA1qBh
 /q87uFv
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

[sorry, Eric, forgot to Cc: you on the cover letter...]

On Mon, 20 Jun 2016, Johannes Schindelin wrote:

> Johannes Schindelin (7):
>   log-tree: respect diffopt's configured output file stream
>   line-log: respect diffopt's configured output file stream
>   graph: respect the diffopt.file setting
>   shortlog: support outputting to streams other than stdout
>   format-patch: explicitly switch off color when writing to files
>   format-patch: avoid freopen()
>   format-patch: use stdout directly

The interdiff is empty: all I did was to split out the first and the third
`format-patch:` commit, to leave really only the relevant part in the
"avoid freopen()" commit.

Ciao,
Dscho
