From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 3/3] builtin/show.c: do not prune by pathspec
Date: Fri, 01 Apr 2011 08:46:36 +0200
Message-ID: <4D9574CC.7090005@drmicha.warpmail.net>
References: <2590090d32e748932d988dff3897058b909e8358.1301562935.git.git@drmicha.warpmail.net> <4D94322A.8030409@drmicha.warpmail.net> <3bee7fb376e2fb498c9634ab2ff5506f8c74a7bc.1301562936.git.git@drmicha.warpmail.net> <AANLkTik4wy3B1S=7_2opLdAVy5LBq55VsfZnkj0=QskC@mail.gmail.com> <4D948105.3050009@drmicha.warpmail.net> <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 08:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5YBU-0001Ed-V0
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 08:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597Ab1DAGuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 02:50:08 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38045 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754512Ab1DAGuH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 02:50:07 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id F275A20863;
	Fri,  1 Apr 2011 02:50:06 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 01 Apr 2011 02:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=y07OCRUrTr/i6rctQ43SHmSr8C4=; b=lbUSYDNGXq8+qFRfzNDvC8vdoXTl9E4eB7T/z+bPwTeeO4vSGCLH6f4mI+Dv+F7IOvng1YebqHmtZZ68CBmwDx0IqloAXHoQkTwdv29sHg5/rAwbDIuVYg8D0zLL9+x+QnAvyNm/N/5PdF6wh7D71XYMtl4rAjVZUqOSfEIneUA=
X-Sasl-enc: Rrww5bZYyn5auhJwlaS/+RMDU6eYOVnqXdg3GMn12RrX 1301640606
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3C8584004F2;
	Fri,  1 Apr 2011 02:50:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170552>

Junio C Hamano venit, vidit, dixit 31.03.2011 21:23:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>> Tests please?
>>
>> Heck, we don't have any to begin with, and this is marked RFC. Given our
>> usual reluctance to change even undocumented behavior I'm not going to
>> bother with tests for an RFC.
> 
> Quite the contrary, a well written test is a concise and readable way to
> illustrate what behaviour the proposed change is making, and helps judging
> if it is going in a good direction.  So if it is an RFC, a test would help
> very much, especially if there isn't any in the area currently.

While that may be true in some cases (e.g., providing sample output) I
don't think the commit message to 3/3 leaves anything open that a test
could clarify.

Michael
