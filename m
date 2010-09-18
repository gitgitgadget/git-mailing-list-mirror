From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2] remote-helpers: build in platform independent directory
Date: Sat, 18 Sep 2010 14:36:56 +0200
Message-ID: <4C94B268.2050904@drmicha.warpmail.net>
References: <705f70e3df519fc28e551b4c0bd7512277e7a190.1284757060.git.git@drmicha.warpmail.net> <AANLkTi=ye=Xkz2XaiBaqX3NsZOe0N1NRTaVpPcsSM8o9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 18 14:37:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owwfi-00044H-37
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 14:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069Ab0IRMh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 08:37:26 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41554 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754954Ab0IRMg6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 08:36:58 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EF578BB;
	Sat, 18 Sep 2010 08:36:57 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 18 Sep 2010 08:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=jeZXaxov7ICPcDO6cFYMdjhNN2c=; b=KjKJ+u5JB5O/DkSWK+Klxrg6Lt0YgdJS47jS48dqmRURLbg/HtpO08m8noulBSnfeTgD4yBtFUtm9aKk4E+Lchjo0K6pOUfby/XEhyGSnLaxfNhCZNv+iVDjcUCa7GT3lMdSc6SKtx31ZSS2JV/x27rjsido9FmVSf8oSMlSNRY=
X-Sasl-enc: kn8FfZHnmdBCF8quKgBx4gugw1Soj4gcxe3XVNHqZo5L 1284813417
Received: from localhost.localdomain (p548594B1.dip0.t-ipconnect.de [84.133.148.177])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 925F0408001;
	Sat, 18 Sep 2010 08:36:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <AANLkTi=ye=Xkz2XaiBaqX3NsZOe0N1NRTaVpPcsSM8o9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156453>

Sverre Rabbelier venit, vidit, dixit 17.09.2010 23:07:
> Heya,
> 
> [+Jonathan again]
> 
> On Fri, Sep 17, 2010 at 23:00, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> The solution with setup.cfg avoids this and is cleaner anyways.
> 
> This does feel a lot cleaner, I like this approach better than the v1
> one. I suspect Junio's question still stands though:
> 
> On Fri, Sep 17, 2010 at 20:41, Junio C Hamano <gitster@pobox.com> wrote:
>> Hmm, wouldn't this interfere with the install target if you do not tell
>> the "setup.py install" where your built stuff lives?
> 

No, it addresses that also. Maybe my note after the boiler plate was not
clear enough, but the "build" setting in setup.cfg also governs the
build phase of "setup.py install". Install would work with v1 also but
would possibly create another dir during the build phase, with v2 both
build phases (that of the build subcommand as well as that of the
install subcommand) use the same setting.

Michael
