From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Fri, 25 Jul 2008 06:23:47 +0700
Message-ID: <fcaeb9bf0807241623m3fbd476dyc41990d8ef0888e6@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <loom.20080724T065737-580@post.gmane.org>
	 <fcaeb9bf0807240200x10a6a267h4c37e4566da967ba@mail.gmail.com>
	 <loom.20080724T171151-310@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "James Pickens" <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 01:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAB1-0000Vt-2H
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbYGXXXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbYGXXXu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:23:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:3791 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519AbYGXXXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:23:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1529880fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 16:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/HMuQJufHRUPMDNkOuPxhIfVOUIY5JTvuq04ShPy7QI=;
        b=nWTRdccA8Vfn9fvWY+pz1/WjQB0RdnuHu6lcpngy9SKuRsxGDrPQAjWaga/Ife6+6i
         tDaCupRtZVnXruaYtZ6EDgP93aIfphfsEEiJq4ItcxzYg1NlVPcpPXxsIouDz+ZBnh45
         60aPC9GtWStpD3BH0gg2yHbHyHSqFB2TbXm9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pEiqiLfccJUm83YjqBMEhnScL9ByMU9bOAP2D0TspIUReAwgWCi2dP8hk4yEEfvG3u
         dIW3GE3L8/EessNQX3zeR/FZEpSqhXCM0pPhSyxnKSdzWePXlFwTXHb47MJ3iwDqZeMp
         M3yvS79kacPuBU/mC9QbfHUnB/hoFooM1e9IM=
Received: by 10.86.1.1 with SMTP id 1mr1344394fga.61.1216941827597;
        Thu, 24 Jul 2008 16:23:47 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 16:23:47 -0700 (PDT)
In-Reply-To: <loom.20080724T171151-310@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89971>

On 7/25/08, James Pickens <jepicken@gmail.com> wrote:
> > You can do that with "git checkout --path" (non-recursive checkout aside):
>  >
>  > $ git checkout --path=A                     # checkout full A
>  > $ git checkout --path=A/B1/C1               # no, limit to A/B1/C1 only
>  > $ git checkout --path=A/B1/C1:A/B2          # extend to A/B2 too
>
>
> My point was not that incremental checkout is impossible, just that it
>  would be easier if I didn't have to re-type the full path list again.
>  Suppose I had 9 directories (A/B1 through A/B9) in my sparse checkout,
>  and I wanted to add a 10th directory (A/B10).  It would be much easier
>  to type something like
>
>  $ cd A
>  $ git checkout B10
>
>  instead of
>
>  $ git checkout --path=A/B1:A/B2:A/B3:A/B4:A/B5:A/B6:A/B7:A/B8:A/B9:A/B10

"git checkout B10" form has already been taken. How about "git
checkout --add-path" and "git checkout --remove-path"?
-- 
Duy
