From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Mon, 10 Oct 2005 11:45:01 -0700
Message-ID: <434AB6AD.9090107@zytor.com>
References: <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home> <20051005202947.GA6184@trixie.casa.cgf.cx> <81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com> <81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com> <81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com> <Pine.LNX.4.64.0510070828270.31407@g5.osdl.org> <20051007205450.GA14827@steel.home> <7vfyrdyre5.fsf@assigned-by-dhcp.cox.net> <20051007234547.GC8893@steel.home> <20051008010021.GA29261@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 20:46:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2ec-0006a8-Lh
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 20:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVJJSpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 14:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVJJSpj
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 14:45:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:25777 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751181AbVJJSpj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 14:45:39 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9AIj9wj001929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 11:45:10 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Elfyn McBratney <beu@gentoo.org>
In-Reply-To: <20051008010021.GA29261@gentoo.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9908>

Elfyn McBratney wrote:
>  > 
>  > Junio, unless there already are pressing reasons to put the patch in
>  > GIT, could you postpone its inclusion (if you ever considered)? Or at
>  > least put "#ifdef __cygwin" (I hope this is the define) around it?
> 
> Close ;) - the define is "__CYGWIN__".
> 

This should be a feature-control macro in the Makefile.
