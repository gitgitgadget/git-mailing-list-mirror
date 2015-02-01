From: Joker <joker@byom.de>
Subject: Re: Importing from RTC to GIT
Date: Sun, 1 Feb 2015 04:50:06 -0700 (MST)
Message-ID: <1422791406383-7624818.post@n2.nabble.com>
References: <43622BFE4D7C4B4094E4A212BD8B2B0353B69B31C7@isifboise45.isif.state.id.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 12:50:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHt2c-0003nk-Ef
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 12:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbbBALuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 06:50:08 -0500
Received: from mwork.nabble.com ([162.253.133.43]:59446 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651AbbBALuG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 06:50:06 -0500
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 8B4621276D14
	for <git@vger.kernel.org>; Sun,  1 Feb 2015 03:50:08 -0800 (PST)
In-Reply-To: <43622BFE4D7C4B4094E4A212BD8B2B0353B69B31C7@isifboise45.isif.state.id.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263233>

Its the more or less the same response as I wrote in the stackoverflow
thread.
To begin with, we run into the same issue...

We also wanted to keep our history and didnt found anything. So we started
to create a python script, which automates the process to migrate RTC SCM
Stream by Stream to GIT.

The script(s) can be found here: https://github.com/WtfJoke/rtc2git

It doesnt work with git fast import, though. But its a possible way to
migrate your components. You can read how it works on the stackoverflow-post
or in the project description.
The script is not finished yet, but in a good state. With that I was able to
migrate some components sucesfully already (the rtc commands take some time
for completion, therefore it takes quite a lot of time to migrate stuff).



--
View this message in context: http://git.661346.n2.nabble.com/Importing-from-RTC-to-GIT-tp7617984p7624818.html
Sent from the git mailing list archive at Nabble.com.
