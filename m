From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-core-foo -> git-foo, except the core package
Date: Tue, 15 Nov 2005 10:38:58 -0800
Message-ID: <437A2B42.1080203@zytor.com>
References: <43797C41.2050809@zytor.com>	 <625fc13d0511150641k353d7128pf72f3542da601104@mail.gmail.com>	 <437A09F2.8080109@zytor.com> <625fc13d0511150919l48786dcam6fda56bc9d3a9fa0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 19:50:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec5iB-0008GS-Q9
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 19:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbVKOSjR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 13:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVKOSjR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 13:39:17 -0500
Received: from terminus.zytor.com ([192.83.249.54]:44171 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751461AbVKOSjQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 13:39:16 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAFId3mK001244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Nov 2005 10:39:04 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <625fc13d0511150919l48786dcam6fda56bc9d3a9fa0@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11932>

Josh Boyer wrote:
>>
>>True.  If you have a solution to that, I'd love to hear it.  Note that
>>having the core package depend on everything else is not acceptable.
> 
> %preun section that does rpm -e of the packages it brings in.  But
> that is a hack that would cause some to become violently ill.  Perhaps
> it's an issue not worth worrying about.
> 

%postun, but yes, that sounds pretty sick to me.  The Fedora people 
might disagree, in which case let them lead and we can follow suit.

	-hpa
