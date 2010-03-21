From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: native-git-svn: A Summer of Code 2010 proposal
Date: Sun, 21 Mar 2010 12:58:20 -0500
Message-ID: <20100321175820.GA26174@progeny.tock>
References: <32541b131003191132y119037f8rae598d0037786703@mail.gmail.com>
 <fabb9a1e1003191139v6ea37df3uba441f2cba9bc992@mail.gmail.com>
 <32541b131003191430ld0eaa9cw1d2aac08cff15682@mail.gmail.com>
 <alpine.DEB.1.00.1003201148230.7596@pacific.mpi-cbg.de>
 <f3271551003201334o4919cd47s44d06288b0d6068b@mail.gmail.com>
 <20100320210406.GA29899@progeny.tock>
 <alpine.DEB.1.00.1003211125290.7596@pacific.mpi-cbg.de>
 <20100321110807.GA24016@progeny.tock>
 <alpine.DEB.1.00.1003211236050.7596@pacific.mpi-cbg.de>
 <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Avery Pennarun <apenwarr@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 18:57:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtPOr-00068e-SB
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636Ab0CUR5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:57:17 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:36022 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab0CUR5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 13:57:16 -0400
Received: by yxe12 with SMTP id 12so1422364yxe.33
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 10:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=46Md9g09kHUiH5XA1y2+G9SHUlNeBkKfBp6NSOHpdmI=;
        b=ED6r6XBfBFREGFiZK7BqNFAXuJTo9oIPEESoXDSYjClIbyokMmOx+7v5O6A3Wo+O3O
         uT4abChLToOsWI7GJUztSa6R0MB4AWRKdfEr2mhh5xLkvem2icV087muNFeEBuX+3uuu
         cF1jfzIkTsSVOebpnJd6FHPXbz6NxdRCAjKbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e/pEGKudo2cHmv/cRhuqaa+EnvT6LIAWFPugcpvVWjiJGRE0b2OL2f/tNFC55gp0Of
         zEgh9vMD6jVgTYEHKSENXLMDKnW/OVON1wBqee52J67YlCqJWyqR6SPkgYyUaYqc6TxK
         4jfu9fORSYX7LDKXTP6jvxbgZGkThC/gv7/iE=
Received: by 10.151.89.31 with SMTP id r31mr4709577ybl.57.1269194235610;
        Sun, 21 Mar 2010 10:57:15 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm2819947iwn.15.2010.03.21.10.57.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 10:57:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f3271551003210525l761cf36eh69cdfddf4e645ef3@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142847>

Ramkumar Ramachandra wrote:

> Thanks for the elaborate explanation. The way I see it, there are two
> extreme situations I must avoid. The first is being opaque for the
> risk of not being able to integrate it into git.git at the end of the
> summer term. The other extreme is worrying so much about the
> integration of each little bit that the project keeps getting
> detracted, and eventually loses focus. To strike a balance, I will
> post progress reports to the mailing list (atleast) once a week, and
> keep a public development branch for myself. Occasionally, it might
> help to post patches for small components of the project with
> unittests to get a wider test audience.

Sounds great to me, too.  It seems you understand the issues well.

Cheers,
Jonathan
