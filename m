From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: rsync deprecated but promoted?
Date: Sun, 25 Sep 2005 10:07:35 -0700
Message-ID: <4336D957.4040201@zytor.com>
References: <20050925163201.GA29198@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 19:09:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJZyv-0006lU-6P
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 19:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbVIYRHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbVIYRHu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 13:07:50 -0400
Received: from terminus.zytor.com ([209.128.68.124]:55005 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751535AbVIYRHu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Sep 2005 13:07:50 -0400
Received: from [172.27.3.248] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8PH7WNR009881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 25 Sep 2005 10:07:35 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050925163201.GA29198@tumblerings.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9271>

Zack Brown wrote:
> Hi folks,
> 
> When I use cogito, .  it gives a warning saying the rsync method is deprecated and
> will be removed in the future. But when I visit kernel.org/git, the page says to
> use an rsync URL with cg-clone.
> 
> Maybe kernel.org should be updated?

No, since it's currently the only method available to the general 
public. git-daemon still needs some tweaking before I trust to enable 
it; I've been meaning to do this but I've been personally very busy.

	-hpa
