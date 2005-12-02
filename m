From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git pull aborts in 50% of cases
Date: Fri, 02 Dec 2005 10:58:43 -0800
Message-ID: <43909963.60901@zytor.com>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 20:02:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EiG7Z-0006ya-5b
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 19:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVLBS67 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 13:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVLBS66
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 13:58:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:20162 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750950AbVLBS66
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 13:58:58 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jB2Iwm9w017968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Dec 2005 10:58:48 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Alexey Dobriyan <adobriyan@gmail.com>
In-Reply-To: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13121>

Alexey Dobriyan wrote:
> $ git pull
> Already up-to-date.
> $ git pull
> Already up-to-date.
> $ git pull
> Already up-to-date.
> $ git pull
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> $ git pull
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> $ git pull
> Already up-to-date.
> $ git pull
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> $ git pull
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git
> 
> Ditto for "git fetch --tags".
> 
> Can somebody explain what's going on?
> 

Do you know which IP address is aborting?  There are two servers behind 
git.kernel.org.

	-hpa
