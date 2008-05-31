From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Sat, 31 May 2008 16:34:57 +0200
Message-ID: <48416211.1030807@gmail.com>
References: <20080531130450.GI18781@machine.or.cz> <1212243564-30109-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 16:35:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2SBL-0003ii-Bi
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 16:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYEaOev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 10:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752629AbYEaOeu
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 10:34:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:61173 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYEaOeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 10:34:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so325694fgg.17
        for <git@vger.kernel.org>; Sat, 31 May 2008 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=eMJ9vhy05EDq7VedrNdEOSiPMym6FsArE0cpF8+x7Bo=;
        b=rIyPIT8gk+F34Z6WxLmfLouAFmnmWAob0eUveTPCdAVd54aM6Gt9GUpivuHJA12gnH/F6ARSgzGtRwD/moPkf8uyp87GwX5sYaS9tL6F70KCK/B2pD/Bfc5pzqDNDjnVzjBPjG72S3YcsgOZ5CI29dlRW7fJtkJdNN+vI9j6rc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=rKffg4C3eBi901l4gHsQ92fGzImqXPbefv9Hhf4OP0K/Hu2bgzCLELvK/g6vXuZVcV14E8UH+kCcXB0LcFAkTG7vEyiYk28Q1yHMM84lVot7S3mUPCqK+DON3Wsjyjw2pwjXTx+McUbikoKcq6VECUg5ing5fBZjTp5UfbE7JTw=
Received: by 10.86.73.7 with SMTP id v7mr4460968fga.37.1212244488946;
        Sat, 31 May 2008 07:34:48 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id 4sm2095568fge.5.2008.05.31.07.34.47
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 May 2008 07:34:48 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <1212243564-30109-1-git-send-email-LeWiemann@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83390>

Lea Wiemann wrote:
> Subject: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for git_get_head_hash

Just to clarify, this needs "[PATCH v2] perl/Git.pm: add parse_rev 
method" to work, here:
http://mid.gmane.org/1212241932-28605-1-git-send-email-LeWiemann@gmail.com

(Apologies I keep replying to my own patches.)

-- Lea
