From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: My git-gui difftool script
Date: Fri, 18 Feb 2011 10:24:57 +0100
Message-ID: <4D5E3AE9.7000505@drmicha.warpmail.net>
References: <loom.20110217T141642-685@post.gmane.org> <4D5D4CA0.8040301@fastmail.fm> <loom.20110218T020325-431@post.gmane.org> <4D5E2193.1050103@fastmail.fm> <loom.20110218T091946-265@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 10:28:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqMdM-0005W7-Mi
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 10:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931Ab1BRJ2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 04:28:11 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35212 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752780Ab1BRJ2I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 04:28:08 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4080220ECA;
	Fri, 18 Feb 2011 04:28:08 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 18 Feb 2011 04:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Bv1onSO48W962ETM6dnTdyuIXV4=; b=BSnsewS0EpO4jSTHqcZaKHDJKpWJLnLQuX1kmXRdKsVj5G9j3F4PVKO1djOpk0obdofnMer+fzD1H/ll0tpJUm1LxQGX5BQOjd0nrrlyPjgDnW+9mQUoNTp66KE1XffDmihJ5gWn+QRV83MSjQ+irJUDJw9vHD6hWuuL+oE0R9s=
X-Sasl-enc: DVgeuI83MUYu1LDn7hRtxY+rEOPgk+Nin6qIYKmfsK1b 1298021288
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BD585445E59;
	Fri, 18 Feb 2011 04:28:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <loom.20110218T091946-265@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167189>

Chunlin Zhang venit, vidit, dixit 18.02.2011 09:26:
> Michael J Gruber <michaeljgruber+gmane <at> fastmail.fm> writes:
> 
>> "git difftool -y $FILENAME"
>>
>> instead of
>>
>> "YOUR_PATH_TO_git_gui_difftool.py $FILENAME"
>>
>> for the command. So I'm just wondering what your new difftool.py does
>> differently from the existing git-difftool.
>>
>> Michael
>>
> ...
> I just found that I am reinventing the wheel and it is a worse wheel.

You have taught me about git-gui's Tools menu which I didn't know
before. So we both learned something :)

> I suggest this should be integrated into git-gui.

Sounds fine with me, although the flexibility of difftool may prevent
having a sane default for "use terminal".

Michael
