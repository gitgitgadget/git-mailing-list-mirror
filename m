From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some more cvsimport
Date: Fri, 10 Mar 2006 23:00:34 -0800
Message-ID: <7vacbxxy7h.fsf@assigned-by-dhcp.cox.net>
References: <440E9AA8.2020605@asianetindia.com>
	<pan.2006.03.11.06.34.26.200002@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Sat Mar 11 08:00:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHy5i-0001tu-I3
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 08:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWCKHAh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 02:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWCKHAh
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 02:00:37 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43732 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751157AbWCKHAg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 02:00:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060311065850.MTPF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Mar 2006 01:58:50 -0500
To: Rajkumar S <rajkumars@asianetindia.com>
In-Reply-To: <pan.2006.03.11.06.34.26.200002@smurf.noris.de> (Matthias
	Urlichs's message of "Sat, 11 Mar 2006 07:34:26 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17495>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Hi, Rajkumar S wrote:
>
>> When I normally do cvsimport, the releng_1
>> tree gets updated automatically, but if I have checked out the releng_1
>> branch in my local git repository when cvsimport happens the files do not
>> get updated.
>
> Don't Do That.

I tend to agree with this.

Think of foreign SCM imports, especially the ones that do not
use working tree files, just like tracking foreign branch heads
using "git fetch".  You do not fetch into the current branch,
nor you check out and do your work tracking branch.  You use
them to keep track of other people's work, and if you want to
use it you pull that into your branch, typically but not
necessarily "master".
