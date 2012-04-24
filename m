From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Tue, 24 Apr 2012 13:04:18 -0700
Message-ID: <xmqqd36wgam5.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
	<1335184230-8870-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 22:04:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMlyK-0000LX-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 22:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab2DXUEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 16:04:20 -0400
Received: from mail-gy0-f202.google.com ([209.85.160.202]:40307 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab2DXUEU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 16:04:20 -0400
Received: by ghbz15 with SMTP id z15so124571ghb.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 13:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=5meUhO8YytkVNvA2Kvrqa1p/DQDop19JoG/Ue3dC1nM=;
        b=PiSLQyPTMECFUJQGTyxnYbne72UJPVBeOVOn0jeSSdJFGzcfl4Rftbe7q0y/JCR78G
         dt0RyjYV03P5TLj85c/d4BlGO5F4pfIxS/2J43qAiIfvpxbv64FLl/hRV+bSOeKKh4qD
         Pl6cA0r2KEdcyXXKcEqSXBl5PHNimqUtURnNT4VdYsNCSOKKGnNan2rn/Ff9L3CgRIZV
         5UOMnPJa1qQpwhvuKbFzyy8/qvFuQtH0+xq5RtzZiqiL1OeDV5DeoH9jlY7JDpPVncYn
         wH1wEbSBFaKASVIkATqgahOQBdPCPx+KMfcEmVHPUK0fT5J8m6Z1EMvTIOcmHGqudXek
         ileg==
Received: by 10.101.137.21 with SMTP id p21mr7840926ann.26.1335297859268;
        Tue, 24 Apr 2012 13:04:19 -0700 (PDT)
Received: by 10.101.137.21 with SMTP id p21mr7840901ann.26.1335297859110;
        Tue, 24 Apr 2012 13:04:19 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id a33si2891231anp.2.2012.04.24.13.04.19
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 13:04:19 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 0557A1E004D;
	Tue, 24 Apr 2012 13:04:19 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id B7043E125C; Tue, 24 Apr 2012 13:04:18 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmQ4LDHqbWvnC9Wpy3JKLhy/DSzZ5zCivbapFE2LClB+pwnineQ2DtbWoo9UUC78B1Z8KucKY4DxsmiuLGRAtV7L1aGoiowDwiNBNscPx5cPnGzJztmK/EVuU/mc4bE71INYfcFgfVxvdNQe4PYXgc7cRFs2y/z0nB662NeA8ik1Y3TeiM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196245>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> From: Jonathan Nieder <jrnieder@gmail.com>
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Looks nicely done ;-)

>  	/* Give years and months for 5 years or so */
>  	if (diff < 1825) {
> ...
>  	}
>  	/* Otherwise, just years. Centuries is probably overkill. */
> -	snprintf(timebuf, timebuf_size, "%lu years ago", (diff + 183) / 365=
);
> -	return timebuf;
> +	strbuf_addf(timebuf,
> +		 Q_("%lu year ago", "%lu years ago", (diff + 183) / 365),
> +		 (diff + 183) / 365);
>  }

This is just a tangent, but could we possibly come here and say "1 year
ago"?
