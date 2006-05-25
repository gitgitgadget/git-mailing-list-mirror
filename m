From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Thu, 25 May 2006 13:03:40 -0700
Message-ID: <7v8xopub1f.fsf@assigned-by-dhcp.cox.net>
References: <4471CF23.1070807@gmx.de>
	<7vac99c1hv.fsf@assigned-by-dhcp.cox.net> <44737353.20904@gmx.de>
	<7vzmh81gfa.fsf@assigned-by-dhcp.cox.net> <4474B10A.1020704@gmx.de>
	<7v1wuj6wln.fsf@assigned-by-dhcp.cox.net> <44759ABF.1010209@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 22:03:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjM3e-0002TK-BD
	for gcvg-git@gmane.org; Thu, 25 May 2006 22:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWEYUDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 25 May 2006 16:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbWEYUDm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 16:03:42 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:11920 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030229AbWEYUDm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 16:03:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525200341.EVJB24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 16:03:41 -0400
To: =?iso-8859-1?Q?Bj=F6rn?= Engelmann <BjEngelmann@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20758>

Bj=F6rn Engelmann <BjEngelmann@gmx.de> writes:

> I am well aware that all functionality neccessary already exists. I j=
ust
> want to prevent people learning git in future to have the same
> frustrating experience as I did.

I think I understood your points, but for normal "people
learning git", hash-object, write-tree, commit-tree and mktag
are _not_ the commands they need to know about.  These low level
commands are for Porcelain writers.  The users do not create
blobs or trees or commits -- they "git add", "git rm", "git
commit", and "git pull" and as part of these actions, blobs,
trees and commits are created.  The users do not even create
tags with mktag -- they use "git tag" for that.
