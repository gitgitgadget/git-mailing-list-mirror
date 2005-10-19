From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 18:14:38 -0700
Message-ID: <43559DFE.7060503@zytor.com>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org> <43552FC2.3000000@zytor.com> <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org> <43559575.1060902@zytor.com> <Pine.LNX.4.64.0510181753340.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 03:15:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES2Xp-0004Yd-U6
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 03:15:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932392AbVJSBOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 21:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbVJSBOw
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 21:14:52 -0400
Received: from terminus.zytor.com ([192.83.249.54]:58341 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751479AbVJSBOw
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2005 21:14:52 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9J1EhFX013192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 18 Oct 2005 18:14:44 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510181753340.3369@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10254>

Linus Torvalds wrote:
> 
> On Tue, 18 Oct 2005, H. Peter Anvin wrote:
> 
>>It turns out that the default CacheSize is only 256K.  D'oh!  Fixed.
>>
>>I also changed the CacheDefaultExpire to 600 seconds.
> 
> 
> Ok, that sounds like it should improve things. My quick tests didn't seem 
> to show any difference, though. Do you need to re-load the apache module 
> or something?
> 

Yes, but I did that.  It seems very strange when something hits the 
cache.  A cgi script can apparently be run quite a few number of times 
before mod_cache sees it globally.

	-hpa
