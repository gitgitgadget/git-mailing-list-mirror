From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Thu, 16 Dec 2010 08:14:54 +0100 (CET)
Message-ID: <alpine.DEB.1.10.1012160810440.25560@debian>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com> <20101215130046.GB25647@sigill.intra.peff.net> <alpine.DEB.1.10.1012151931030.25560@debian> <20101216124235.GA32636@neumann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Dec 16 14:14:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTDf7-0007AV-3f
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 14:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755834Ab0LPNOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 08:14:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33516 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755532Ab0LPNOS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 08:14:18 -0500
Received: by vws16 with SMTP id 16so1269602vws.19
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 05:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:x-x-sender:to:cc
         :subject:in-reply-to:message-id:references:user-agent:mime-version
         :content-type;
        bh=0TpYlJDzFrAETMt8HOURqNDiaojrdlljl02G38IaqK4=;
        b=dcW2KQ0MamDB4R3t+ZLtaAsnepz1ZFd7DbTTBiTxN8UqnvqSi4BrcSGM/PEMr7HKvW
         I3P8VIpGMYxmC59P9a/c6EiQ4rW1R253eUfnBMSuvYt1geL9cB9MmeDIGzLuLlPJ99m+
         kvT0A4heydKDNxtYI47cdI+5JfF3+Dn28xdKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=t1rZy1wEdMGZNjIHJF6cFvtMZggBdhDC0BC7JGtptmZEpGpqXG7PYDT2Q8n7C3ayyL
         kqHXga2dwg+rEi8PnlbFrn/2wflsJ/Rbmf+NjMo292whgZuUsTNLrQoH8bMy19fPFbIN
         nyY2ud/Ryo+T1PFOL4N+7ZsUTPuHaWu1SSBjw=
Received: by 10.220.177.133 with SMTP id bi5mr1960703vcb.260.1292505257884;
        Thu, 16 Dec 2010 05:14:17 -0800 (PST)
Received: from [192.168.1.105] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id r7sm9064vbx.9.2010.12.16.05.14.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 05:14:16 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <20101216124235.GA32636@neumann>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163807>

On Thu, 16 Dec 2010, SZEDER G?bor wrote:

> Hi,
> 
> 
> On Wed, Dec 15, 2010 at 08:44:45PM +0100, Martin von Zweigbergk wrote:
> > On Wed, 15 Dec 2010, Jeff King wrote:
> > > As an aside, I would think "--unset" should actually choose from the set
> > > of configured variables for completion (i.e., "git config --list | cut
> > > -d= -f1"). But that would obviously be a separate patch.
> > 
> > Good point. I'll put it on my todo.
> 
> It already works that way since 0065236 (bash completion: complete
> variable names for "git config" with options, 2009-05-08).

Nice. Thanks. Removed from my todo :-). Then I don't see any reason at
all to keep color.grep.external and add.ignore-errors.


/Martin
