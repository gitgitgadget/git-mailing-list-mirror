From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Fri, 26 May 2006 02:32:53 -0600
Message-ID: <m14pzdchje.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
	<m1y7wpde1w.fsf@ebiederm.dsl.xmission.com>
	<7virntsto6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 10:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjXlU-0007bb-Ds
	for gcvg-git@gmane.org; Fri, 26 May 2006 10:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWEZIdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWEZIdp
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 04:33:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42664 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750706AbWEZIdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 04:33:45 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4Q8WrKU017296;
	Fri, 26 May 2006 02:32:53 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4Q8WrIw017294;
	Fri, 26 May 2006 02:32:53 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virntsto6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 25 May 2006 14:04:09 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20803>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:

>> - It feels really weird when everything else allows me to use sha1s
>>   for git-fetch to deny them.
>
> That is a real argument and I am not opposed to change
> fetch-pack to ask for an arbitrary SHA1 the caller obtained out
> of band.

Good this was the primary reason I kept pursuing the issue after
I figured out what it was.

>> Then there is the big hole in my plan to get better changelog information
>> that it appears that after Andrew pulls a branch he resolves some
>> merge conflicts.  If that is right I need to figure out how to address
>> that before I can improve git-quiltimport.sh.
>
> The last time I talked with Andrew, he is not doing a merge nor
> resolving merge conflicts.  He treats git primarily as a
> patchbomb distribution mechanism, and works on (a rough
> equivalent of) the output of format-patch from merge base
> between his base tree and individual subsystem tree.  After that
> things are normal quilt workflow outside git, whatever it is.

That sounds right.  I just know that there I had some strange
merge conflicts on the second git tree I pulled from.  Something
about a file being added twice.  It was one thing too many to
investigate this round.

Eric
