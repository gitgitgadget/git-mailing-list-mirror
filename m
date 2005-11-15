From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-core-foo -> git-foo, except the core package
Date: Tue, 15 Nov 2005 08:16:50 -0800
Message-ID: <437A09F2.8080109@zytor.com>
References: <43797C41.2050809@zytor.com> <625fc13d0511150641k353d7128pf72f3542da601104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 15 17:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec3Uu-0002xG-6q
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 17:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbVKOQQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 11:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbVKOQQ5
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 11:16:57 -0500
Received: from terminus.zytor.com ([192.83.249.54]:60034 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751444AbVKOQQ4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 11:16:56 -0500
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAFGGoHM029589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Nov 2005 08:16:52 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <625fc13d0511150641k353d7128pf72f3542da601104@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11915>

Josh Boyer wrote:
> On 11/15/05, H. Peter Anvin <hpa@zytor.com> wrote:
> 
>>This patch renames the tarball "git" rather than "git-core", and changes
>>the names of various packages from git-core-foo to git-foo.  git-core is
>>still the true core package; an empty RPM package named "git" pulls in
>>ALL the git packages -- this makes updates work correctly, and allows
>>"yum install git" to do the obvious thing.
> 
> What about "yum remove git" ?  I don't think that will work quite so
> well.  The "git" package will be removed just fine since nothing
> depends on it, but git-<foo> will still remain.  Maybe not that big of
> a deal, but it might not be obvious to some.

True.  If you have a solution to that, I'd love to hear it.  Note that 
having the core package depend on everything else is not acceptable.

> Also, what about http://www.gnu.org/software/git/git.html ?  I seem to
> recall that was the reason the name git-core was used in the first
> place.

It's changing its name to "gitfm".

	-hpa
