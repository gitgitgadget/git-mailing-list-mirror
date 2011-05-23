From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: combined diff does not detect binary files and ignores -diff
 attribute
Date: Mon, 23 May 2011 15:30:54 +0200
Message-ID: <4DDA618E.4030604@drmicha.warpmail.net>
References: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 15:31:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOVDq-0000Ob-Cg
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 15:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab1EWNa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 09:30:57 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33894 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531Ab1EWNa4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2011 09:30:56 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BB1D320F63;
	Mon, 23 May 2011 09:30:55 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 23 May 2011 09:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=M9dG3mNXT8KrnLE0OaK2bxdoXLY=; b=dFtOZdQJ9MX/Wgmc4mad/zLaGaHXRWZw/zEwJXOViywt80qX/+nwyCnwOKwJQMz2xYFaF0kjKp8p3KsnOHjEhlAHwpKOk1TJ1BOGQc2cGOPIlP/VP+LArmcRQbe8d3GUXGH4MJiQ+pBDXvwBLiYp+VqXWBNsWyEC+X2sHT1/WzM=
X-Sasl-enc: nRYnHXOAxXK7ImnkWOjqd8PyE3IWZeMQiwIAKh1GBGxk 1306157455
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4A054401D3C;
	Mon, 23 May 2011 09:30:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174242>

Jay Soffian venit, vidit, dixit 22.05.2011 22:12:
> In a merge commit, I added some PNGs (so they were new to both
> parents). I was surprised when I did a "git show" on the commit and
> had the binary bits spewed to the terminal.
> 
> I thought it was just git not detecting the PNG as a binary file, but
> adding "*.png -diff" to .git/info/attributes made no difference.
> 
> Just reporting this for now, as I don't have time to investigate.
> 
> j.

We know, but we somehow got stuck, see:

http://permalink.gmane.org/gmane.comp.version-control.git/171613

I don't have the time to follow up on this currently, it got out of
proportion.

Michael
