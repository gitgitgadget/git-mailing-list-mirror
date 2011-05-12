From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: fast forward a branch from another
Date: Thu, 12 May 2011 17:34:01 +0200
Message-ID: <4DCBFDE9.9060700@drmicha.warpmail.net>
References: <BANLkTi=PtkDp8PNdMNi3hTwHPjFg+Jtftw@mail.gmail.com> <4DCBFD55.9050005@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Frederich <eric.frederich@gmail.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu May 12 17:34:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKXu0-00011k-WF
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 17:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756944Ab1ELPeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 11:34:05 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55575 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756528Ab1ELPeD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 11:34:03 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5678220426;
	Thu, 12 May 2011 11:34:03 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 12 May 2011 11:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0b97wbWd2lTYd25IWSG5ay1o2Mo=; b=sdeNyLbshJJDXXNWduV6cLDxyDl+/S+thTTdMEYEo//Tv1QK9GMpbS6nDu4JfGSyom4+70UruVY/Ma4zu4WTEfGonivk61dGsD3vDuhk7t4gh99in7CR59xeQwOqRZ9eOxmtSth2v80qqancc6ur5nuzH0Eko7lI/DtP7dAvih4=
X-Sasl-enc: zAwkmT7xJ1PBoLjerQOAUutmslOyO0CusBxq5RLj8J+8 1305214443
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C560F403E9D;
	Thu, 12 May 2011 11:34:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <4DCBFD55.9050005@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173477>

Michael J Gruber venit, vidit, dixit 12.05.2011 17:31:
> Eric Frederich venit, vidit, dixit 12.05.2011 16:40:
>> Often times I get into a situation where I have a "development" branch
>> that gets ahead of say a "stable" branch.
>> When I am ready to call the development branch stable this is what I do.
>>
>> $ git checkout stable
>> $ git merge development
>> $ git checkout development
>>
>> The problem here is that the act of going backwards (via checking out
>> stable) really messes up my IDE and or Text editors.
>> Is there any way to do this without switching branches, which modifies
>> my working directory, which messes up my IDE?
> 
> I assume this is a ff-situation, i.e. stable is fully contained in
> developement? then you can reset branch stable like this:
> 
> test 0 -eq $(git rev-list  --count ^development stable) && git branch -f
> stable development
> 
> (I thought you could git rev-list --quiet but I'm too dumb :|)

In fact, am I even too dumb to set my from address today. Sorry! Have to
give "virtual identity" another try...

Michael
