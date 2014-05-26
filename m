From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Re: Can we stage all files using "git add" command, except some specific files ?
Date: Tue, 27 May 2014 01:57:11 +0630
Organization: CognitiveClouds
Message-ID: <11486854.4deTbW34tQ@linux-wzza.site>
References: <8392138.j8Dle5WGbS@linux-wzza.site> <1401135802.25483.1.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 22:27:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp1U6-00058v-Vq
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 22:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaEZU07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 16:26:59 -0400
Received: from nm17-vm8.bullet.mail.sg3.yahoo.com ([106.10.149.87]:47345 "EHLO
	nm17-vm8.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751472AbaEZU06 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 May 2014 16:26:58 -0400
Received: from [106.10.166.112] by nm17.bullet.mail.sg3.yahoo.com with NNFMP; 26 May 2014 20:26:56 -0000
Received: from [106.10.167.175] by tm1.bullet.mail.sg3.yahoo.com with NNFMP; 26 May 2014 20:26:56 -0000
Received: from [127.0.0.1] by smtp148.mail.sg3.yahoo.com with NNFMP; 26 May 2014 20:26:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1401136016; bh=0WHvJaEHCRyN0jBArFnzNyoxCWJgaD0kyLTxdYB4h40=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type; b=D89xcpNe1kc0IUHF/1+0ra/XuQzm/oO3beNp8tKEo+wIg6np2DeEMGykbRH/EuavAhVhoWHkJyd0YSEklyKe/ngwTGWzhOORqMtH+UXS+MCg1xGLRttFoJxHquF9Jwq/Ylf3dTaugEHAmK6uYaHwjwzFe3ZK28fnC1lmoLJq5Qo=
X-Yahoo-Newman-Id: 558633.43562.bm@smtp148.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: NroXxGgVM1nJQnGdNJWMsCuKw2fgmwqoA_llp.uIZVGqbcA
 hMV_.32xy510MpwhFyclD9IiZAzDzgeyFzks9NjVJz8ylZdwMua71KpFcLKa
 o96w4lmkvifIxvYbs2aeqcJCvMu78fdHlR0k0K4Ao90EXmW.nPORx1jr8rTS
 BYqJb7GNzhsuKY3xnXZi8V5PNWqcfkBYvvzHCkLVwbNFq4zMQmPsu4xbpWQL
 RMcW.7GCUidDvprX577C1iwbMgj7hHIn.kv5MnKfAcW.gn8ezbhPy8YMEejw
 SV4VH9Mq.boRla1zVkQHNj2TcZNIYykfOQda6gtatRPw5lSc3zzurI5hoGnl
 slj6ZIwEj4JHkcH8VUZZO7ylt4QoCrGRcccpZOr4NWgwIose3VKCwnm7KQre
 m89RV1rkwhamgrni3aSYcBIiVoqJf83IQhqcWTB7NjeyvQwsKGf0fpd5BC42
 SJIz2gFdXbjo39OiVIX9FsQKbxt8hAnG5Y8ksP6oLggAJW1.V72BbQIydjUn
 eP3gtmb8Yt4YtMnMAVVbk0Y_BCf2UM3kL9txz5d8WV5XxUac3KgPDTillRJ3
 mdQ--
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.111.198 with plain [106.10.150.171])
        by smtp148.mail.sg3.yahoo.com with SMTP; 26 May 2014 13:26:56 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-11-default; KDE/4.11.5; i686; ; )
In-Reply-To: <1401135802.25483.1.camel@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250120>

On Monday, May 26, 2014 10:23:22 PM you wrote:
> On di, 2014-05-27 at 00:33 +0630, Arup Rakshit wrote:
> > Now, you can see, I have staged all the files first using *git add
> > -A*, then _unstaging_ those I don't want to _stage_ right now. Now can
> > this be done, in the *staging* time ? I mean any way to tell `git add`
> > command, that add all the files from the current directory, except
> > some specific files.
> 
> No, there is no such option to do that, but you could use git add
> --interactive and use its interface to quickly pick the files you want
> to add.

Hi,

I tried it also.. But just didn't get it, how to use,, lots of options 1,2,3 
etc .. :)

-- 
===============
Regards,
Arup Rakshit
