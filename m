From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: Windows-native implementation for subset of 
	Pthreads API
Date: Thu, 5 Nov 2009 09:45:15 +0100
Message-ID: <16cee31f0911050045t7a7301cdm39114997edfbfa60@mail.gmail.com>
References: <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <1257350100-29281-1-git-send-email-ahaczewski@gmail.com>
	 <alpine.LFD.2.00.0911041247250.10340@xanadu.home>
	 <16cee31f0911041316n20fc9f12s6595dadc813d8f46@mail.gmail.com>
	 <4AF21283.3080407@gmail.com> <4AF214D5.6050202@gmail.com>
	 <alpine.LFD.2.00.0911042039200.10340@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 09:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5xyC-0008AA-04
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 09:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbZKEIpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 03:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbZKEIpN
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 03:45:13 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62534 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZKEIpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 03:45:12 -0500
Received: by bwz27 with SMTP id 27so9814593bwz.21
        for <git@vger.kernel.org>; Thu, 05 Nov 2009 00:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=zoebFrcmvChJvWNJAqUBn0OUhhXS4+mBfwhJ4j2XTaE=;
        b=XAT6PuUhQqC8JMaswfCMXwPt8jXwOvf08qxtsAmRtgyWETwnVaikBQLEtXU17USmUJ
         pOSbc4RCM6g1Wx7OhHH7mBROBt6KI9sHpsYr72r792sLRXfbYQk68KnFLBEdY2+jJK3V
         9wqTLEcUmxOHsQ7g00xMfLm6I9rn69f0IHqL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Nbgj+jVJbZdalSCkfrQwJ9eb5eOgsvQeSNhGAGBLc76emBMHsni4mt+vdyFt8K9T+V
         55bg0NWI1DFBGJIqhntmZrWcGpXm+x60N7fA3a6Nw3D1fVDyF/3JFcm4Riyv8D3cza+p
         5870mR8Uqh6JiADS48y9Ub7mlyy/6ceqRD8pw=
Received: by 10.239.163.205 with SMTP id q13mr280445hbd.132.1257410715512; 
	Thu, 05 Nov 2009 00:45:15 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0911042039200.10340@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132214>

2009/11/5 Nicolas Pitre <nico@fluxnic.net>:
> Please use die("CreateSemaphore() failed") in the failure case instead
> of returning success.

Sure, will do.

> However, my pthread_cond_init man page says:

And that is weird, because mine man page says:
[[[
pthread_cond_init, pthread_cond_signal, pthread_cond_broadcast, and
pthread_cond_wait never return an error code.
]]]

--
Andrzej
