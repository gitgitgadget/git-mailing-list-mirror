From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git-daemon --inetd
Date: Thu, 15 Sep 2005 12:19:25 -0700
Message-ID: <4329C93D.2020701@zytor.com>
References: <43290EFF.3070604@zytor.com> <Pine.LNX.4.58.0509150829090.26803@g5.osdl.org> <4329BDD9.4010507@zytor.com> <Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 15 21:22:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFzGy-0002Y1-La
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 21:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVIOTTt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 15:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbVIOTTt
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 15:19:49 -0400
Received: from terminus.zytor.com ([209.128.68.124]:59823 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964800AbVIOTTs
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 15:19:48 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8FJJSDb013030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 Sep 2005 12:19:29 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509151142570.26803@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8628>

Linus Torvalds wrote:
> 
> On Thu, 15 Sep 2005, H. Peter Anvin wrote:
> 
>>Wrapping it in chroot() would mean having enough things in the chroot 
>>environment to support starting up programs, which is ugly.  I'll test 
>>the patch when I get a chance.
> 
> 
> Fair enough. This still requires "git-upload-pack" and any libraries that
> requires, of course. You might want to do a statically linked version or
> something.
> 
> Hmm. A quick check seems to say that git-upload-pack only does libz and 
> libc. And the SHA1 stuff, of course, but that you can always get static by 
> using the git built-in mozilla versions.
> 

Could git-upload-pack be integrated into the git-daemon binary, so that 
the exec isn't needed?

	-hpa
