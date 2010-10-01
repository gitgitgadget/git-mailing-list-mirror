From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: lost connection in middle of interactive rebase
Date: Fri, 01 Oct 2010 16:42:26 +0200
Message-ID: <4CA5F352.2050001@drmicha.warpmail.net>
References: <i83bg4$rl6$1@dough.gmane.org> <4F91C587-981C-4429-9FDD-24931BCC9DEA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 16:42:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1goc-000225-KW
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 16:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756889Ab0JAOmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 10:42:16 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34552 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756669Ab0JAOmP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 10:42:15 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 285812EB;
	Fri,  1 Oct 2010 10:42:15 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 01 Oct 2010 10:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=bPXJL060OL4ByA37bNngbFz7KHU=; b=c9DUj1Q/+Mxd90dQUen38kkLdRUlJbxBC5oOrAc8b2DJHPe9wnFDazfbZs5aFReE5TcjsQcwJCW6g8q4cnURYG2VrGlvTya46/u/gnH0X3Xa7paI/ZeISbgEoeMkJpdEKB9wUM77W+XOpmPJHhsRo9+am9s9vQmn4KcLJQSqknQ=
X-Sasl-enc: GQcTa+6WuSe/aKYKt9ruMqsoXwY93uKd2RS8BdWKjWoQ 1285944134
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 84D975E5610;
	Fri,  1 Oct 2010 10:42:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <4F91C587-981C-4429-9FDD-24931BCC9DEA@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157755>

Joshua Juran venit, vidit, dixit 10/01/2010 03:18 AM:
> On Sep 30, 2010, at 5:53 PM, Neal Kreitzinger wrote:
> 
>> I use a terminal emulator in windows to connect to a remote linux  
>> box.  The
>> git repos are on the linux box.  If my network connection drops  
>> during the
>> middle of my interactive rebase, how do I recover?
> 
> git rebase --abort
> 
> Josh
> 
> 

...and remember to use "screen" on the linux side next time :)

Michael
