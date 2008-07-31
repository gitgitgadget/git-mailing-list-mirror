From: Jon Loeliger <jdl@freescale.com>
Subject: Re: git-scm.com
Date: Thu, 31 Jul 2008 13:39:32 -0500
Message-ID: <489206E4.2030901@freescale.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>	 <7v3alxr0fd.fsf@gitster.siamese.dyndns.org>	 <d411cc4a0807251759m1d83d7c4w4724806b19f7c02a@mail.gmail.com>	 <7vsktwfu5z.fsf@gitster.siamese.dyndns.org>	 <20080727113707.GC32184@machine.or.cz>	 <7v3alv2n46.fsf@gitster.siamese.dyndns.org>	 <7vd4kzyoj1.fsf@gitster.siamese.dyndns.org>	 <46a038f90807271619l69c085a7o58f50b7d64b7222d@mail.gmail.com>	 <530345950807272011o7c92fdaaw3116cc257dcbab7a@mail.gmail.com>	 <alpine.DEB.1.00.0807281201350.2725@eeepc-johanness> <530345950807281112w45215c16k49ffe240d41c6a9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tom Werner <pubsub@rubyisawesome.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOd50-0004Qm-V1
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbYGaSjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbYGaSjr
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:39:47 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:36800 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbYGaSjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 14:39:47 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m6VIdgVb001853;
	Thu, 31 Jul 2008 11:39:43 -0700 (MST)
Received: from [10.214.73.187] (mvp-10-214-73-187.am.freescale.net [10.214.73.187])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m6VIdfPm025804;
	Thu, 31 Jul 2008 13:39:42 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <530345950807281112w45215c16k49ffe240d41c6a9e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90961>

Tom Werner wrote:
>
> The problem is that I'm only a casual C coder. It takes me a while to
> figure out what's going on in the git source. We needed a way to serve
> public git repositories from a hashed directory structure (e.g.
> /a/b/c/user/repo.git) and we needed it fast. 

I'm not exactly sure what you mean by "hashed directory structure",
but I suspect that your goal is some form of virtualized hosting
that allows for directory names to be dynamically constructed with
a component that appears to be the user name.

Wouldn't the --interpolated-path ability of git-daemon either
directly or with minor modifications directly support that?

jdl
