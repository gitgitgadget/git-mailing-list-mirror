From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 08:38:45 -0800
Message-ID: <43CE6F15.2050801@zytor.com>
References: <200601181325.59832.Mathias.Waack@rantzau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 17:43:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzGMR-0000S9-R6
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 17:40:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWARQja (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 11:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWARQja
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 11:39:30 -0500
Received: from terminus.zytor.com ([192.83.249.54]:26770 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030395AbWARQi4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 11:38:56 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k0IGcjFc009192
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jan 2006 08:38:46 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Mathias Waack <Mathias.Waack@rantzau.de>
In-Reply-To: <200601181325.59832.Mathias.Waack@rantzau.de>
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14836>

Mathias Waack wrote:
> Hello everybody, 
> 
> we're using git with cogito as a frontend. For some reasons I forgot we have 
> some repositories which belong to the same project. To simplify the whole 
> thing I would like to join these repositories. It mainly means to move some 
> directories. So lets say I have: 
> 
> 	/r1/.git
> 	/r2/.git
> 
> and what I would like to have is
> 
> 	/r/.git
> 	   r1
>            r2
> 
> Of course the history should remain (otherwise it would be to easy). 
> 
> How should I do this?
> 

Rename the files in each repository independently (with a checkin), then 
merge the repositories.

Git *should* track across the rename, as long as it's "obvious".

	-hpa
