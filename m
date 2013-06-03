From: Kendall Shaw <kshaw@kendallshaw.com>
Subject: Re: Setting of push.default or confusion about refspecs
Date: Mon, 03 Jun 2013 16:21:38 -0700
Message-ID: <51AD2502.4010804@kendallshaw.com>
References: <51AD1245.9050202@kendallshaw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 01:21:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uje4O-0007kd-Na
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 01:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758939Ab3FCXVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 19:21:41 -0400
Received: from b.mail.sonic.net ([64.142.19.5]:60468 "EHLO b.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758747Ab3FCXVk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 19:21:40 -0400
Received: from nekobasu.localdomain (c-67-161-38-155.hsd1.ca.comcast.net [67.161.38.155])
	(authenticated bits=0)
	by b.mail.sonic.net (8.13.8.Beta0-Sonic/8.13.7) with ESMTP id r53NLdFo019477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 3 Jun 2013 16:21:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
In-Reply-To: <51AD1245.9050202@kendallshaw.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226306>

On 06/03/2013 03:01 PM, Kendall Shaw wrote:
> ... Regarding the upstream branch, I have in .git/config
>
> [remote "origin"]
> url = http://example.com/blah
> fetch = +refs/heads/*:refs/remotes/origin/*
>
> [branch "master"]
> remote = origin
> merge = refs/heads/master
>
> git config -l shows
>
> branch.master.remote=origin
> branch.master.merge=refs/heads/master
>
> When in branch master, is the upstream branch refs/heads/master?
>
> Then, I think I can get push to push to refs/remotes/origin/master by 
> setting push.default to upstream, is that right?

I bit the wax tadpole and tried it. I think setting push.default set to 
upstream does what I thought.

Kendall
