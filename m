From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Fri, 26 May 2006 02:27:44 -0600
Message-ID: <m18xopchrz.fsf@ebiederm.dsl.xmission.com>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605251134410.5623@g5.osdl.org>
	<m13bexetj1.fsf@ebiederm.dsl.xmission.com>
	<7vy7wpsu5c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 26 10:28:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjXgc-0006fL-Re
	for gcvg-git@gmane.org; Fri, 26 May 2006 10:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWEZI2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 May 2006 04:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWEZI2j
	(ORCPT <rfc822;git-outgoing>); Fri, 26 May 2006 04:28:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37800 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750903AbWEZI2i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 May 2006 04:28:38 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4Q8Rjxd017246;
	Fri, 26 May 2006 02:27:45 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4Q8Riwh017245;
	Fri, 26 May 2006 02:27:44 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7wpsu5c.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 25 May 2006 13:53:51 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20802>

Junio C Hamano <junkio@cox.net> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> So fixing fetch-pack is easy and pretty non-controversial.
>> The patch below handles that.
>
> I am at work so I cannot really spend time on this right now,
> but I am OK with letting it send arbitrary SHA1 the caller
> obtained out of band.  I do not know about your implementation,
> since I haven't really looked at it.

Agreed.  I'm not certain about my implementation yet either I
just know I was in the ball park.

I needed the conversation to understand what the limits were.

>> (The movement of filter_refs may actually be overkill)
>
> It may not just overkill but may actively be wrong, but again I
> haven't looked at it yet.
>
> Will take a look tonight.

Sure.  The code was all a work in progress so I don't expect to
have all of the details ironed out.  In particular I didn't
even look at the non fetch-pack case, and I didn't update the
documentation.

Eric
