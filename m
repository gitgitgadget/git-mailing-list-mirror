From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 16:52:52 +0200
Message-ID: <48173644.1020306@gnu.org>
References: <200804281829.11866.henrikau@orakel.ntnu.no>	 <alpine.LNX.1.00.0804281515480.19665@iabervon.org>	 <200804282329.21336.henrikau@orakel.ntnu.no> <4816C26D.9010304@op5.se>	 <f9d2a5e10804290009p17d291d5wf14e2bb58bedca63@mail.gmail.com>	 <4816CC80.9080705@op5.se> <bd6139dc0804290405w4a7a94a7s15a85285b2122f2f@mail.gmail.com> <48171442.4050707@op5.se> <48171D24.9000104@gnu.org> <481732C0.5020208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sverre@rabbelier.nl, Russ Dill <russ.dill@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 29 16:54:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqrDU-0002M2-4W
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 16:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754875AbYD2Owz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbYD2Owz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 10:52:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:57340 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbYD2Owy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 10:52:54 -0400
Received: by nf-out-0910.google.com with SMTP id d3so24770nfc.21
        for <git@vger.kernel.org>; Tue, 29 Apr 2008 07:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=lz1GeOtqnn6R2z1Wcndz0tcXdWaiSDcAoEscLvO1mSc=;
        b=T51PtYl6KzOiTNCTbJ2E69+Ik5TkxmFVn9GoEbWDyzZlXSqNftRxQHGCZ99c2/5v6aWsBNc0urH96awiUu/NND5OvgaQFL8TRdNToURR0sktCVrdXZleZE3Sm4fEK8dOnWGmpvTxRZ0/jnAS3hhXvnzDxou7SnXgeQ49OC9NV9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=Cl7m4PnDRpEZIX4nl7mjvK3pHZhbFR/Dp7URL6qgc5kZldxr/V1ocLUUp8zf0r/wowma0DZ1rBurPjAfLbUN5UhEyHIltt4/AcQtWbHMsHcvNUU8wnaW0hgct4Go6Ag8Trcxfa5RGdzjCUpLkELKHU4KdaTtOJ5B0XqvlRQEZww=
Received: by 10.210.70.14 with SMTP id s14mr7467531eba.161.1209480773522;
        Tue, 29 Apr 2008 07:52:53 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id y37sm11733526mug.3.2008.04.29.07.52.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 29 Apr 2008 07:52:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <481732C0.5020208@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80687>


> So what you're saying is that if someone owns a repository and adds a
> file to it, he can then replace his entire repository with an identical
> one where the good file is replaced with a bad one, and this will affect
> people who clone *after* the file gets replaced.
> 
> Gee, that's one fiendishly large attack vector

I agree (with the irony).

Paolo
