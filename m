From: Pascal Obry <pascal@obry.net>
Subject: Re: git on 64bit windows - state of the art?
Date: Wed, 20 Jun 2012 08:57:41 +0200
Organization: Home - http://www.obry.net
Message-ID: <4FE17465.4040501@obry.net>
References: <CAH3AnrrzKycCGprrWxiu5S5fuTHA8-cuNTi14Wz5WdtG+6FNJA@mail.gmail.com> <4FE0D02B.2040703@obry.net> <CAH3AnrqwUQkTAYHASgNMCTuCGFqsZUux44uhdMXGDGdJ9hV7oQ@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 08:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShErK-0005Or-AH
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 08:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580Ab2FTG5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 02:57:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56554 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab2FTG5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 02:57:41 -0400
Received: by weyu7 with SMTP id u7so4988866wey.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 23:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=HUPFXlwibdHaOqWVinbgF9GROrNSpXPfsFfl7fRZEmU=;
        b=jozooGMWM92BlhO9cloT16iIujKfm/6e84tZRQ2yjKmuUB9cPkh35UYb9HNKCzEuBD
         jF17ULdIDRIxZpHwe7IrN49/5EWLKlogTvr9qhpxCu4ynjVNEFA/XV+j64LG+M9rl/f0
         I/rlVIbMFjdel/oyxaJFEe8C/nCz2GscK1QUJkcrCiClGg49ECFNoV7nqcCfUnmil+9Y
         ANXzR6yNVNluF0y+DKyb0mVobevHTvEyGL3V0ZSoREURZNv1UKmpMlHg4JC1zCsrcGZ7
         0BMtIPiwrmIRwuE+4F9QdTG5lOsbwyWdV6JmLPBoIc2eK2GZhPa4PPCgks5SPfF3RAqy
         kJiw==
Received: by 10.216.225.196 with SMTP id z46mr11317754wep.17.1340175460166;
        Tue, 19 Jun 2012 23:57:40 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-102-20.w90-2.abo.wanadoo.fr. [90.2.120.20])
        by mx.google.com with ESMTPS id eb8sm37419746wib.11.2012.06.19.23.57.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 23:57:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <CAH3AnrqwUQkTAYHASgNMCTuCGFqsZUux44uhdMXGDGdJ9hV7oQ@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQkl4L59CdYJRFfm4J6W9fWX8OXx9ZALnTzH7cjJKMRsW7s5CQxVqAipxBi8jtnCnx7tBlvd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200286>

Jon,

> Thank you. I think we have tried the -b option without much luck, but
> I don't think we have tried the -o option.
> 
> I will arrange to do some testing and will post to the list in a few
> weeks if this looks to be a definitive solution to the problem (or
> otherwise)

Ok, the most important part is running peflagsall, this was the way to
fix that properly on Win7 IIRC.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
