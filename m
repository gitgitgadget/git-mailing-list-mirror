From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Revamping the git protocol
Date: Thu, 20 Oct 2005 09:52:39 -0700
Message-ID: <4357CB57.3070802@zytor.com>
References: <43571DA1.6030907@zytor.com> <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net> <20051020091245.GY30889@pasky.or.cz> <Pine.LNX.4.64.0510200924110.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 18:56:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESdfD-0004U9-Ea
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 18:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVJTQxI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 12:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVJTQxI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 12:53:08 -0400
Received: from terminus.zytor.com ([192.83.249.54]:7329 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932481AbVJTQxG
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 12:53:06 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9KGqdTe009561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Oct 2005 09:52:40 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510200924110.3369@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10369>

Linus Torvalds wrote:
> 
> Similarly, git-upload-pack can be future-proofed by having it have some 
> data transfer timeout: if it doesn't make any progress at all in <n> 
> seconds, just kill itself. Things like _that_ are likely to be a lot more 
> important, I suspect.
> 

Right, I already submitted a patch for that.

> And no, I don't think th egit protocol should do authentication. It's 
> hard. If you want to do authentication, you need to do encryption too, and 
> then you should do something else (but the git protocol _does_ work fine 
> over an encyrpted channel, so the "something else" might be to have some 
> secure web interface tunnel protocol or similar, and then just support 
> "git over https" or something ;).

git over ssh seems to be the obvious choice.

	-hpa
