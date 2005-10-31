From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild
 bug)
Date: Mon, 31 Oct 2005 12:46:17 -0800
Message-ID: <43668299.60603@zytor.com>
References: <43652934.8000308@zytor.com>	 <7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>	 <20051031064105.GV8041@shell0.pdx.osdl.net>	 <43663EEA.5050102@zytor.com> <7v4q6xfpqg.fsf@assigned-by-dhcp.cox.net>	 <46a038f90510311213n565010d6g5586a7484b25da7e@mail.gmail.com>	 <Pine.LNX.4.64.0510311230290.27915@g5.osdl.org> <46a038f90510311244n5fc35166k43ea2410e92d83d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Sebastian Kuzminsky <seb@highlab.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:47:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWgYh-0000vQ-9y
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 21:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVJaUrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 15:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVJaUrH
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 15:47:07 -0500
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:51343 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1751034AbVJaUrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 15:47:07 -0500
X-Envelope-From: hpa@zytor.com
Received: from [10.4.7.148] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j9VKkfJv022246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 31 Oct 2005 12:46:41 -0800
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90510311244n5fc35166k43ea2410e92d83d4@mail.gmail.com>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10885>

Martin Langhoff wrote:
> 
> I agree, but that's kind of a bummer for servers where someone just
> wants to publish a couple of repos. tk depends on xlibs/libx11 and
> that's just _nasty_.
> 
> git-core should be good for deployment on a server. Perhaps we want to
> provide a git-scm package that brings in all the goodies you're likely
> to want, including gitk?
> 

How about calling it just "git"?

	-hpa
