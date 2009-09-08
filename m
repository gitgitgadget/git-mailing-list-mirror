From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add more instructions about how to install git.
Date: Tue, 08 Sep 2009 09:56:49 +0200
Message-ID: <4AA60E41.5050702@drmicha.warpmail.net>
References: <1252386686-15689-1-git-send-email-tfransosi@gmail.com>	<81b0412b0909072244k21a4ddf6vdc38d9f713a4a084@mail.gmail.com> <vpqhbvekldk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkvZf-0001UK-PV
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753967AbZIHH5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753939AbZIHH5A
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:57:00 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57185 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753897AbZIHH5A (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 03:57:00 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 856896907C;
	Tue,  8 Sep 2009 03:57:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 08 Sep 2009 03:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Kcsz72Gc+IGHe4ELOpW+DIVEAPw=; b=Zn4F8yjoiKSVXhSqRpjKW3x5XWjFpUW4cx/kguqxqrBFiHytZQHEz8/k0e/GcaIWCAedmzl+FsMVLRtpJE42C0zE1ii92ntBlPmTUoCSGoF6ABByG6z4Wu0dbMmtblT2ZmcRRNf60RL5k/RhaOuyTClOwIHIai7idAAh6jbzWVE=
X-Sasl-enc: 3Q1dwff2ZEn3xypho5xMgtkYc+iFZD6qHT5PtRjZysPh 1252396621
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B4A151362C;
	Tue,  8 Sep 2009 03:57:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090908 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <vpqhbvekldk.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127988>

Matthieu Moy venit, vidit, dixit 08.09.2009 08:20:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
>> On Tue, Sep 8, 2009 at 07:11, Thiago Farina<tfransosi@gmail.com> wrote:
>>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>>> ---
>>>  INSTALL |    9 +++++++++
>>>  1 files changed, 9 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/INSTALL b/INSTALL
>>> index ae7f750..67abfc7 100644
>>> --- a/INSTALL
>>> +++ b/INSTALL
>>> @@ -1,6 +1,15 @@
>>>
>>>                Git installation
>>>
>>> +To install git follow these 4 steps inside your git directory:
>>> +$ autoconf      # Generates the configure file from configure.ac
>>> +$ ./configure   # Configures everything needed to build git
>>> +$ make all      # Compiles git based in the Makefile
>>> +$ make install  # Installs git in your own ~/bin directory
> 
> Your commit message doesn't say what's wrong with
> 
> | Alternatively you can use autoconf generated ./configure script to
> | set up install paths (via config.mak.autogen), so you can write
> | instead
> | 
> |         $ make configure ;# as yourself
> |         $ ./configure --prefix=/usr ;# as yourself
> |         $ make all doc ;# as yourself
> |         # make install install-doc install-html;# as root
> 
> which is already in INSTALL a few lines after what your patch adds.

... especially since that really is a second class alternative these
days, with using the shipped Makefile being the preferred way - just as
the current documentation states.

> 
>>> +If you don't have autoconf installed, you can do this by:
>>> +$ sudo apt-get install autoconf
>>
>> ... if you're on a Debian-derived system. 
> 
> and if you have sudo configured.
> 
> BTW, apt-get is anyway somehow deprecaded, you should
> s/apt-get/aptitude/.
> 
