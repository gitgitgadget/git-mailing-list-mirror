From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 18:49:30 +0200
Message-ID: <49F9D69A.9080204@drmicha.warpmail.net>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>	 <49F8B7D1.2090903@drmicha.warpmail.net>	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>	 <49F8C127.4000400@drmicha.warpmail.net>	 <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>	 <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>	 <32541b130904300741p325012b7g28dabbd33576ceae@mail.gmail.com>	 <46a038f90904300803h555f02b3n76d03c93d99f7506@mail.gmail.com>	 <32541b130904300926x472d6d14p2896d3ade7566684@mail.gmail.com> <46a038f90904300931l4460a085pce97fcb5cdf32dc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 18:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzZSr-0008Rf-U7
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 18:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbZD3Qtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 12:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763326AbZD3Qtl
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 12:49:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43696 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762267AbZD3Qtk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Apr 2009 12:49:40 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 14745335483;
	Thu, 30 Apr 2009 12:49:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 30 Apr 2009 12:49:40 -0400
X-Sasl-enc: 6/LX5nT2n6naLcxKpneRsuJaYFYvN1JA7h2SmVSAi8Dj 1241110179
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id DF0964EEB4;
	Thu, 30 Apr 2009 12:49:38 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <46a038f90904300931l4460a085pce97fcb5cdf32dc3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118032>

Martin Langhoff venit, vidit, dixit 30.04.2009 18:31:
> On Thu, Apr 30, 2009 at 6:26 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>> And do the contents of these files match the ones in your git source
>> directory?  What are their md5sums?
>>
>> /home/martin/libexec/git-core/git-svn
>> /home/martin/share/perl/5.10.0/Git.pm
> 
> They match alright -
> 
> sha1sum /home/martin/share/perl/5.10.0/*
> e5ceeaa91bfe878ac45a5e5daad4fa1d50b6ff4a
> /home/martin/share/perl/5.10.0/Error.pm
> d752abdebc8e40801d891859e6764631c2f1e8ff  /home/martin/share/perl/5.10.0/Git.pm
> 
> ~/src/git$ sha1sum perl/blib/lib/*pm
> e5ceeaa91bfe878ac45a5e5daad4fa1d50b6ff4a  perl/blib/lib/Error.pm
> d752abdebc8e40801d891859e6764631c2f1e8ff  perl/blib/lib/Git.pm
> 
> ~/src/git$ sha1sum /home/martin/libexec/git-core/git-svn git-svn
> 37cae8b77552f0bbdd54e060318bbc6a269a7577  /home/martin/libexec/git-core/git-svn
> 37cae8b77552f0bbdd54e060318bbc6a269a7577  git-svn
> 
> it's really weird.

Have you ever checked the usage strings which your instances of
"git-cat-file" output, as I suggested?

BTW: Does make test work for you?

Michael
