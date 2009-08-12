From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign vcs
Date: Wed, 12 Aug 2009 02:33:08 -0700 (PDT)
Message-ID: <m363ctpedr.fsf@localhost.localdomain>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
	<7v1vnk79lt.fsf@alter.siamese.dyndns.org>
	<36ca99e90908110831g2ad52a5ar4a755723a6682f77@mail.gmail.com>
	<alpine.DEB.1.00.0908111817490.4638@intel-tinevez-2-302>
	<20090811214849.GA3868@sigill.intra.peff.net>
	<alpine.DEB.1.00.0908120128120.8306@pacific.mpi-cbg.de>
	<20090812074521.GD15152@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 12 11:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbADM-0007Dm-QM
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 11:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308AbZHLJdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 05:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755291AbZHLJdL
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 05:33:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:11774 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755300AbZHLJdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 05:33:09 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1059005fga.17
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=sCAsaomfrP5QVcHTF+InPhm9VS5sPqNsKrJlpwdxG6w=;
        b=MXsleTmKWzD3f91SexsHcEQpdVobP4FthxsgtG0SoZqVl8gCFuFYekeH8rnIHMw/Pn
         k9y3qbuuDMBW6lxfbusj+Ey8baAh8ZpWn2r0rqgCVx+uPav6BeQ5mnOgivZpB1ZcLE5S
         itMe9IQYviu4Ww1UIb5RgeiLqOdQWBI7jieag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=X4Dc523XoefVPLPwF6+C6CY7n1noanQxyX0VIR22UTxiYQph4ENOXkudiwP24d1qMx
         aXitvhLPHlFvtb0AWzvrWuCEW4I2KiL+galwEHTkcvH8Dh/qK/Pj4DnaMhwKsxm+vhDj
         GdO+1OSFLKjEYNh+w+tJUIEpD4C7xDRNxnhqU=
Received: by 10.86.231.5 with SMTP id d5mr259209fgh.53.1250069589052;
        Wed, 12 Aug 2009 02:33:09 -0700 (PDT)
Received: from localhost.localdomain (abvv142.neoplus.adsl.tpnet.pl [83.8.219.142])
        by mx.google.com with ESMTPS id e11sm16480288fga.16.2009.08.12.02.33.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 Aug 2009 02:33:08 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7C9W88i010248;
	Wed, 12 Aug 2009 11:32:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7C9VT6e010230;
	Wed, 12 Aug 2009 11:31:29 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090812074521.GD15152@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125687>

Jeff King <peff@peff.net> writes:

>   1. Is there some other syntax that _doesn't_ have this breakage
>      but that similarly helps the "vast majority of Git users".

Well, proposed possible syntax was:

1. <vcs>:<repository location>

   e.g.:

     svn:http://svn.example.com/project

   but

     host:path/to/repo

2. <vcs>::<repository location>

   e.g.

     svn::http://svn.example.com/project

3. <vcs>+<repository location>

   e.g.

     svn+http://svn.example.com/project

   but

     http+svn://svn.example.com/project
     svn+path/to/repo

-- 
Jakub Narebski
Poland
ShadeHawk on #git
