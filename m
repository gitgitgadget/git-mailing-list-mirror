From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 'git add' option to non-interactively stage working tree changes
Date: Fri, 07 Jan 2011 15:50:38 -0800 (PST)
Message-ID: <m3pqs8b7fj.fsf@localhost.localdomain>
References: <AANLkTimLKZnVn8Lr-E-8M8T5mXA55XabCT5rC+broeFJ@mail.gmail.com>
	<m2aajcbiei.fsf@igel.home>
	<AANLkTi=iwOGv3PzrRcVGDwwoTXmJ4CuC11vuYsjn4xxV@mail.gmail.com>
	<7vfwt45tqv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-2?q?Hrvoje_Nik=B9i=E6?= <hniksic@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 00:50:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbM5A-0008QK-Qg
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab1AGXul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 18:50:41 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40184 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513Ab1AGXuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:50:40 -0500
Received: by wwa36 with SMTP id 36so19024333wwa.1
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 15:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=olRl+lt2Bo0sg/ZLCqQSrttv6ELFAOYyd2xcnaUFSi0=;
        b=F/NBklURESgnrxgO6RxCVdGwYCZJcPpK5advxztlxUa2a2d+DWlPAG97AHa6YgJePN
         cd3LFtwBAR/p40/vq0KHsYLtp3RtKGjKqmoP78FUmEyJyoeQDp/BbQplZiOtBqHqOpJy
         5ySMh+nBVP/ncrcsYGyBUvk4zVEc/51wKGKoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=GYhdHiwhYeMydHwSc8leQ4DpxXq3T3aMaG7u5NElwMBlwQXntexCS00Xt4zFNHYwV7
         M1tISbig1RisE1MvVBIzsF5oJNRtFjdgkCKdpBRamsT1ReZ8aFjCl1EU2+UpLWB33uwa
         iJRF/S9Gd+d0SzmoyfBJwt57jCmgp/MtNmCmU=
Received: by 10.227.138.132 with SMTP id a4mr448521wbu.77.1294444239361;
        Fri, 07 Jan 2011 15:50:39 -0800 (PST)
Received: from localhost.localdomain (abvf4.neoplus.adsl.tpnet.pl [83.8.203.4])
        by mx.google.com with ESMTPS id e12sm12732272wer.36.2011.01.07.15.50.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 15:50:38 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p07No8hj009558;
	Sat, 8 Jan 2011 00:50:14 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p07NnqP3009550;
	Sat, 8 Jan 2011 00:49:52 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vfwt45tqv.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164790>

Junio C Hamano <gitster@pobox.com> writes:

> I think it might be Ok to introduce a --full-tree option to "git add" (and
> "git grep"), though.  But introduction of corresponding configuration
> variable to flip the default needs to be done carefully in steps across
> major version boundaries as usual (i.e. first introduce --no-full-tree,

You meant --relative[1] here (instead of --no-full-tree), didn't you?

[1] Supported by diff, and in a way by git-diff-tree
-- 
Jakub Narebski
Poland
ShadeHawk on #git
