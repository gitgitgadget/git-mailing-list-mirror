From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 19:00:46 -0700
Message-ID: <d4bc1a2a0810151900v3db6ca1t8d295684c5b4cd98@mail.gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>
	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
	 <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
	 <20081015062539.GB3775@blimp.localdomain>
	 <d4bc1a2a0810151352s6c963e32jc4f492a7c84841dc@mail.gmail.com>
	 <57518fd10810151402p4ea3283anf4b3d175c4e82425@mail.gmail.com>
	 <d4bc1a2a0810151418r3bf21ddaj498017e8e178f579@mail.gmail.com>
	 <d4bc1a2a0810151602j56550c3di2f59f92039fa8243@mail.gmail.com>
	 <48F67E09.90202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonathan del Strother" <maillist@steelskies.com>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 16 04:02:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqIBe-0007Lg-PJ
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 04:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbYJPCAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 22:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbYJPCAv
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 22:00:51 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:23608 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbYJPCAu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 22:00:50 -0400
Received: by an-out-0708.google.com with SMTP id d40so219304and.103
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mzcIXyiBHXUzr65rwb8ZiqKYQONKF4pMFUCzL5zGvog=;
        b=C0QqzVPIsZF/W6ZkJs8wqKyze/7Mh3SujbmpkJG+NxSN1LnsqN+cjQo10z1rntS9pB
         4W7d7pLewu0967CKEriFFUOC+k9xwTwf3YdhnV27lLzMNIPLBs4RDL/JBAwOYdQRgN/9
         5xJuSeoY1zU8s25LgqlkWiCdwG42vJuu3gKvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nTaOjGa8YxTw3aZzFhPN54/2yDBbjePOH5IbdKa8xITunPCVIJOBfQB/T3EbliXaU8
         hEYkeSebJ7R0s7alol3Ytf65z0tMAtSH3UatrIY1aK66YuQgMY6uE67rf1cMQUYMoTDv
         mDwAEAIGdG2jiluQB60iguZahc/jNbgUv3E3E=
Received: by 10.100.229.12 with SMTP id b12mr2210218anh.157.1224122446965;
        Wed, 15 Oct 2008 19:00:46 -0700 (PDT)
Received: by 10.100.197.16 with HTTP; Wed, 15 Oct 2008 19:00:46 -0700 (PDT)
In-Reply-To: <48F67E09.90202@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98343>

>> Any further comments? I'm more than willing to implement this, but I
>> won't bother if there's no chance of getting it accepted as a patch.
>> Does no one else feel like at least having the option to enforce
>> whitespace consistency in git is a good thing? If not, I guess I'll
>> just muddle along without this feature instead of implementing it.
>
> I'm against including this in except as a sample smudge/clean script. Git is
> a content tracker; not the enforcement mechanism for individual project
> policies.

Alright. Fair enough.
