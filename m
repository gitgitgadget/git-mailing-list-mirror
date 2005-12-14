From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Tracking files across tree reorganizations
Date: Wed, 14 Dec 2005 15:12:33 -0800
Message-ID: <43A0A6E1.9070903@zytor.com>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 00:14:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emfnw-0000pa-Rm
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 00:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVLNXM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 18:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVLNXM6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 18:12:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:5310 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965036AbVLNXM5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 18:12:57 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBENCiln018764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Dec 2005 15:12:44 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051214223656.GJ22159@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13655>

Petr Baudis wrote:
> Hah, here we go again. :-)
> 
> Dear diary, on Wed, Dec 14, 2005 at 10:15:59PM CET, I got a letter
> where "H. Peter Anvin" <hpa@zytor.com> said that...
> 
>>Did anything ever happen with that?
> 
> Linus is against it.
> 

I don't think so.  Linus is against the user having to explicitly record 
the moves, but we can detect the moves at the point of reorganization.

> Cogito will do it anyway ;-), when someone sends me a nice patch or when
> I get to it (probably not very soon). I imagine it like this:
> 
> (a) User can explicitly note file moves / renames. We follow those notes.
> Probably the most viable for recording the notes is appending them at
> the tail of the commit message.
> 
> (b) If there are no notes for the given commit, we do the rename
> autodetection already implemented in GIT. If it yields something,
> we follow it.

I don't see anything in Linus' posts that says (b) is unacceptable.

	-hpa
