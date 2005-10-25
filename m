From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The MIT error
Date: Tue, 25 Oct 2005 09:50:03 -0700
Message-ID: <435E623B.20303@zytor.com>
References: <200510251340.j9PDeGGt006248@laptop11.inf.utfsm.cl> <435E3892.4020002@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 25 18:54:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUS0P-0000Ru-Uk
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 18:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVJYQuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 12:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVJYQuQ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 12:50:16 -0400
Received: from terminus.zytor.com ([192.83.249.54]:53738 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932205AbVJYQuP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 12:50:15 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9PGo8N3009604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Oct 2005 09:50:09 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <435E3892.4020002@op5.se>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10596>

Andreas Ericsson wrote:
> 
> No they don't. "begin with either is or to and a lowercase letter", 
> meaning (is|to)[a-z].*, just as Morten wrote. is_.* doesn't fall into 
> this category. The underscore exemption is so that users can write their 
> own is_file(), is_whatever() str_replace() and such. Some thought has 
> gone into the standard.
> 

Also, note that we don't include <ctype.h>, and the reasons to stay out 
of its namespace are:

a. potential for confusion (different semantics), and
b. broken system headers.

	-hpa
