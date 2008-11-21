From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git.pm
Date: Thu, 20 Nov 2008 18:56:51 -0800 (PST)
Message-ID: <m363mhlw92.fsf@localhost.localdomain>
References: <200811191856.44252.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nadim Khemir <nadim@khemir.net>, Petr Baudis <pasky@suse.cz>,
	Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 03:58:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3MDj-0003n0-CV
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 03:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbYKUC44 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2008 21:56:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYKUC44
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 21:56:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:34395 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbYKUC4z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2008 21:56:55 -0500
Received: by ug-out-1314.google.com with SMTP id 39so9213ugf.37
        for <git@vger.kernel.org>; Thu, 20 Nov 2008 18:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=NwbNJu0Oenhfw3XgnWAm/kFwa6LL7Xw7ZPtFFvt1J6Y=;
        b=DmXcguSncS3T3KREwVi+ZkZbwpvGkUdXhKWBxeMCGdKdmqCyS31M+IUip3smx8F8z1
         JBIzhyapa0288n1rOlaIFyGzXfe0qWtouuQVKpyjWzXpT17ho0LnBoCdXFwzaVk20V3i
         oi7Jg8IpgZMkz6moAEpbLAblLlGTmaIh+ogw0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=YgMY4wBpyuTp68QtVfppb0CADbOEIIImq8wmu5Sjsi8rIGEaK8bODZgbxIO0qEyhnW
         rt9+HLtFaitl9DaWuEAI1a3U2jyaxpYT2+qNZtiFVQJfr1FKpMRM1UojfnfFYUVgrWID
         4NghqJMmr5yZ8tj2QUJeFxfivPCBReGp4j29E=
Received: by 10.66.234.8 with SMTP id g8mr16628ugh.41.1227236213141;
        Thu, 20 Nov 2008 18:56:53 -0800 (PST)
Received: from localhost.localdomain (abvv166.neoplus.adsl.tpnet.pl [83.8.219.166])
        by mx.google.com with ESMTPS id k1sm23459ugf.3.2008.11.20.18.56.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Nov 2008 18:56:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAL1AKE4005063;
	Fri, 21 Nov 2008 02:10:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAL1AHPH005060;
	Fri, 21 Nov 2008 02:10:17 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200811191856.44252.nadim@khemir.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101495>

nadim khemir <nadim@khemir.net> writes:

(CC-ed Petr Baudis and Lea Wiemann).

> Hi, I'm new on this mailing list and quite new to git too. I said
> on IRC that I develop mainly in Perl (http://search.cpan.org/~nkh/)
> when I do open source. I heard that Git.pm needed some love and I
> can take over its maintenance if there are things that need to be
> done.
>=20
> I need to know:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0- what needs to be done
> =A0=A0=A0=A0=A0=A0=A0=A0- who was doing maintenanace before
> =A0=A0=A0=A0=A0=A0=A0=A0- how do you want to release it
>           (perl modules are best placed on CPAN (too))
> =A0=A0=A0=A0=A0=A0=A0=A0- what (and who) is depending on Git.pm
> =A0=A0=A0=A0=A0=A0=A0=A0- what would be expected of me
>=20
> As you may have seen in another mail, the Perl community is getting=20
> interested in git.

Actually there are one and a half of Perl interfaces to Git: Git.pm
created by Pasky (who, as far as I understand is not a Perl hacker)
which is in git.git repository, and Git::Repo and friends created by
Lea Wiemann during her work on "gitweb caching" project at Google
Summer of Code 2008 (you can find her repository at git wiki page
http://git.or.cz/gitwiki/SoC2008Projects).


If I remember history of Git.pm correctly, it was first created as a
way to collect together and uniquify various versions of safe_pipe and
safe_qx which were used by various Perl scripts in git; something like
Perl version of git-sh-setup.sh for shell scripts... At first it even
used XS in parts, but the build system was deemed too unportable (it
depended on -fPIC). One of design decisions was to use Error.pm for
throwing errors; I'm not a Perl hacker, so I cannot say if this was a
good decision, and if implementation of this part is good.

Lea Wiemann work on Git::Repo and friends was created as object
oriented interface. It was build from ground up instead of reusing
Git.pm to be not encumbered by Git.pm cruft... unfortunately it means
also abandoning all the work that went in Git.pm to make it portable
(read: make it work with crippled ActiveState Perl). You can find
discussion on the design of Git::Repo and decision of it being clean
state implementation at link given by Pasky.


P.S. I have "[RFC] Git Perl bindings, and OO interface" half-written
(well, more like a third), a bit stalled. I'll try to find time to
finish it and send it to git mailing list.

P.P.S. "git grep 'use Git'" finds git-add--interactive.perl,
git-send-email and git-svn. Probably other Perl scripts (including
gitweb) could make use of it...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
