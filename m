From: =?UTF-8?Q?Goran_Meki=C4=87?= <meka@ns-linux.org>
Subject: Re: Git push from bare repo
Date: Fri, 28 May 2010 14:28:27 +0200
Message-ID: <3529f1c81d1062a941056914c612d8c2@ns-linux.org>
References: <3197051701046e645c8ff2ae7dca872a@ns-linux.org> <4BFF89A5.7020802@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 28 14:28:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHyfy-0004ho-KB
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 14:28:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415Ab0E1M23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 08:28:29 -0400
Received: from barbossa.ns-linux.org ([85.131.239.116]:38368 "EHLO
	barbossa.ns-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0E1M22 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 08:28:28 -0400
Received: by barbossa.ns-linux.org (Postfix, from userid 1011)
	id 5A89B7DA217; Fri, 28 May 2010 14:28:27 +0200 (CEST)
In-Reply-To: <4BFF89A5.7020802@op5.se>
X-Sender: meka@ns-linux.org
User-Agent: RoundCube Webmail/0.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147926>


On Fri, 28 May 2010 11:15:17 +0200, Andreas Ericsson <ae@op5.se> wrote:=
=0D
> On 05/28/2010 08:57 AM, Goran Meki=C4=87 wrote:=0D
>> =0D
>>      I have to push from first server to second (yeah, the names are=
=0D
>>      great=0D
>> :o) when ever someone pushes to first server. It should be done usin=
g=0D
>> post-receive hook, for example. The problem is that I can not specif=
y=0D
ssh=0D
>> key, and even if I could, anything but 600 perm for the key is=0D
rejected.=0D
>> What would be the best way to acomplish this? Thanx!=0D
>> =0D
> =0D
> Why can't you specify ssh key, and why can't you set the key to have=0D
perms=0D
> 0600 and let it reside in a directory with perms 0700?=0D
> =0D
> The post-receive hook is just a shell-script, basically.=0D
    There's more then one developer and 600 is set to just one user.=0D
Post-receive hook is executed as developer doing push. The accounts are=
 in=0D
LDAP, but I can't set all their UID number to same number because it's=0D
used=0D
for PAM. I was thinking about ACL. Is that even a solution? The dumb on=
e=0D
would be cron, but I wish I avoid pushing when there's no change.=0D
=0D
-- =0D
=46reeB(eer)S(ex)D(rugs) are the real daemons
