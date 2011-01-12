From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [Bug] Gitweb corrupting files?
Date: Wed, 12 Jan 2011 09:08:54 -0800
Message-ID: <4D2DE026.4080109@eaglescrag.net>
References: <AANLkTim84sSWr=WRgjiY=Y3Mq7Tgojv9CpLrNjQMJfHR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Severin Gehwolf <jerboaa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 18:09:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd4Bz-0001K0-Lv
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 18:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957Ab1ALRI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 12:08:59 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:33243 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab1ALRI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 12:08:57 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id p0CH8sMC022225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 12 Jan 2011 09:08:54 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <AANLkTim84sSWr=WRgjiY=Y3Mq7Tgojv9CpLrNjQMJfHR@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 12 Jan 2011 09:08:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165132>

On 01/12/2011 08:05 AM, Severin Gehwolf wrote:
> Hi,
> 
> It appears that Gitweb corrupts files when it is being used for
> creating compressed tarballs of sources.
> 
> A more precise description of the behaviour I'm experiencing is here:
> https://bugs.eclipse.org/bugs/show_bug.cgi?id=317882
> 
> Unfortunately I have no knowledge about the version in use at eclipse.org.

That's a fairly old version of gitweb running (1.6.6.4), and it looks
like it's stock gitweb (I.E. not the caching version).  The file itself
(the .bz2 anyway) is a valid, and complete .bz2, as well as the .tar
file extracts cleanly.

That would indicate, that if there is corruption, it is happening in the
git process itself that generates the tarball, and not in gitweb itself.

Best plan would be to upgrade to the latest code of gitweb and git and
see if the problem still persists, and if it does be able to get us a
tarball and url that has the corruption.

- John 'Warthog9' Hawley
