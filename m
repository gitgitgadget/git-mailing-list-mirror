From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [GSoC update] git-remote-svn: Week 11
Date: Mon, 12 Jul 2010 16:48:40 +0200
Message-ID: <4C3B2B48.4070408@drmicha.warpmail.net>
References: <20100712143546.GA17630@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Greg Stein <gstein@gmail.com>, Stefan Sperling <stsp@elego.de>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Huijben <rhuijben@collab.net>,
	Sam Vilain <sam@vilain.net>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 16:49:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYKKF-0004FW-8B
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 16:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab0GLOti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 10:49:38 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34972 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755767Ab0GLOth (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jul 2010 10:49:37 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E595E16BDC2;
	Mon, 12 Jul 2010 10:49:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 12 Jul 2010 10:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=g+ZIbi55euE5tKWqtPupRZ4+99k=; b=VwPd9aLyNj4eoCeLlHfq/HVDZ5Xxo86YaGKMHKHZ2tmNkB/U7lg/vYnPrchN6ZP0mkQhINNd+H49AyKR9MfFiCrLm9qenEJYxJ2ixPpARpsiZXJwNoDDx2fB90jxaL2BpRLyLqeqjtgDZrheCpdVxSMBSHJhIdxgkxAi94xWl1U=
X-Sasl-enc: TL6SFzfxMZGSynsE+aerDJ6ekUXR6D7jcrE7YUE8mUOV 1278946176
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 149FB4DEEA1;
	Mon, 12 Jul 2010 10:49:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <20100712143546.GA17630@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150816>

Ramkumar Ramachandra venit, vidit, dixit 12.07.2010 16:35:
> Hi,
> 
> I'm happy to report that I'll soon be getting partial committer access
> to the ASF repository (thanks to Greg for this) and will be able to
> commit the svnrdump there. At the moment, all the validations pass
> without any issues and I've shifted my focus towards writing a
> dumpfile v3 parser [1] to get the data into David's exporter. I will
> re-roll a series for git.git in some time again after I've fixed a few
> pending things pointed out by Jonathan in his excellent reviews and
> merged a few patches from Will; although this isn't top priority, it
> will be pretty painful for Git developers to compile the SVN trunk
> even if they want to try out git-remote-svn.

While this is certainly true for the "compilation" part, at least
getting the source is a snap for us:

git://git.apache.org/subversion.git
git://github.com/apache/subversion.git

:)

Michael
