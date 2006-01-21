From: Andreas Ericsson <ae@op5.se>
Subject: Re: git pull and remote tags
Date: Sat, 21 Jan 2006 14:29:56 +0100
Message-ID: <43D23754.10408@op5.se>
References: <200601211119.09268.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 14:30:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Iob-00005q-8z
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 14:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWAUN36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 08:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWAUN36
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 08:29:58 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:8837 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932191AbWAUN35 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 08:29:57 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id D9C3C6BD09; Sat, 21 Jan 2006 14:29:56 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andrey Borzenkov <arvidjaar@mail.ru>
In-Reply-To: <200601211119.09268.arvidjaar@mail.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14994>

Andrey Borzenkov wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I initialized repository (it was udev by the way) using git clone when it was 
> on release 080. Now after 081 was out I did "git pull" and it did pulled 
> changes but I do not see tag 081. What is the proper way to sync remote 
> repository with local copy while retaining all refs?
> 

Upgrade to the very latest git suite or do

	$ git fetch --tags

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
