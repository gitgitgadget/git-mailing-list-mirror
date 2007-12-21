From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Make "git stash" configurable
Date: Fri, 21 Dec 2007 09:23:47 -0800
Message-ID: <2AB285BD-DA6E-49D1-B664-B1A8B552DD76@midwinter.com>
References: <200712211026.lBLAQWWM014059@mi0.bluebottle.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:24:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5lbY-0002zx-V9
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbXLURXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 12:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751463AbXLURXt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:23:49 -0500
Received: from tater.midwinter.com ([216.32.86.90]:57559 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751000AbXLURXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Dec 2007 12:23:49 -0500
Received: (qmail 12084 invoked from network); 21 Dec 2007 17:23:48 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=c6TkOWkgnAMD+KWMOtPP3EKVQ7jMzN2Iq8Msy6rTEXtjIbU7+ibHmyfmVjqXBDPD  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 21 Dec 2007 17:23:48 -0000
In-Reply-To: <200712211026.lBLAQWWM014059@mi0.bluebottle.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69075>

On Dec 21, 2007, at 2:22 AM, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=
=AA=E3=81=AA=E3=81=93 wrote:

> "git stash" without argument originally created an unnamed
> stash, but some people felt this can be confusing to new
> users.  This introduces per-user config variable stash.quick to
> control this behavior.

This whole thing smells of indecision to me. We should figure out a =20
behavior we want and go with it. Git's command line interface is =20
already confusing enough without adding this kind of variability -- =20
any new user is going to look at this and say, "Why couldn't they just =
=20
make up their minds?"

My vote is to require "save". We already have an alias mechanism that =20
people can use to turn "git stash save" into a two-word command. And I =
=20
say this as someone who runs "git stash" and will have to retrain his =20
fingers.

-Steve (who thinks "trying to please everyone at all times" is usually =
=20
a source of bad UI design decisions)