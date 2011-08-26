From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Files that cannot be added to the index
Date: Fri, 26 Aug 2011 16:10:02 +0200
Message-ID: <4E57A93A.6090405@drmicha.warpmail.net>
References: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: seanh <snhmnd@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 16:10:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwx6r-0001il-AN
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 16:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266Ab1HZOKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 10:10:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52106 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755153Ab1HZOKF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 10:10:05 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6E2C720E1D;
	Fri, 26 Aug 2011 10:10:04 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Fri, 26 Aug 2011 10:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=MGqyNuGNxw/HrlAsD6RjTS
	da+d0=; b=YbbnQKnmEbabdqXQHQj0hu5z+Qr3tK7yzlZ23eTu5wjFUxmhjcbLWB
	j+Nmp8toQnn2C6xmf1Dq3M0DtT4/TY1PSzAo4h4S59gEA6ScKlvlrhF8P6RmC5QY
	DXVRVvgoyesvPn0WYrQzwXwNaEswLHDFEr5f2NRhZIT4jBpm2yg3E=
X-Sasl-enc: DlHeRfXzf8a/m2ITu95Qf/QDwqVZ5OImuP3L3xnoWh7p 1314367804
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id EB0349205DE;
	Fri, 26 Aug 2011 10:10:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180171>

seanh venit, vidit, dixit 26.08.2011 14:26:
> Can anyone guess what's going on when I have a modified file that
> shows up in `git status`, but the file cannot be added to the index
> (or committed)? `git add FILE` does nothing, the file still shows as
> modified but not added in `git status`.
> 
> I have two different repos that have each developed this problem with
> two different files. I don't know how it happened. The problem occurs
> wherever the repos are cloned. Even if I delete the local copy (where
> I'm seeing the problem) and clone the repo again from elsewhere,
> problem persists.

A log of your commands (or access to the repo) would help diagnose that,
along with information about the system and the git version.

Do you "clone" by making a copy, by any chance?

Michael
