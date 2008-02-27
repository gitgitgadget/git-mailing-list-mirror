From: Tim Stoakes <tim@stoakes.net>
Subject: Re: git-svn messing with timezones
Date: Wed, 27 Feb 2008 20:56:31 +1030
Message-ID: <20080227102631.GJ30300@mail.stoakes.net>
References: <20080226124748.GH31792@mail.stoakes.net> <20080227073244.GB24316@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Feb 27 11:27:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUJVC-0003w4-PA
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 11:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbYB0K03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 05:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753508AbYB0K03
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 05:26:29 -0500
Received: from hosted02.westnet.com.au ([203.10.1.213]:43510 "EHLO
	hosted02.westnet.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbYB0K02 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 05:26:28 -0500
Received: from hosted02.westnet.com.au (hosted02.westnet.com.au [127.0.0.1])
	by hosted02.westnet.com.au (Postfix) with SMTP id D07ED497B5;
	Wed, 27 Feb 2008 19:26:25 +0900 (WST)
Received: from mail.stoakes.net (dsl-202-173-137-105.sa.westnet.com.au [202.173.137.105])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hosted02.westnet.com.au (Postfix) with ESMTP id 6C13749BBF;
	Wed, 27 Feb 2008 19:26:24 +0900 (WST)
Received: from noodle.stoakes.net (unknown [192.168.20.209])
	by mail.stoakes.net (Postfix) with ESMTP id EC37128C0CD;
	Wed, 27 Feb 2008 20:56:23 +1030 (CST)
Received: by noodle.stoakes.net (Postfix, from userid 1000)
	id C2EC17F025; Wed, 27 Feb 2008 20:56:31 +1030 (CST)
Content-Disposition: inline
In-Reply-To: <20080227073244.GB24316@soma>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-PMX-Branch: TNG-Outgoing
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75220>

Eric Wong(normalperson@yhbt.net)@260208-23:32:
> The regular svn client converts the UTC time to the local time (or
> based on the TZ= environment).  Using "git svn log" should mimic the
> timezone behavior of the regular svn client.

Ah indeed, `git-svn log` does show the correct TZ. How annoying!

My workflow is to work with native git as much as possible, and interact
with svn as little as is required. This means I have to remember to run
one command to see sane logs of git commits that happen to also be svn
commits, and another one for the normal git commits. There is no
transparency here.

Thanks for clearing that up though Eric. Is it documented anywhere?

Tim

-- 
Tim Stoakes
