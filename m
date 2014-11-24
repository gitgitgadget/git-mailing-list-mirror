From: bancfc@openmailbox.org
Subject: Re: How safe are signed git =?UTF-8?Q?tags=3F=20Only=20as=20safe?=
 =?UTF-8?Q?=20as=20SHA-=31=20or=20somehow=20safer=3F?=
Date: Mon, 24 Nov 2014 00:52:42 +0000
Message-ID: <6246f36ca7006d29b97f2e453c9e52c8@openmailbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 24 02:01:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xsi1X-0000ld-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 02:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbaKXBAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 20:00:55 -0500
Received: from mail2.openmailbox.org ([62.4.1.33]:52108 "EHLO
	mail2.openmailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaKXBAy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 20:00:54 -0500
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Nov 2014 20:00:53 EST
Received: from localhost (localhost [127.0.0.1])
	by mail2.openmailbox.org (Postfix) with ESMTP id 897D82022FD
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 01:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=openmailbox.org;
	 h=user-agent:message-id:subject:subject:from:from:date:date
	:content-transfer-encoding:content-type:content-type
	:mime-version:received:received; s=openmailbox; t=1416790362;
	 bh=KFQ183elyR7BHeI4+EpksT5FC8NsqC909IaAuEJz2pw=; b=F6f6tOLKTLKs
	0n1C2FeHPjaAkwnSEvJIRH3RjHEAVbY9PIVwW0WfbYIp7wY5LuyXpHAWI0/SmSNC
	OYRZoZzs8IYVl4x2EGkeP6RqrTOjryBNrY+ebsjmnGQgFXCHI/WFIUMvdxhTOe9D
	dVeEV8hNKBk3Ci1NZUIQXe8LukYWPYE=
X-Virus-Scanned: at openmailbox.org
Received: from mail2.openmailbox.org ([62.4.1.33])
	by localhost (mail.openmailbox.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xx68v5qJa57g for <git@vger.kernel.org>;
	Mon, 24 Nov 2014 01:52:42 +0100 (CET)
Received: from www.openmailbox.org (localhost [127.0.0.1])
	by mail2.openmailbox.org (Postfix) with ESMTP id A9F0D202C02
	for <git@vger.kernel.org>; Mon, 24 Nov 2014 01:52:42 +0100 (CET)
X-Sender: bancfc@openmailbox.org
User-Agent: Roundcube Webmail/1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260110>

Hi, I wanted to chime in on the topic of SHA1 weaknesses and breaks. The 
problem is idea that SHA1 breaks are theoretical and will only  be 
relevant in a decade or two.

I think its a telling sign when even companies like Google [1] and 
Microsoft [2] who collaborate with spy agencies are moving away from 
SHA1 in verifying browser certs and the estimates by reputable 
cryptographers already put us in the realm of feasible breaks at this 
time, with the bar going lower with every passing year [3]. In three 
years common cyber criminals will be able to crack it using moderate 
sized computer clusters or by renting some AWS cycles.

Please reconsider the urgency of moving away from SHA1 for security 
functions in Git.


References:

[1] 
http://thenextweb.com/google/2014/09/05/google-will-start-sunsetting-sha-1-cryptographic-hash-algorithm-chrome-month-finish-q1-2015/

[2] https://www.schneier.com/blog/archives/2013/11/microsoft_retir.html 
(Schneier on Security: Microsoft Retiring SHA-1 in 2016)

[3] https://www.schneier.com/blog/archives/2012/10/when_will_we_se.html 
(When Will We See Collisions for SHA-1?)
