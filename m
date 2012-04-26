From: Sam Vilain <sam@vilain.net>
Subject: Re: Git.pm
Date: Thu, 26 Apr 2012 12:59:27 -0700
Message-ID: <4F99A91F.3050307@vilain.net>
References: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNUyg-0004Qy-Oq
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759186Ab2DZUHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:07:44 -0400
Received: from uk.vilain.net ([92.48.122.123]:43183 "EHLO uk.vilain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759140Ab2DZUHn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 16:07:43 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Apr 2012 16:07:43 EDT
Received: by uk.vilain.net (Postfix, from userid 1001)
	id 2DEE18283; Thu, 26 Apr 2012 20:59:29 +0100 (BST)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on uk.vilain.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=unavailable version=3.3.1
Received: from [IPv6:::1] (localhost [127.0.0.1])
	by uk.vilain.net (Postfix) with ESMTP id EC9E6823E;
	Thu, 26 Apr 2012 20:59:27 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAB3zAY3-Bn86bCr7Rxqi4vxbYFxUesLwm8gddxyMSexov2tOhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196401>

On 4/25/12 9:15 PM, Subho Banerjee wrote:
> --->  I see in the code that it says that the API is experimental. Is
> there any absolute need for backward compatibility, or can I try to
> redesign the API somewhat extensively?

If you stick to putting new APIs under different namespaces, or new 
functions, then you should be able to preserve API compatibility.  I 
think Git.pm is now too widely used for breaking compatibility to be an 
option.

I think I submitted a Git::Config to this list some time ago; did you 
find that?

Sam
