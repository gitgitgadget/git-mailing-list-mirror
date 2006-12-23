From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: author/commit counts
Date: Fri, 22 Dec 2006 21:27:10 -0800
Organization: YPO4
Message-ID: <20061222212710.27cb8396.rdunlap@xenotime.net>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
	<86vek3p6s3.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:26:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxzOQ-0004Ox-8H
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbWLWFZw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbWLWFZw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:25:52 -0500
Received: from xenotime.net ([66.160.160.81]:48805 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752401AbWLWFZw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:25:52 -0500
Received: from midway.site ([71.245.99.70]) by xenotime.net for <git@vger.kernel.org>; Fri, 22 Dec 2006 21:25:50 -0800
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86vek3p6s3.fsf@blue.stonehenge.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35267>

On 22 Dec 2006 20:37:00 -0800 Randal L. Schwartz wrote:

> >>>>> "Randy" == Randy Dunlap <rdunlap@xenotime.net> writes:
> 
> Randy> example:
> Randy> git log v2.6.19.. | authorcount -m | less
> 
> Randy> # this is just the ones with >= 50 Author: lines
> 
> Randy> Al Viro : 213
> Randy> Linus Torvalds : 94
> Randy> Jiri Slaby : 90
> Randy> Josef Sipek : 79
> Randy> Gerrit Renker : 77
> Randy> Adrian Bunk : 67
> Randy> Andrew Morton : 59
> Randy> Tejun Heo : 52
> Randy> Mariusz Kozlowski : 52
> Randy> Paul Mundt : 51
> Randy> Ralf Baechle : 50
> Randy> ---
> 
> With
> 
>   git-log --pretty=short v2.6.19.. |  git-shortlog -n -s | head -10
> 
> and no additional tools, I get:
> 
>     Al Viro: 213
>     Linus Torvalds: 94
>     Jiri Slaby: 90
>     Josef Sipek: 79
>     Gerrit Renker: 77
>     Adrian Bunk: 67
>     Andrew Morton: 59
>     Tejun Heo: 52
>     Mariusz Kozlowski: 52
>     Paul Mundt: 51
> 
> Looky there.

Yep, that's nice.  Thanks.

---
~Randy
