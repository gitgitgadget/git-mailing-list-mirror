From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: subversion-perl missing
Date: Mon, 26 Sep 2011 16:18:36 +0200
Message-ID: <4E8089BC.6030000@drmicha.warpmail.net>
References: <4E8066AB.7000208@gjlay.de> <4E807829.7050609@drmicha.warpmail.net> <4E80811B.4030309@gjlay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Georg-Johann Lay <avr@gjlay.de>
X-From: git-owner@vger.kernel.org Mon Sep 26 16:18:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8C16-00061A-HI
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 16:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060Ab1IZOSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 10:18:40 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60292 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750725Ab1IZOSj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 10:18:39 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3258D2964A;
	Mon, 26 Sep 2011 10:18:39 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 26 Sep 2011 10:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=2yo0RKim8LtgNKW6yDnFeD
	E2Nvc=; b=l2MfEkCegrnh2WPR+M/IgXkZE3LrtMsQN8YDQrmHN1W+mymHBCPFK5
	5UxprJU2URKb/6RwrYdFlvJ4g3Po8PhD5mYOAb2P7NDm1KZqXxCXGiDz6A4RgubZ
	+VvxaPBXigZ5xVXhLC+nOjn72WHXbdWsBbBjcv5Fih/pAcmoo1e5o=
X-Sasl-enc: TWJhWgpmP2R4kR9lAUfqbrUv/sjN+p6QnoOfDR8iY8S6 1317046718
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A70779A02E6;
	Mon, 26 Sep 2011 10:18:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E80811B.4030309@gjlay.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182114>

Georg-Johann Lay venit, vidit, dixit 26.09.2011 15:41:
> Michael J Gruber schrieb:
>> Georg-Johann Lay venit, vidit, dixit 26.09.2011 13:48:
>>> Hi, I just downloaded git and built from source, version is
>>>
>>> git version 1.7.6.4
>>>
>>> I am particularly interested in git-svn, but running it I get complaints
>>>
>>> Initialized empty Git repository in /local/Downloads/v4.5.x/.git/
>>> Can't locate SVN/Core.pm in @INC (@INC contains:
>>> /usr/local/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
>>> /usr/local/lib/perl5/site_perl/5.10.0
>>> /usr/lib/perl5/5.10.0/i586-linux-thread-multi /usr/lib/perl5/5.10.0
>>> /usr/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
>>> /usr/lib/perl5/site_perl/5.10.0
>>> /usr/lib/perl5/vendor_perl/5.10.0/i586-linux-thread-multi
>>> /usr/lib/perl5/vendor_perl/5.10.0 /usr/lib/perl5/vendor_perl .) at
>>> /usr/local/libexec/git-core/git-svn line 42
>>>
>>> I found out that a module like subversion-perl is missing, but installing it
>>> via OpenSuse 1.11 would downgrade my SVN installation, so I skipped that.
>>
>> So, where did you get your svn from? If you compiled it yourself, you
>> should rebuild it with the perl bindings. Make sure you note where you
>> install this to - you may have to adjust your PERL5LIB.
> 
> Hi Michael
> 
> svn identifies itself as
> 
>  > svn --version
> 
> svn, version 1.6.2 (r37639)
>    compiled Jun 19 2009, 12:21:15
> 
> Copyright (C) 2000-2009 CollabNet.
> Subversion is open source software, see http://subversion.tigris.org/
> This product includes software developed by CollabNet (http://www.Collab.Net/).
> 
> The following repository access (RA) modules are available:
> 
> * ra_neon : Module for accessing a repository via WebDAV protocol using Neon.
>   - handles 'http' scheme
>   - handles 'https' scheme
> * ra_svn : Module for accessing a repository using the svn network protocol.
>   - with Cyrus SASL authentication
>   - handles 'svn' scheme
> * ra_local : Module for accessing a repository on local disk.
>   - handles 'file' scheme
> 
> and its installed in
> 
>  > which svn
> 
> /usr/bin/svn
> 
>  > echo $PERL5LIB
> 
> <empty>
> 
> so looks like plain vanilla installation/build.
> 
> Is "perl bindings" the "subversion-perl" package (which likes to downgrade my
> svn upon installing in yast)?

Yes, subversion-perl are the perl bindings, and if your distro has
mismatching versions of subversion and subversion perl, then they have a
problem, sorry :|

> Is it a part of SVN (couln't find it there) or of perl?
> 
>  > perl --version    says:
> 
> This is perl, v5.10.0 built for i586-linux-thread-multi
> 
> Copyright 1987-2007, Larry Wall
> ...
> 
>>> Thus, being no admin and no perl guy, I am stuck now and am asking here for
>>> some kind help, being very well aware that it's not a git issue but just about
>>> getting some prerequisite for git.
>>>
>>> Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
>>> that in subversion.tigris.org, so that I am stuck and need some hints on how to
>>> proceed.
>>>
>>> Many thanks,
>>>
>>> Johann
> 
