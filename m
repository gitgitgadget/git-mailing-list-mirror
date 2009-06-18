From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Re: rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 06:10:41 -0700 (PDT)
Message-ID: <m3my85hem2.fsf@localhost.localdomain>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<alpine.DEB.1.00.0906180007370.26154@pacific.mpi-cbg.de>
	<20090618001111.GB12954@vidovic>
	<7v8wjq2kqc.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906181003300.4848@intel-tinevez-2-302>
	<87vdmuhs75.fsf@iki.fi>
	<alpine.DEB.1.00.0906181028140.4848@intel-tinevez-2-302>
	<87r5xihqxw.fsf@iki.fi>
	<alpine.DEB.1.00.0906181415520.4848@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 18 15:10:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHHOF-0003b1-OC
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 15:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069AbZFRNKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 09:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZFRNKl
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 09:10:41 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:44945 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbZFRNKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 09:10:40 -0400
Received: by fxm8 with SMTP id 8so1027999fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 06:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=o6nB5KVzup/F5qWZuNq8WWipfPQDknlW0ap4Gk/lpV4=;
        b=D2r9tIChCPyzcQqtXw4+IRwctLCGHaH6/5HIKoqAzIkHkuu/G/M6ZlyGNmRPrC/crx
         KgUp26CZtadglKpJq31dTvZP57N1zatQ3UtspXlwNmn6atTUcyIlKvfbbTbbrMTrCEiB
         4K8mxAe6oqx51Fao9eczAovm9Y/CSVjTe4Ejo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=xL5dkKuOQw4hFKuqeWBvPPq1ZC59thBMfrgCXFUE/YB3X7StAjunrXulzkwOct7Nxr
         SHrMiJeIrogZUy64rICRW7J9lCnOCCEIuxEMbhHvw2FMn3aPvYk1NZMoMVbdt9cPc9cm
         vEUe6gQKnSJUFl26dVuP5wuN+a1ed/ynD3cg8=
Received: by 10.102.215.19 with SMTP id n19mr637157mug.5.1245330641724;
        Thu, 18 Jun 2009 06:10:41 -0700 (PDT)
Received: from localhost.localdomain (abvq34.neoplus.adsl.tpnet.pl [83.8.214.34])
        by mx.google.com with ESMTPS id e9sm1462169muf.32.2009.06.18.06.10.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 06:10:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5IDAWF4023348;
	Thu, 18 Jun 2009 15:10:34 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5IDAUjw023345;
	Thu, 18 Jun 2009 15:10:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.1.00.0906181415520.4848@intel-tinevez-2-302>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121837>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> On Thu, 18 Jun 2009, Teemu Likonen wrote:
> 
> > On 2009-06-18 10:29 (+0200), Johannes Schindelin wrote:
> > 
> > > So let's just interpret the "!" in the most common meaning, namely to 
> > > add an imperative. Then it means "yes, I do want to squash". Not 
> > > "squash, but oh, BTW, I want to lose the second commit message 
> > > completely, and I do not want to edit the commit message either".
> > 
> > My main point is the "small modifier character" for squash. Perhaps
> > "squash*" is better?
> 
> If you think that putting a special meaning to a special character is 
> intuitive, I have to inform you that you are mistaken.

Nice bike-shedding... But UI is hard to change later, usually.

Yet another proposition would be to simply remove subject to mark
commit to be squashed without adding commit message to squashed result
commit message

    pick aaaa ...
    squash bbbb
    pick cccc ...
    pick dddd ...

 Just my 2 eurocents.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
