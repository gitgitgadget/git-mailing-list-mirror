From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test: skip test with COLUMNS=1 under mksh
Date: Fri, 27 Apr 2012 09:21:13 -0700
Message-ID: <xmqqaa1x9mdi.fsf@junio.mtv.corp.google.com>
References: <20120426223422.GC22261@camk.edu.pl>
	<1335518725-19728-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kacper Kornet <draenog@pld-linux.org>, git@vger.kernel.org,
	Lucian Poston <lucian.poston@gmail.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Apr 27 18:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNnvN-0003HO-Rt
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 18:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760606Ab2D0QVS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Apr 2012 12:21:18 -0400
Received: from mail-bk0-f74.google.com ([209.85.214.74]:58232 "EHLO
	mail-bk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760557Ab2D0QVR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2012 12:21:17 -0400
Received: by bkwj5 with SMTP id j5so46833bkw.1
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 09:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=4nLQ+xi7EcSHXqX+m9PMbiDtX72Wp8+tUhRjcPLLJ80=;
        b=k1NkvWVrI4x/0u8gspW2YRYUMJNsrLpGu/cBfIshOB/EIMYlJaK4VU5wk4ynQd2Vf+
         8eVo1p/xrMcFP7aq8FImr1rZ5U6+/li2DvqMvn1UIyJyhYrRqHlke3k8PgRGl3/1olvi
         3HYnfVJlNMfxAsGO4yT5jjGIJAaXS6k+vchpfA0ZVEdhP3N41SXMpanZhxwCvZDO7m0T
         Iff7t9OC9wTl18gx4NC1v0dgwMeqmRUe+sTzT8+gyWu05tUr2r9MkoGRR7B7NdGotAzW
         zCdTcBb+BeYxH6neMj3iVuA38lk7JqXYl3K+YkeEXyed6aGbID75bACLQJMacdaHkQMm
         JYvQ==
Received: by 10.213.16.83 with SMTP id n19mr179160eba.6.1335543674682;
        Fri, 27 Apr 2012 09:21:14 -0700 (PDT)
Received: by 10.213.16.83 with SMTP id n19mr179140eba.6.1335543674488;
        Fri, 27 Apr 2012 09:21:14 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si6649937eef.1.2012.04.27.09.21.14
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 27 Apr 2012 09:21:14 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id 4C4F45C0858;
	Fri, 27 Apr 2012 09:21:14 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 9C9F1E125C; Fri, 27 Apr 2012 09:21:13 -0700 (PDT)
In-Reply-To: <1335518725-19728-1-git-send-email-zbyszek@in.waw.pl>
 ("Zbigniew
	=?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 27 Apr 2012
 11:25:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQnyBkh6AujhQNJtlNbCi1B+J9OK502H09P93R/zTDtYACpkOuT8IZrf8vhZxSA+CY/oxyxwPqVIO86TkUHb4m0hK124/j5UkDJNX4L3xaVPwq0cyuRsEs1UijXqDtWqjg+2aZSVqY3utyBgehR8FEBl+KygFgdUPKVlgGcYCW0BD+HrnWk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196479>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> mksh does not allow $COLUMNS to be set below 12. Quoting mksh(1)
> $COLUMNS is "always set, defaults to 80, unless the value as reported
> by stty(1) is non-zero and sane enough". This applies also to setting
> it directly for one command:
>
> $ COLUMNS=3D30 python -c 'import os; print os.environ["COLUMNS"]'
> 30
> $ COLUMNS=3D20 python -c 'import os; print os.environ["COLUMNS"]'
> 20
> $ COLUMNS=3D10 python -c 'import os; print os.environ["COLUMNS"]'
> 98

I wonder if this is an easier workaround, though.

	env COLUMNS=3D10 $cmd

In any case, I'd split this patch to three, as these tests belong to tw=
o
independent topics.
