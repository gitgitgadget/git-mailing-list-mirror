From: Georg-Johann Lay <avr@gjlay.de>
Subject: Re: subversion-perl missing
Date: Mon, 26 Sep 2011 15:41:47 +0200
Message-ID: <4E80811B.4030309@gjlay.de>
References: <4E8066AB.7000208@gjlay.de> <4E807829.7050609@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Sep 26 15:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8BRg-0002kr-0q
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 15:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207Ab1IZNmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 09:42:03 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:16084 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab1IZNmB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 09:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1317044518; l=2814;
	s=domk; d=gjlay.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:CC:To:MIME-Version:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=tnDfCmQwHB9m+AbLkZwcrhYmzz0=;
	b=dNvJTEQBU6d4y3sspDX0o3zN+Nr+SPA/rPZoVQt04XMmITGja1BOVpDRRfT+bmRL5o1
	acBnwFHyaMEjSk2wg3IYIJXlyl3FZLmHdkSc7cdEmKsyohgBzkJkJi5Geefa5RfEMSzIo
	Ch/iQwTDW1tfvvaGeGcPTbxeLyoWPk5xUO8=
X-RZG-AUTH: :LXoWVUeid/7A29J/hMvvT2k715jHQaJercGObUOFkj18odoYNahU4Q==
X-RZG-CLASS-ID: mo00
Received: from [192.168.0.22]
	(business-188-111-022-002.static.arcor-ip.net [188.111.22.2])
	by smtp.strato.de (jimi mo38) (RZmta 26.7)
	with ESMTPA id j00fe6n8QCDvAn ; Mon, 26 Sep 2011 15:41:48 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100302)
In-Reply-To: <4E807829.7050609@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182110>

Michael J Gruber schrieb:
> Georg-Johann Lay venit, vidit, dixit 26.09.2011 13:48:
>> Hi, I just downloaded git and built from source, version is
>>
>> git version 1.7.6.4
>>
>> I am particularly interested in git-svn, but running it I get complaints
>>
>> Initialized empty Git repository in /local/Downloads/v4.5.x/.git/
>> Can't locate SVN/Core.pm in @INC (@INC contains:
>> /usr/local/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
>> /usr/local/lib/perl5/site_perl/5.10.0
>> /usr/lib/perl5/5.10.0/i586-linux-thread-multi /usr/lib/perl5/5.10.0
>> /usr/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
>> /usr/lib/perl5/site_perl/5.10.0
>> /usr/lib/perl5/vendor_perl/5.10.0/i586-linux-thread-multi
>> /usr/lib/perl5/vendor_perl/5.10.0 /usr/lib/perl5/vendor_perl .) at
>> /usr/local/libexec/git-core/git-svn line 42
>>
>> I found out that a module like subversion-perl is missing, but installing it
>> via OpenSuse 1.11 would downgrade my SVN installation, so I skipped that.
> 
> So, where did you get your svn from? If you compiled it yourself, you
> should rebuild it with the perl bindings. Make sure you note where you
> install this to - you may have to adjust your PERL5LIB.

Hi Michael

svn identifies itself as

 > svn --version

svn, version 1.6.2 (r37639)
   compiled Jun 19 2009, 12:21:15

Copyright (C) 2000-2009 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet (http://www.Collab.Net/).

The following repository access (RA) modules are available:

* ra_neon : Module for accessing a repository via WebDAV protocol using Neon.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme

and its installed in

 > which svn

/usr/bin/svn

 > echo $PERL5LIB

<empty>

so looks like plain vanilla installation/build.

Is "perl bindings" the "subversion-perl" package (which likes to downgrade my
svn upon installing in yast)?

Is it a part of SVN (couln't find it there) or of perl?

 > perl --version    says:

This is perl, v5.10.0 built for i586-linux-thread-multi

Copyright 1987-2007, Larry Wall
...

>> Thus, being no admin and no perl guy, I am stuck now and am asking here for
>> some kind help, being very well aware that it's not a git issue but just about
>> getting some prerequisite for git.
>>
>> Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
>> that in subversion.tigris.org, so that I am stuck and need some hints on how to
>> proceed.
>>
>> Many thanks,
>>
>> Johann
