From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: MSysGit Stability
Date: Wed, 16 Jul 2008 14:42:07 +0400
Message-ID: <20080716104207.GC2925@dpotapov.dyndns.org>
References: <73fd69b50807151458u22a383a3l343779e47f4161fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Fiorini <joe@faithfulgeek.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:43:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4Tg-0002pi-IZ
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbYGPKmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755978AbYGPKmN
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:42:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:24482 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbYGPKmN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:42:13 -0400
Received: by ug-out-1314.google.com with SMTP id h2so492104ugf.16
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=E0dhLBd0S7y1qczkXfnSUYQR7yk/CljEAiTov8/JlAo=;
        b=XMHGEA5/Ku2qiRA9767d63zfn5KoNvgD/G+LVCN8mjaA7WjanAhlhl+OZwAb4bPMeo
         wDjfLVwZBEs2mQcDY8i1QSZTPhEDOS96Z6GmCgr1i2pQWl9xtE71JN7ye9H6ZpBkLAp2
         46Xu0JAeXtJvnijL4mE1xtnPUa41Dx2dd1bRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i3JQRA4SBKQlgO5s3LTUNzOcZcj10k+Ha8vTmfxZYAKE06zB7tBgPCGBmEP58uSmTf
         lyI+y3xKTeWSGVniY9FtsHCkunkTTBuL3huWmYnBJjHFrRCc/v7+wcPojmw0aXbulODI
         39P/oQ2Rp4R4fnKu/QTdGFAxOSi6MaxRbpwpg=
Received: by 10.86.36.11 with SMTP id j11mr1860775fgj.7.1216204931345;
        Wed, 16 Jul 2008 03:42:11 -0700 (PDT)
Received: from localhost ( [85.141.237.219])
        by mx.google.com with ESMTPS id 3sm769952fge.3.2008.07.16.03.42.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 03:42:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <73fd69b50807151458u22a383a3l343779e47f4161fa@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88660>

On Tue, Jul 15, 2008 at 05:58:43PM -0400, Joe Fiorini wrote:
> I'm curious which is better to use and if MSysGit is
> even stable yet.  Does anyone have experience running Git on Windows?

Personally, I don't use it because I rarely use Windows, but I know
people who do since the beginning of this year, and in general they are
happy with it. It works faster than Cygwin version due to some Git
specific optimization put into mingw compatibility layer. So, the only
complain I heard so far is from people who got Cygwin on their computer,
and they don't like that MSysGit installs MSys, which means another set
of POSIX utilities such as bash but different version (usually more old)
and having a different HOME directory.

Dmitry
