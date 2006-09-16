From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: nightly tarballs of git
Date: Sat, 16 Sep 2006 20:04:13 +0200
Organization: At home
Message-ID: <eehe9n$v1b$1@sea.gmane.org>
References: <20060914172754.GF8013@us.ibm.com> <20060914175116.GB22279@redhat.com> <7v1wqe45vs.fsf@assigned-by-dhcp.cox.net> <20060914193616.GA32735@redhat.com> <7virjq2oyc.fsf@assigned-by-dhcp.cox.net> <20060916175853.GA24124@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Sep 16 20:03:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOeWA-0001v3-Q5
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 20:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWIPSDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 16 Sep 2006 14:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWIPSDw
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 14:03:52 -0400
Received: from main.gmane.org ([80.91.229.2]:64161 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750829AbWIPSDv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Sep 2006 14:03:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOeW2-0001th-4C
	for git@vger.kernel.org; Sat, 16 Sep 2006 20:03:46 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 20:03:46 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 20:03:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27124>

Dave Jones wrote:

> * refs/heads/pu: does not fast forward to branch 'pu' of
>   git://git.kernel.org/pub/scm/git/git;=20
> =A0 not updating.
> Something wicked happend.
=20
Did you put '+' before 'pu' line in 'origin' file in remotes?
It should read

        Pull:+refs/heads/pu:refs/heads/pu

Alternatively you can give --force option to git-fetch.

See
http://git.or.cz/gitwiki/GitFaq#head-a1f9a3e511e0b866d788d7cb600637a9b9=
76a994
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
