From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 6/9] New option --ignore-whitespace for git-apply.
Date: Sun, 28 Aug 2005 16:49:35 -0400
Message-ID: <4312235F.2040907@gmail.com>
References: <1125242692932-git-send-email-robfitz@273k.net> <Pine.LNX.4.58.0508280956320.3317@g5.osdl.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 22:51:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9U6B-0004vL-TJ
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 22:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVH1Uts (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Aug 2005 16:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVH1Uts
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Aug 2005 16:49:48 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:12552 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750725AbVH1Utr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2005 16:49:47 -0400
Received: by wproxy.gmail.com with SMTP id 57so523883wri
        for <git@vger.kernel.org>; Sun, 28 Aug 2005 13:49:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=XD3cisQNp0Xd5u8rkYRKTFjI2mE2BrYu1ecVMun+4HXCeDKtw7k5lt490h/nFwXn6mZBux26Fj1ktNl3mMN2j/VsytW/aL1unPj0/7ZhT3UAGaesRU1YO/WG7puS9RQGn0M16pabvibzkjhDZpB1s5XnQK8zSspPTz3PVvNU8ds=
Received: by 10.54.37.50 with SMTP id k50mr1551822wrk;
        Sun, 28 Aug 2005 13:49:44 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id 24sm3443496wrl.2005.08.28.13.49.41;
        Sun, 28 Aug 2005 13:49:44 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Robert Fitzsimons <robfitz@273k.net>
In-Reply-To: <Pine.LNX.4.58.0508280956320.3317@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7884>

Linus Torvalds wrote:
> On Sun, 28 Aug 2005, Robert Fitzsimons wrote:
>>Allow the user to force a patch to be applied even though there might
>>be whitespace differences.  Added a test case for the new option.
> 
> If you ignore whitespace, then you should probably accept patches that are
> whitespace corrupted in another way: lines missing the ' ' at the
> beginning. Especially lines that are empty. That's actually the most 
> common form of whitespace corruption there is.

Actually, a more restricted from of --ignore-whitespace may be useful, 
--ignore-trailing-whitespace (needs a shorter name!). Ignore only 
trailing whitespace differences (including empty context lines without 
the initial space).
