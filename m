From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 13:53:51 -0700
Message-ID: <7vy7wpsu5c.fsf@assigned-by-dhcp.cox.net>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
	<7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605251134410.5623@g5.osdl.org>
	<m13bexetj1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 22:54:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjMqB-0001cO-Pf
	for gcvg-git@gmane.org; Thu, 25 May 2006 22:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbWEYUxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 16:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWEYUxx
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 16:53:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:11228 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1030412AbWEYUxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 16:53:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525205351.TEKJ15069.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 16:53:51 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m13bexetj1.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Thu, 25 May 2006 14:30:58 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20764>

ebiederm@xmission.com (Eric W. Biederman) writes:

> So fixing fetch-pack is easy and pretty non-controversial.
> The patch below handles that.

I am at work so I cannot really spend time on this right now,
but I am OK with letting it send arbitrary SHA1 the caller
obtained out of band.  I do not know about your implementation,
since I haven't really looked at it.

> (The movement of filter_refs may actually be overkill)

It may not just overkill but may actively be wrong, but again I
haven't looked at it yet.

Will take a look tonight.
