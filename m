From: david@lang.hm
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 09:16:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104280915230.7120@asgard.lang.hm>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com> <4DB80747.8080401@op5.se> <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com> <4DB82D90.6060200@op5.se> <BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com> <BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
 <4DB84D65.6070906@gmail.com> <BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: gitzilla@gmail.com, Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:16:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFTtW-0000aG-9u
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 18:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780Ab1D1QQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 12:16:41 -0400
Received: from mail.lang.hm ([64.81.33.126]:59918 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab1D1QQk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 12:16:40 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p3SGGaTD024392;
	Thu, 28 Apr 2011 09:16:36 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <BANLkTimyFmujc+Lsd7DMWfJgUzZME+Sveg@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172373>

On Thu, 28 Apr 2011, Jon Seymour wrote:

> On Thu, Apr 28, 2011 at 3:07 AM, A Large Angry SCM <gitzilla@gmail.com> wrote:
>>
>> For a git plugin ecosystem to work, a (relatively) stable API/ABI is
>> necessary for the plugin authors to code to. Where is your proposal for
>> that.
>>
>
> To answer your question, the intent is to provide plugins git's
> command line interface.
>
> As has already explained by Junio amongst others, git already provides
> support for such extensions via its idiom of treating any executable
> of the form git-{command} found in the PATH.
>
> The intention of my proposal is simply to formalise the plugin
> architecture and provide a degree of plugin management.

start with documenting (and therefor formalizing) how plugins can work 
today. Then propose your change to how they work, what the benifits of 
your change are, and the code needed to implement your change.

David Lang

> Of course, others might think there is a need for ABI plugins, and
> they are free to propose such extensions, but that is not my intent.
>
> jon.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
