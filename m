From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Tue, 25 May 2010 10:10:54 +0200
Message-ID: <4BFB860E.1070006@drmicha.warpmail.net>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com> <20100505050640.GC8779@coredump.intra.peff.net> <AANLkTikDkrNrzPmIhmcBRKtLKV70f4Kp8wTw6I6ctB4O@mail.gmail.com> <20100512133537.GA28956@coredump.intra.peff.net> <AANLkTilkFHK1UIvSLEstXFIOJTsit02EZe1Wsoj_zRRX@mail.gmail.com> <20100523092348.GA16811@coredump.intra.peff.net> <4BFB79F6.5070501@drmicha.warpmail.net> <20100525072240.GA20408@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Knittl <knittl89@googlemail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 25 10:11:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGpEL-0001TR-6P
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 10:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab0EYILK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 04:11:10 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49196 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753061Ab0EYILI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 04:11:08 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 12230F76C8;
	Tue, 25 May 2010 04:11:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 25 May 2010 04:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=8kezohxd/M7J6Gh4PQXRPGBT7gg=; b=Pu0rQGtI+bufJjf3VTwNR+efSutfYXA4jI1UkDws37Ik45i0pKibuHAY34IZ3WWpXA1dutrGn5FS/nrdHN4k5H3JDx9rod9sOzLZLLaeV9JB4KNQIcdx2RBVYl7Fr64xvzFtRR2KN+SM5ru7beyXaLV9fLZgDyr9/p8sY5XnK+4=
X-Sasl-enc: Is0lAk25zjj5lDVkYh8YloobwjoMc2gihhzfH3wxFujC 1274775067
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3CAC44E1442;
	Tue, 25 May 2010 04:11:07 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100519 Lightning/1.0b2pre Lanikai/3.1pre
In-Reply-To: <20100525072240.GA20408@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147681>

Jeff King venit, vidit, dixit 25.05.2010 09:22:
> On Tue, May 25, 2010 at 09:19:18AM +0200, Michael J Gruber wrote:
> 
>> I'm really wondering what the problem is with git-send-email + GMail's
>> smtp. I'm not saying there is none: I'm just observing that we seem to
>> attract a lot of new contributors lately and that the email-inline-patch
>> requirement seems to be a hurdle to quite a few. I've created a mob
>> branch at
> 
> I don't use gmail, but my impression was that the problem is one of:
> 
>   1. pushing to gmail's drafts folder via imap, and then using the web
>      interface to send the email
> 
>   2. cutting and pasting into the web interface
> 
> I would hope that sending directly via SMTP with git-send-email would
> not get munged. That is pretty broken otherwise.

Well, I know what the problem is with GMail's IMAP and web, but it's
good to have it summed up this concisely ;)

I'm wondering what the problem is with GMail's SMTP: Technically there
is none, but people shy away from using it (together with
git-send-email). It does not even require setting up an MTA like
sendmail or msmtp. But, apparently, this is a hurdle, which is why I
brought up the mob-auto-send.

Michael
