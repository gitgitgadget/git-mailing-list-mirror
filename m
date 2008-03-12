From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 11:35:23 -0700 (PDT)
Message-ID: <m3prtzyens.fsf@localhost.localdomain>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
	<7vskywadum.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0803112234470.2947@xanadu.home>
	<alpine.LSU.1.00.0803121833210.1656@racer.site>
	<47D8193B.901@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 12 19:36:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZVoC-0006KN-D6
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 19:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbYCLSf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 14:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbYCLSf1
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 14:35:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:25677 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbYCLSf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 14:35:26 -0400
Received: by ug-out-1314.google.com with SMTP id z38so308245ugc.16
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=AhGHXb4CYFAUEDWri1XYJpMbFSFBtX1r0be7BaYdQ5w=;
        b=BKfE7Cr3s4tqde1H/UEc6vN3A8SSshsLuGEd2Ej+fbmFsBs17GLMSBcXYxPjIx436pUVWCZHkus3k4/Ad9zW0gXaKUfSh+C9pnndD0FoLMlQYhfPSBzb9S/a0RupK2JpmstUgNrBNI18PpiySnMl4yNT1Rc3B/KktY9IRODq974=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=WFhpizTveh3kJtaVEaXSu7rAHy6nIgBsek8ptHQ0xapSjotQ2C1U5qYpCBzTYDpwtNN0GypUHPwDfCs6+5J8FqY4GBLO/OMpCsafJZeKD26KCAfb7b1oDtTvKeYMXqhkNx5uSw8baqKmyDA1opSI4TSsU1NPt3sGEw6FOhH+JQI=
Received: by 10.66.243.13 with SMTP id q13mr943593ugh.59.1205346924728;
        Wed, 12 Mar 2008 11:35:24 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.246.110])
        by mx.google.com with ESMTPS id s1sm1296477uge.28.2008.03.12.11.35.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Mar 2008 11:35:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2CIZQ52016001;
	Wed, 12 Mar 2008 19:35:26 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2CIYl77015995;
	Wed, 12 Mar 2008 19:34:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <47D8193B.901@nrlssc.navy.mil>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76970>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Is 'git-gc --prune' still useful to end users when those in-the-know can use
> git-prune when they really want all loose unreferenced objects to be removed?

It is one command less to remember (just like with "git tag --verify"
and "git verify-tag"), so I'm all for "git gc --prune" to remain.
 
> Also, what about clones created with --shared or --reference? Should there be
> a way to disable this functionality? gc.pruneExpire never

That would be nice.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
