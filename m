From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Fri, 23 Jan 2009 03:47:42 +0100
Message-ID: <bd6139dc0901221847u6b8aeadcl580a091751de3d26@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
	 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 23 03:49:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQC6b-0007RX-IJ
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 03:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443AbZAWCro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 21:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbZAWCro
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 21:47:44 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:42250 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbZAWCro (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 21:47:44 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2081760yxm.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 18:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=bve5fM0PBUHAWrzRKg0WdRR9pJp1dPFu9EbEZh2DDiI=;
        b=Fbt4Uk3Ibqs3yXmps10LKvrBwiqPzw8t33NrggxeWB4z3XzG9aYOrqp8RKV7ELC9py
         swaCZrvmMRRBiX4WLB8gxeLowF7dxPem6lGuqG44f3v4vbJ8q1XIUZLE2NRsV+Pa3XxQ
         S083YphQP6/cDSC0qDWdqVsHxglUQbGllU8fQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=VQNJLjRcK2qb0J3bG54bLggZOvfFZBR79HDlEFrsC+D11xZHLJ1qDCo/Rwz0n4YLYL
         vuRZ20qMGj4zqYN7QuvYf9GWs7dzjeYfSJcX3bdVy08UCljZf7+7UTtPVuxasUWdsSbG
         uxO0dqA9kFl1IwWMzJo5wtGJzqVU+Y3V0zR9A=
Received: by 10.150.121.2 with SMTP id t2mr5600949ybc.33.1232678862683; Thu, 
	22 Jan 2009 18:47:42 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
X-Google-Sender-Auth: de8e973042c31e3b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106824>

On Fri, Jan 23, 2009 at 03:42, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> HTTP transport, however, would not die() on connection errors, from my
> cursory look.

Heh, this is why I asked you, my cursory look told me "no clue" instead.

> HTTP being 2nd class citizen anyway (and we can always fix it after Mike's
> cleanups), I'd say this patch is ready to roll.

Aside from that, am I correct in asserting that in the "worst case"
scenario the repo is cloned instead of erroring out, and a simple "git
fetch" would fix the issue?

-- 
Cheers,

Sverre Rabbelier
