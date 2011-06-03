From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git: 'daemon' is not a git command. See 'git --help'.
Date: Fri, 03 Jun 2011 13:18:52 +0200
Message-ID: <4DE8C31C.5060409@drmicha.warpmail.net>
References: <201105301258.08178.lucio@sulweb.org> <BANLkTim17a53hP8N-nG-Gad1oB_-g7wSfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Lucio Crusca <lucio@sulweb.org>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 03 13:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSSP7-0004gQ-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 13:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab1FCLS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 07:18:56 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:47502 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752066Ab1FCLSz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2011 07:18:55 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 450B020B13;
	Fri,  3 Jun 2011 07:18:55 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 03 Jun 2011 07:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=JAgbejku/sf07gPVrRy89d5zcFo=; b=VMVRUN9yNgp0uQJrmizDCjzNd1pQpqfwC2/CH7LdpMMHV4EcxndTmXOl8NGe9lj6veMEmACy8CDlliF+DinuMX8MpBmb/MOOeuAcxmvw8pLgme0dPvGA66x9mSbV1DB6YzfAe24PQS3qSXWGcW7qsA2vgyhBJIimlop5Wv0qmnw=
X-Sasl-enc: xRaHedumnauUnSdP0MpfX6yIY5YzBjxCbj1N35UJrB0g 1307099934
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 990ED443BAD;
	Fri,  3 Jun 2011 07:18:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTim17a53hP8N-nG-Gad1oB_-g7wSfw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175005>

Erik Faye-Lund venit, vidit, dixit 30.05.2011 13:27:
> On Mon, May 30, 2011 at 12:58 PM, Lucio Crusca <lucio@sulweb.org> wrote:
>> Hi *,
>>
>> I'm very new to git and I'm trying to share a git repo on a Centos 5.6 server.
>> I've installaed git 1.7.4.1 with yum (I already had the epel repo setup).
>> git init, add, commit work as expected, but when I
>>
>> # touch .git/git-daemon-export-ok
>>
>> and
>>
>> # git daemon
>>
>> I get:
>>
>> git: 'daemon' is not a git command. See 'git --help'.
>>
>> And no git-daemon file can be found in /usr (find /usr -name git-daemon). Google
>> seems to be aware of this problem only about msysGit (windows).
>>
>> What am I doing wrong?
> 
> A quick google search tells me that git-daemon is a separate package
> for Red Hat.

For future reference:

yum provides '*/git-daemon'

gives you the package providing that file.

Michael
