From: Gelonida <gelonida@gmail.com>
Subject: Re: Git push from bare repo
Date: Sat, 29 May 2010 13:01:57 +0200
Message-ID: <htqs75$tco$1@dough.gmane.org>
References: <3197051701046e645c8ff2ae7dca872a@ns-linux.org> <4BFF89A5.7020802@op5.se> <3529f1c81d1062a941056914c612d8c2@ns-linux.org> <36AD1DE8-9E28-4373-94CF-72E88ABBB309@bjhargrave.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 29 13:06:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIJsG-0002uV-RF
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 13:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725Ab0E2LCQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 07:02:16 -0400
Received: from lo.gmane.org ([80.91.229.12]:54728 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab0E2LCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 07:02:15 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OIJnv-00018S-Bs
	for git@vger.kernel.org; Sat, 29 May 2010 13:02:11 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 May 2010 13:02:11 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 29 May 2010 13:02:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <36AD1DE8-9E28-4373-94CF-72E88ABBB309@bjhargrave.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147963>

BJ Hargrave wrote:
> On May 28, 2010, at 08:28 , Goran Meki=C4=87 wrote:
>>    There's more then one developer and 600 is set to just one user.
>> Post-receive hook is executed as developer doing push. The accounts =
are in
>> LDAP, but I can't set all their UID number to same number because it=
's
>> used
>> for PAM. I was thinking about ACL. Is that even a solution? The dumb=
 one
>> would be cron, but I wish I avoid pushing when there's no change.
>>
>=20
> What about having a script which does the push have setuid to the own=
er of the key. Then the post-receive hook can invoke that script which =
will have access to the ssh key to do the push.
That should work.


another option would be, that the post receive hook copies the ssh-key
file, changes its permission andcontinues only then to push.


If all users have ssh access to first server AND to second server and
all users use ssh-agent, then all users had just to make sure, that the=
y
do agent forwarding in their .ssh/config script.
