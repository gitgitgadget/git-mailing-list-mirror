From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] sha1_name: Suggest commit:./file for path in subdir
Date: Fri, 01 Apr 2011 08:52:56 +0200
Message-ID: <4D957648.8070008@drmicha.warpmail.net>
References: <4D94322A.8030409@drmicha.warpmail.net> <4ff35194dc52fa969049f555f8d9358cb7ba0c1a.1301562935.git.git@drmicha.warpmail.net> <7vsju3jdm2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 08:56:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5YHY-0003id-RP
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 08:56:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809Ab1DAG42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 02:56:28 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38595 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754512Ab1DAG41 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 02:56:27 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 1CE1C202D7;
	Fri,  1 Apr 2011 02:56:27 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 01 Apr 2011 02:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=kYCbf3jiwL6JsTAeZJ/9xzj7rL0=; b=u6UIdGtrJA0pEgkNvQQpLTXEev2blfekHYCR8zHdWHwdNmbpMlmUuGz/Ua29djGQnPcBIkMsoCp4goCxDt62TjbrqMLjw16lSb3UwVMGF/3EOtJW1oWEfXyQQGZOSffp2gbIo9JTwlKrOdEoHGlIyHFIw8FO1R0NqdSMND4ifsI=
X-Sasl-enc: cZcM37LW6PENLpIJ8/rjwZR8CBzOxBQw6+CZeCckWoid 1301640986
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 66DB4449DEF;
	Fri,  1 Apr 2011 02:56:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vsju3jdm2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170554>

Junio C Hamano venit, vidit, dixit 31.03.2011 21:26:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Currently, the "Did you mean..." message suggests "commit:fullpath"
>> only. Extend this to show the more convenient "commit:./file" form also.
> 
> If we were to do this, I suspect that with non-empty prefix we should only
> show "./$file" form for brevity without aka.  This is a end-user facing
> message and not meant to help scripts, no?

ENOPARSE

Do you mean:

- replace the old "commit:fullpath" with "commit:./file" or

- show the new form only without "aka" (but with the old form) or

- show literal "commit:./$file"?

I guess you meant the first one. But I left in both forms on purpose:
Saying only "commit:./file" does not explain what it means, the "./"
part is easy to miss, and the user may not even be aware to be in a
subdir. Listing both does not take much space and explains everything.

Michael
