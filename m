From: David <bouncingcats@gmail.com>
Subject: Re: git rebase --interactive using short SHA-1's internally
Date: Sat, 10 Aug 2013 10:50:25 +1000
Message-ID: <CAMPXz=rdaAZVb8UJJ+KcBZFR2wdnqTWbMKt07snPGEuCDz9q5A@mail.gmail.com>
References: <CAMebvcT7Tb1PXsKmRuSNCqOhJEbkPJAG2tzW6FjWCa6hH-+ffA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Diogo de Campos <campos@esss.com.br>
X-From: git-owner@vger.kernel.org Sat Aug 10 02:50:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7xO2-0001at-PX
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 02:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968180Ab3HJAu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 20:50:27 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:49188 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968075Ab3HJAu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 20:50:26 -0400
Received: by mail-vc0-f179.google.com with SMTP id ht10so1511100vcb.38
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 17:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ylOQGIl40DsAqHRHed4vxqlzl3U32KqxFnnWlv92R80=;
        b=k82/CXx4ye67KbqEneHN3X3cEkNJA/5Zz+SKv+NyIaI+GVsVa6LEMOsGdqTVNWaHgi
         v5K2ODPPk8u+c+zdmIatT4LEjGaFMzk2iAmdarCqTZMGo+vg7l3UY4IENqYnp76pnTn+
         l+4vD1Q1vGroGRh5DDTtTtGVT0y/cn6LSo/Ob31j7cK7c2ak/My4X2u6zFoyXU583aAA
         2pXRHDQyQSdBGUYxnmjXrFM8T4SAT0HVTjfqFZIfvxoVEKxk5t0Pdax2k0F+Hk9Vbq6Y
         SZxl393mOapa04Sn8s4Rp1lFwqa7sZdGJIFFaXqbDwpVxsYKJ78th3aQX0FuU7Us5XhC
         DD0Q==
X-Received: by 10.52.106.226 with SMTP id gx2mr5975908vdb.116.1376095825216;
 Fri, 09 Aug 2013 17:50:25 -0700 (PDT)
Received: by 10.221.42.131 with HTTP; Fri, 9 Aug 2013 17:50:25 -0700 (PDT)
In-Reply-To: <CAMebvcT7Tb1PXsKmRuSNCqOhJEbkPJAG2tzW6FjWCa6hH-+ffA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232058>

On 10 August 2013 05:22, Diogo de Campos <campos@esss.com.br> wrote:
> Had some problems rebasing a large repository, fatal error because a
> short SHA-1 ref was ambiguous.

This recent disussion might also interest you:
http://thread.gmane.org/gmane.comp.version-control.git/229091
