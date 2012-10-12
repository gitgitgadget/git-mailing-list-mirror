From: Andrew Wong <andrew.kw.w.lists@gmail.com>
Subject: Re: build deps
Date: Thu, 11 Oct 2012 21:06:21 -0400
Message-ID: <50776D0D.9090306@gmail.com>
References: <CACnwZYe_vhH9Ui8W9D=M_8avgEugR+UvM1E+jH7fxr+8yk2UtQ@mail.gmail.com> <5072FAD1.1000807@gmail.com> <CACnwZYeJ-FKXterxd697iu+U4HobqEaP0zx_p8CZDsPZx4hbHQ@mail.gmail.com> <50735939.10604@gmail.com> <CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Andrew Wong <andrew.kw.w@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 03:06:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMTi3-0008SD-Or
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 03:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759530Ab2JLBGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 21:06:24 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:47264 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393Ab2JLBGX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 21:06:23 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so4059236iea.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 18:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vwRUhfQqxt33TK685TlzgVhm6eXda3sNAb+N3bALyFw=;
        b=Gya9cOZjdfjtAkeQrHrgR5wsNYnKYq43GFP/1p2KFKjWEpsEqScIe5B3thWdeC9Cjg
         JiT/BUl/Qlh3hmNv4/5Jxp31VMEz4CRYBFlPHCDrMYdpLS6oxJk9P8OckmjM3D473Ghj
         OxcMTuWDcDQQyWPO1bOkgLUa6yTaF99v291rm1ptU1r7UHpoS4L6RRagnJ9n80PB6u4n
         pH5IRtz2xuE7v4tyypO+phguBwu8eSzE+WQRs7W4e4Bu6a9fhm90irvSaRClaJ4BWE2P
         e9F3JYLQWhMjU4w+k9wwDe1MSih2S9SC9VVSjyH3IzQ/lmIRmmw96GkGonKyh63qn0aY
         Wj5A==
Received: by 10.50.213.99 with SMTP id nr3mr811529igc.16.1350003983337;
        Thu, 11 Oct 2012 18:06:23 -0700 (PDT)
Received: from [192.168.1.3] ([69.165.255.59])
        by mx.google.com with ESMTPS id mi10sm376947igc.16.2012.10.11.18.06.22
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Oct 2012 18:06:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20121007 Thunderbird/10.0.7
In-Reply-To: <CACnwZYf56XkqW085HoWhAN2EnjCJd=VYHGAD8fZCCe6_FNhO2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207525>

On 10/11/12 16:54, Thiago Farina wrote:
> Just setting CC to gcc works for me. But still, I'd like to be able to
> build with clang (may be as you noted is just something with the + in
> my PATH).
Oh, I just realized you were using "sudo". The PATH environment was
probably not inherited when you use sudo to run "make". So the
subsequent shells statred by "make' were not able to find "clang".
