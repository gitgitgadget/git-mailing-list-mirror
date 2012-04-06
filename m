From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Sat, 7 Apr 2012 00:21:35 +0300
Message-ID: <CAMP44s0n+dyp-QNOPtiKtGX1VNOsM8GJOLLCksqwPArR+FS8ng@mail.gmail.com>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
	<20120406201926.GA1677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 23:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGGbF-0005S5-W5
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 23:21:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab2DFVVh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 17:21:37 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:63596 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab2DFVVg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 17:21:36 -0400
Received: by wgbds11 with SMTP id ds11so825914wgb.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=cDzGRu15HGbJjL0q04LvdfB4YO+FyBxxvoqTB0Q9CCA=;
        b=0BIWzFU3IcQ2Cin1x3WvaoOZ/pPDL73m2Mr794gC0hKm6zv91TigobaAfXAGjcajWP
         G0AoalXBkC6fi3GGTUO6CqQzaMCXvNj1i/NcTe6B+V33LgmIs0da/xq6TNIrKXJVSL4K
         OaWAHYz1MQ7QPOMYaBuhs87hTHuKH/c0RoQ6ZwEKPX4VwdS9jfc6P85OP2jM6G2hxioo
         3Fuuj+7+mBtxFi1SeY0QM1DjzjgMdzdp0tMnEiDphqxQa2L1NTGLwHbM3gxb8goHFVG8
         6q3kQoY0jb293LwOhysdWRvmRbnuTTjtDU2dGuhm7+YEjoPbeQTcjQoui+wy2gQ91Ann
         LBnw==
Received: by 10.180.107.132 with SMTP id hc4mr14099090wib.21.1333747295730;
 Fri, 06 Apr 2012 14:21:35 -0700 (PDT)
Received: by 10.216.70.4 with HTTP; Fri, 6 Apr 2012 14:21:35 -0700 (PDT)
In-Reply-To: <20120406201926.GA1677@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194908>

On Fri, Apr 6, 2012 at 11:19 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 06, 2012 at 10:28:39PM +0300, Felipe Contreras wrote:

> I think you need to start with something like:
>
> =C2=A0#!/bin/sh

That is irrelevant, even if it's '#!/bin/foobar', it wouldn't make any
difference since the actual command would be something like
'$(SHELL_PATH) t9902-completion.sh'. Plus /bin/sh does not always
point to bash, even when bash is available (see debian).

--=20
=46elipe Contreras
