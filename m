From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Thu, 12 Nov 2009 15:30:33 -0500
Message-ID: <4AFC7069.1020701@fastmail.fm>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>	 <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm> <2729632a0911121208r1f51cf9ewb0bc23e757275f30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Nov 12 21:31:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8gJq-0003Fx-I7
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 21:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbZKLUae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 15:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753909AbZKLUae
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 15:30:34 -0500
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:22800 "HELO
	smtp100.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753512AbZKLUae (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 15:30:34 -0500
Received: (qmail 85306 invoked from network); 12 Nov 2009 20:30:39 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp100.rog.mail.re2.yahoo.com with SMTP; 12 Nov 2009 12:30:39 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: 97eu6SsVM1mmhi20chehiURtiVOFZ1Qq.5Q0DRMW.4Zb.DpHPumG5mu.bVyoO2YWJg--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 01EAB21C05CC;
	Thu, 12 Nov 2009 15:30:39 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FnbPyqn-EYUZ; Thu, 12 Nov 2009 15:30:33 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id B3B1A21C05CB;
	Thu, 12 Nov 2009 15:30:33 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <2729632a0911121208r1f51cf9ewb0bc23e757275f30@mail.gmail.com>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132798>

skillzero@gmail.com wrote:
>> +.Update maint to new release
>> +[caption="Recipe: "]
>> +=====================================
>> +* `git branch -f next master`
>> +* `git merge ai/topic_in_next1`
>> +* `git merge ai/topic_in_next2`
> 
> Shouldn't that be something like "Update next to new release" instead
> of "maint"?

Oops. I changed the caption to "Rewind and rebuild next".

> Should it also have 'git checkout next' after the branch command so
> it's on next before merging?

Right, fixed also.

Thanks,
Raman
