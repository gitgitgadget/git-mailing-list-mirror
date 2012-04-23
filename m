From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/10] i18n relative dates, help, remote, apply,
 index-pack and bundle
Date: Mon, 23 Apr 2012 11:41:18 -0500
Message-ID: <20120423164118.GG4832@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:41:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMMKT-0006jz-0T
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275Ab2DWQl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Apr 2012 12:41:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57273 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754266Ab2DWQl1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 12:41:27 -0400
Received: by yenl12 with SMTP id l12so6259114yen.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iFkiBvv0nJC920mvyGXO9k7rsu+vWgJCjfnMDpbC2g0=;
        b=t3MS46tBvmPdvNdEEhKm4wAlmfdf46DoACMD3IqMWJUXFRYPb9JB9fD88HF33JcCyQ
         sH/mLtxJFMks2TlAsdbNYY2NQm7d4AE3XkVVhYNqVFvS3Z2B+KZ/o9wtaKJkgUL283Wh
         1TLwmSERN6TJ/ooWZXtC05nXC5NM3f/PWhclksAEzDNiXhCDsWf2l6hWyjdPgneOwGF9
         B9DRe/ESD2dpOE+ZyH7PbriV7zbbLoeKQE3XTY8vU8/JjqeFVW6Vldzs4Lr0IHbkCqBj
         TTPjFmph1YoyFg9I3hvsecG92s+WiqEVtL8odZ/KBhPhxSigW2zMSTtZsBqx71ADvsXG
         ivEg==
Received: by 10.50.219.194 with SMTP id pq2mr7268257igc.18.1335199286347;
        Mon, 23 Apr 2012 09:41:26 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id em4sm11870969igc.16.2012.04.23.09.41.22
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 09:41:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196145>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Compared to v1 [1], parseopt patch is taken out. I attempted to
> convert all struct option, and it turned into a huge series [2]. Not
> sure how to submit that series yet.

With the exception of the two nits mentioned, looks good.  I haven't
tested yet with GETTEXT_POISON=3DYes, though.  Thanks for your
perseverance.

Jonathan
