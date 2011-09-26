From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: subversion-perl missing
Date: Mon, 26 Sep 2011 16:54:45 +0200
Message-ID: <4E809235.2080401@drmicha.warpmail.net>
References: <4E8066AB.7000208@gjlay.de> <4E807829.7050609@drmicha.warpmail.net> <4E80811B.4030309@gjlay.de> <4E8089BC.6030000@drmicha.warpmail.net> <4E80916A.9060809@gjlay.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Georg-Johann Lay <avr@gjlay.de>
X-From: git-owner@vger.kernel.org Mon Sep 26 16:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Ca7-0000VX-Sj
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 16:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658Ab1IZOyt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 10:54:49 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43387 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499Ab1IZOyr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 10:54:47 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1524020738;
	Mon, 26 Sep 2011 10:54:47 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 26 Sep 2011 10:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=+DfrXgp4N/2OTa/8mM6PGJ
	0rfOc=; b=CVHKQQFfOb7YS0rM14oFX/YORiWuCmNfxN6TPy+vvMBmYtwoo9CfA9
	8QLzHYT6aLdRmmX9HpYoIdPxvV9uyViSKdpCWR0uGOJb48i3V4NHMEGT7B8JiD2x
	uufhSI9rumZC/N3w0QnJIVWdMuJGEgt3hSxs1V+jAlf1qIKKfjuF4=
X-Sasl-enc: 2+5g/wnQMmH2XalSXUZP8jilPh4TNpkYf3KLFmJ1aqFL 1317048886
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8C2406A0F29;
	Mon, 26 Sep 2011 10:54:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <4E80916A.9060809@gjlay.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182119>

Georg-Johann Lay venit, vidit, dixit 26.09.2011 16:51:
> Michael J Gruber schrieb:
>> Georg-Johann Lay venit, vidit, dixit 26.09.2011 15:41:
>>> Michael J Gruber schrieb:
>>>> Georg-Johann Lay venit, vidit, dixit 26.09.2011 13:48:
>>>>> Hi, I just downloaded git and built from source, version is
>>>>>
>>>>> git version 1.7.6.4
>>>>>
>>>>> I am particularly interested in git-svn, but running it I get complaints
>>>>>
>>>>> Initialized empty Git repository in /local/Downloads/v4.5.x/.git/
>>>>> Can't locate SVN/Core.pm in @INC (@INC contains:
>>>>> /usr/local/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
>>>>> /usr/local/lib/perl5/site_perl/5.10.0
>>>>> /usr/lib/perl5/5.10.0/i586-linux-thread-multi /usr/lib/perl5/5.10.0
>>>>> /usr/lib/perl5/site_perl/5.10.0/i586-linux-thread-multi
>>>>> /usr/lib/perl5/site_perl/5.10.0
>>>>> /usr/lib/perl5/vendor_perl/5.10.0/i586-linux-thread-multi
>>>>> /usr/lib/perl5/vendor_perl/5.10.0 /usr/lib/perl5/vendor_perl .) at
>>>>> /usr/local/libexec/git-core/git-svn line 42
>>>>>
>>>>> I found out that a module like subversion-perl is missing, but installing it
>>>>> via OpenSuse 1.11 would downgrade my SVN installation, so I skipped that.
>>>> So, where did you get your svn from? If you compiled it yourself, you
>>>> should rebuild it with the perl bindings. Make sure you note where you
>>>> install this to - you may have to adjust your PERL5LIB.
>>> Hi Michael
>>>
>>> svn identifies itself as
>>>
>>>  > svn --version
>>>
>>> svn, version 1.6.2 (r37639)
>>>    compiled Jun 19 2009, 12:21:15
>>>
>>> Copyright (C) 2000-2009 CollabNet.
>>> Subversion is open source software, see http://subversion.tigris.org/
>>> This product includes software developed by CollabNet (http://www.Collab.Net/).
>>>
>>> The following repository access (RA) modules are available:
>>>
>>> * ra_neon : Module for accessing a repository via WebDAV protocol using Neon.
>>>   - handles 'http' scheme
>>>   - handles 'https' scheme
>>> * ra_svn : Module for accessing a repository using the svn network protocol.
>>>   - with Cyrus SASL authentication
>>>   - handles 'svn' scheme
>>> * ra_local : Module for accessing a repository on local disk.
>>>   - handles 'file' scheme
>>>
>>> and its installed in
>>>
>>>  > which svn
>>>
>>> /usr/bin/svn
>>>
>>>  > echo $PERL5LIB
>>>
>>> <empty>
>>>
>>> so looks like plain vanilla installation/build.
>>>
>>> Is "perl bindings" the "subversion-perl" package (which likes to downgrade my
>>> svn upon installing in yast)?
>>
>> Yes, subversion-perl are the perl bindings, and if your distro has
>> mismatching versions of subversion and subversion perl, then they have a
>> problem, sorry :|
>>> Is it a part of SVN (couln't find it there) or of perl?
> 
> 
> I could find
> http://svn.apache.org/repos/asf/subversion/trunk/subversion/bindings/swig/INSTALL
> and hope that explains the trick so that a noob like me doesn't get lost...

That requires you to build swig and subversion, which I thought you
wanted to avoid. But if that does not scare you - by all means go ahead :)

> Many, many thanks for your help Michael!
> 
> Johann

Cheers,
Michael
