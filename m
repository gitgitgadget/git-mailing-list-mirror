From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fread does not return negative on error
Date: Wed, 24 Jun 2009 23:19:54 +0200
Message-ID: <81b0412b0906241419q3bdef822laf9a879ce790d8f@mail.gmail.com>
References: <4A3FB09D.9050903@gmail.com> <20090622153431.GA18466@elte.hu>
	 <25e057c00906220847t15425f38maf486c291d1d2468@mail.gmail.com>
	 <4A3FB479.2090902@lsrfire.ath.cx>
	 <7vhby64i8f.fsf@alter.siamese.dyndns.org>
	 <20090624081819.GA10436@elte.hu>
	 <alpine.DEB.1.00.0906241201040.4773@pacific.mpi-cbg.de>
	 <7vws71wquf.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0906241835240.7946@intel-tinevez-2-302>
	 <20090624175940.GC7576@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	roel kluin <roel.kluin@gmail.com>, git@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jun 24 23:20:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJZtP-00022d-8l
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 23:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702AbZFXVT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 17:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757425AbZFXVTz
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 17:19:55 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:65058 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbZFXVTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 17:19:54 -0400
Received: by fxm9 with SMTP id 9so1058331fxm.37
        for <multiple recipients>; Wed, 24 Jun 2009 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i+A2/sgHR2vDxdOk5xdbmg/TBCHOg2eyqZy53yR1SEA=;
        b=aNJZbvVMDpAoXiy15NZzCL3qwmgNzElvkXFFPPNqlCefrrrjBHiSpXdL/zhvbo6hYj
         B3cXFmhScM2sKPFrqEu4QShiD16ad2Ovp6Qf9mr+9qWZt0BuqiUTz6t848XezMC/1VRz
         xIKpzqVON8RovHq6+k0LPU+ywy4MXu0ckxhPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m6dGDJQpjTF8uDk8ViI89Av4LEUuVbUpk1uu8ok0lYAdVOzq0soUEaBZRzICSsY3PW
         E8Rc5dDTW2R/jTTWQG5A4QMt0v6IDzD3EGOqQvhaJ4DHsi0wcu+GZlDELppBCgDf3pfY
         dn22vTeJTTO4sqL0yX+eAlKhY8M8ql4i/VLl4=
Received: by 10.204.31.218 with SMTP id z26mr1686069bkc.84.1245878396414; Wed, 
	24 Jun 2009 14:19:56 -0700 (PDT)
In-Reply-To: <20090624175940.GC7576@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122159>

2009/6/24 Ingo Molnar <mingo@elte.hu>:
> +Here is an (incomplete!) list of main contributors to those files
> +in util/* and elsewhere:
> +
> + Alex Riesen

Wow. But I actually think it may be more fair to sort the list after
any kind of rating (even something as dumb as commit count).

As everyone one the list knows, I am nowhere near a "major contributor"
to the project, as the first place may imply to a casual reader.
