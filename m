From: Pascal Obry <pascal@obry.net>
Subject: Re: git svn clone just stops
Date: Fri, 18 Dec 2009 16:00:27 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B2B990B.9060502@obry.net>
References: <1260915555.6475.8.camel@mark.engr.acx> <20091216081514.GB26038@dcvr.yhbt.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Jerkovic <mjerkovic@aconex.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Dec 18 16:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLeJb-0002BV-PH
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 16:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887AbZLRPAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 10:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753870AbZLRPAQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 10:00:16 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:40235 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbZLRPAN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 10:00:13 -0500
Received: by fg-out-1718.google.com with SMTP id 22so1195673fge.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 07:00:12 -0800 (PST)
Received: by 10.103.38.13 with SMTP id q13mr1788794muj.109.1261148411721;
        Fri, 18 Dec 2009 07:00:11 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-9-63.w82-124.abo.wanadoo.fr [82.124.71.63])
        by mx.google.com with ESMTPS id 12sm8296631muq.18.2009.12.18.07.00.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 07:00:10 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091216081514.GB26038@dcvr.yhbt.net>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135412>

Eric,

> Not without error messages of some sort.  git svn was designed with poor
> network conditions in mind and clone is resumable, so you can just
> resume like this:
> 
>    cd project.git && git svn fetch

What about --revision option. I mean if I have this clone interrupted:

   $ git svn clone --revision=345:HEAD svn+ssh://...

Should I specify --revision when restarting with fetch? I think I had an
issue with this...

Maybe some other options are also to be passed to fetch?

Thanks.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
