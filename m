From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Added test case for stg refresh
Date: Wed, 21 Nov 2007 23:31:45 +0000
Message-ID: <b0943d9e0711211531v2f7b9c0bl99033c0bd58971c7@mail.gmail.com>
References: <87tznfvqb4.fsf@lysator.liu.se> <87oddnvpzf.fsf@virtutech.se>
	 <20071121231553.GA19422@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <david@virtutech.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 00:32:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuz38-0001P9-2n
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 00:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbXKUXbr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 18:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbXKUXbr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 18:31:47 -0500
Received: from nz-out-0506.google.com ([64.233.162.238]:33256 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbXKUXbq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 18:31:46 -0500
Received: by nz-out-0506.google.com with SMTP id s18so2087998nze
        for <git@vger.kernel.org>; Wed, 21 Nov 2007 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=c6vsgc1nUyFzrFU+BgAvJD1MVpne49of3/FV13wVtgs=;
        b=rzAy/EzM4t2cmUEuvYruUryNaJ22gBNJpWDWLapHNpzRyoydcFRAX3Brd/9Yg41HXEYUVzlYjS46tq4EuJAbjqj8/LBC8VuOemYo9nu/94ogCfsqg7RDGXXllNlclX7sql3DCzTCAHpf3TraaHoGjf/UVKQvOtUNenr+A0pYrVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m6vQVqB9JBlaLYUm8z76aMLSQCC9mtT7g0/roB+32CSi42oHjoVSr5n8ClwqjeFu9sPdgRGXoniOAOnIOTNEabnZawQuNXt9rYk8ZSpuaofv6lZFHfYAam0CvZLEepZuKLNu7nB2GvC35stcIwwkwrM0V1buRTR1e3AY9X0+LDU=
Received: by 10.143.6.1 with SMTP id j1mr789014wfi.1195687905221;
        Wed, 21 Nov 2007 15:31:45 -0800 (PST)
Received: by 10.142.230.10 with HTTP; Wed, 21 Nov 2007 15:31:45 -0800 (PST)
In-Reply-To: <20071121231553.GA19422@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65713>

On 21/11/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-11-21 11:43:00 +0100, David K=E5gedal wrote:
>
> > David K=E5gedal <davidk@lysator.liu.se> writes:
> >
> > > This test case fails on the kha/experimental branch. Using "stg
> > > refresh -p <patch>" can cause all sorts of wieirdness, and there
> > > is no test case for it.

I noticed the weirdness few days ago and fixed it in
e8813959aa3a7c41ffef61d06068b10519bd4830 (though no test caught it).
Do you still see problems after this commit?

--=20
Catalin
