From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Apology/Bug report: git-send-email sends everything on Ctrl+C
Date: Wed, 26 May 2010 10:40:08 +0200
Message-ID: <4BFCDE68.4090909@drmicha.warpmail.net>
References: <4BFCB9D0.3010400@vilain.net> <4BFCC4B5.6070408@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed May 26 10:40:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHCAC-0004WH-A0
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 10:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754428Ab0EZIk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 04:40:26 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:36633 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753231Ab0EZIkZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 04:40:25 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9F9C4F8026;
	Wed, 26 May 2010 04:40:24 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 26 May 2010 04:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=V0qmcpTMt8i37O4/JQLrTCl9dS8=; b=eJ/DdweR1nSVMAqcfhzTGbTO+DZynhFLfa2uXRqW9T8VCpQBGcz/QNN2caL4LosoyGAQ0i2jEJXhw2FWWJIS+K0XmqfYMztDEDQgNYAGvS3VX3eMT3v1TmmpArfkrwuHrd3+PJN+XTw7u4Lx0B4UAjBPVsGd/qmnoHj+vcnu/c0=
X-Sasl-enc: NANOvPyBcQC07GCAJ1YDJ84yvbdRrZLdwPAF/qEQKqxV 1274863224
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0A9DA4E074;
	Wed, 26 May 2010 04:40:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100526 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <4BFCC4B5.6070408@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147782>

Sam Vilain venit, vidit, dixit 26.05.2010 08:50:
> Sam Vilain wrote:
>> Expect a mail storm shortly, sorry folks.
>>   
> 
> I just had a look at patching git-send-email.perl; but it looks like it
> is checking $? correctly at least since beece9da;
> 
>             system('sh', '-c', $editor.' "$@"', $editor, $_);
>             if (($? & 127) || ($? >> 8)) {
>                 die("the editor exited uncleanly, aborting everything");
>             }
> 
> I think I must have actually hit Ctrl-Z, not Ctrl-C.  So, it's all my
> fault and I apologize profusely.
> 
> Sam

I don't want to make you feel even worse, but could you tell us what
mistake you made so that we can avoid it? Wrong base rev for
format-patch baserev.. and piping directly into send-email?

Michael
