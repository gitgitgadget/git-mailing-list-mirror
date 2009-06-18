From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 01:11:53 -0700 (PDT)
Message-ID: <m3r5xigdvn.fsf@localhost.localdomain>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 10:12:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCj6-0007IF-Rb
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 10:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZFRIL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 04:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbZFRILy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 04:11:54 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:63248 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbZFRILx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 04:11:53 -0400
Received: by fxm8 with SMTP id 8so852019fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+kHHSeDYV5DYe1tc9OSRkE00q1Tn6Z64tNc0f8MJP/A=;
        b=qea2KbHfSA9Hb+Wt+T7MQCWZDGcp3Zf2UZjyiOfMKY20q250ygoxYXANVMZndLepwG
         FcjHZnTsxgc74qknSE6vXRXIbZlD2tLFDzHU11dWDDjKRSGN8VhR70AcQNvHpJe8ZmG3
         2bmaCHPikCyXvVsHyHB9v/atkj0fHpC7hcC3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Kq45zZVMSI+lg0i9vC4cJt0x62UYSaStx17e3jAJxkR1+3SLfVwITRAnlECuOfuHst
         U8ymGgM/CURp/FQF0OcVxMrcvN/Zfa6gu8hdFdXkjveZKUWYoxZ9S9Gy5VGzfI7kEZfy
         lXDBCbsTbFFp2YGidSbOstA1yOxsxIk7jOx2w=
Received: by 10.86.80.17 with SMTP id d17mr1617168fgb.27.1245312714589;
        Thu, 18 Jun 2009 01:11:54 -0700 (PDT)
Received: from localhost.localdomain (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id d4sm3556094fga.11.2009.06.18.01.11.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 01:11:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5I8BnYR019296;
	Thu, 18 Jun 2009 10:11:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5I8BeOq019290;
	Thu, 18 Jun 2009 10:11:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121807>

A bit off-topic: I wonder if there is an easy way to make rebase run
testsuite for the each commit it rebases, or even simple compile test,
to not introduce untestable commits when rebasing by mistake...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
