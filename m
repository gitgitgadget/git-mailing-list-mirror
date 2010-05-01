From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFD PATCH] revlist/rev-parse: Introduce --heads and --locals
 revision specifiers
Date: Sat, 01 May 2010 21:47:49 +0200
Message-ID: <4BDC8565.6050308@drmicha.warpmail.net>
References: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net> <m3bpczcsup.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 01 21:47:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8IfN-0008VC-8O
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554Ab0EATrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:47:51 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56126 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757517Ab0EATru (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 May 2010 15:47:50 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 5908EF1E6E;
	Sat,  1 May 2010 15:47:49 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sat, 01 May 2010 15:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=tsii6Bc1p4ED8K1u1GpVVSm0KK4=; b=fpL9jemCGBqwn4YYCUMX70rmg15NNkjywRENjtCbbaOQWLZenaVKnRnqYj/aDIvPRp6iijrg+YZYfBbGiuFe2eJ1G/LpwwVu0eFtGwHwxR0sVHx1t0LesF2UGM/SzQicO7hsExEdNIunfByuZGqGll52vXUoMSYTnT9esB2Q2RA=
X-Sasl-enc: sIucOw3GAVjX/elBsO5tx7AUqHd+TMVoi9a2BZsIyxAF 1272743269
Received: from localhost.localdomain (p5DCC08EA.dip0.t-ipconnect.de [93.204.8.234])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AC52D21D47;
	Sat,  1 May 2010 15:47:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <m3bpczcsup.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146114>

Jakub Narebski venit, vidit, dixit 01.05.2010 21:42:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Due to the increasing usage of the ref namespace (e.g. notes, replace)
>> the revision specifier "--all" becomes decreasingly useful. But
>> "something like --all" is ineeded for getting a quick overview of
>> the development state of a repository.
>>
>> Introduce --heads and --locals specifiers in order to help with that:
>>
>> --heads == HEAD --branches --remotes
>> --locals = HEAD --branches --tags
> 
> Wouldn't new feature (introduced in 1.7.0) of --glob=<glob-pattern>
> be enough?
> 

You can already use the exact expressions which I wrote above
("--branches --tags" etc.). The point is to have short ones for the most
useful cases.  And "--all" used to be useful.

It's just that we don't have aliases for rev notation ;)

Michael
