From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git segfaults
Date: Sat, 29 Aug 2009 08:07:56 +0800
Message-ID: <be6fef0d0908281707o59fdb0c9h9a5a78864b6ad063@mail.gmail.com>
References: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302>
	 <20090817135651.GA4570@harikalardiyari>
	 <20090826202053.6e6442a6.rctay89@gmail.com>
	 <20090826131235.GF16486@harikalardiyari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ali Polatel <polatel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 02:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhBaP-0006vd-Cr
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 02:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbZH2AH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 20:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbZH2AHz
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 20:07:55 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:33538 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbZH2AHz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 20:07:55 -0400
Received: by iwn42 with SMTP id 42so1111615iwn.33
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=IAZpbPNdAYK3s6fupMH7YYdPWxG9VCUjIdxdUlQrcss=;
        b=apHSmpsAwcvCcpoaPPz4U+pI57f0RyoJqpyNHVMcSjPw4VmbSa+kcb32wA0M8ZqAqJ
         f5h3O6ylYRVvY8z0YniIyZrCinIUDUYmM+RvMm1pIR4XAruX7HqLMlYmB2+0pxkD9AlL
         YXeMnrK82kd39SBNVDiyaStvJLUqj47GBATKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mGJvfhIIu/MjssbIb0u5+gvFGbVglS7fktBJy6nOIvKsQyL3h8Do8Et2wiaxCbywEx
         P+huDhZ7d8rN6ZQIbrhgy9OtBredytTvlZFMlqXeiJNomJNl3X2skm7DBfoHDqf5Cg79
         FpLhQxWMWWLOLam0afHaHOfghilDPicovMu78=
Received: by 10.231.61.195 with SMTP id u3mr1183601ibh.12.1251504476225; Fri, 
	28 Aug 2009 17:07:56 -0700 (PDT)
In-Reply-To: <20090826131235.GF16486@harikalardiyari>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127366>

Hi,

2009/8/26 Ali Polatel <polatel@gmail.com>:
> It works, I don't get any segfaults after applying this patch.

Junio, I hope you don't mind me asking but why hasn't this patch been
accepted? It addresses a pretty severe problem, and the sooner users
have it the better.

-- 
Cheers,
Ray Chuan
