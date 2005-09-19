From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 16:24:55 -0700
Message-ID: <432F48C7.8070405@zytor.com>
References: <432F0C66.7060402@zytor.com> <20050919200222.GA11322@c165.ib.student.liu.se> <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com> <7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com> <20050919231704.GA19276@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 01:25:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHV0s-00051b-49
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 01:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbVISXZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 19:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbVISXZT
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 19:25:19 -0400
Received: from terminus.zytor.com ([209.128.68.124]:27823 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932640AbVISXZS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 19:25:18 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8JNP0vS011786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 16:25:00 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: jepler@unpythonic.net
In-Reply-To: <20050919231704.GA19276@unpythonic.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8925>

jepler@unpythonic.net wrote:
> It looks like Python2.4's subprocess module is pure Python, and works
> with python2.3.
> 
> Could subprocess.py just be included in git?

I think that would be the best solution.

	-hpa
