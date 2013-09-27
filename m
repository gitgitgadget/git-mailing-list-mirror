From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: Bug: [hostname:port]:repo.git notation no longer works (for ssh)
Date: Fri, 27 Sep 2013 10:55:04 +0200
Message-ID: <524547E8.4070406@atlas-elektronik.com>
References: <87vc1mg01t.fsf@aeneas.oslo.osa>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Morten Stenshorne <mstensho@opera.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 27 10:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPTpS-0005aK-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 10:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab3I0IzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 04:55:10 -0400
Received: from mail96.atlas.de ([194.156.172.86]:10984 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab3I0IzH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 04:55:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 0954210939;
	Fri, 27 Sep 2013 10:55:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XTTWySlUOsXE; Fri, 27 Sep 2013 10:55:05 +0200 (CEST)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Fri, 27 Sep 2013 10:55:05 +0200 (CEST)
Received: from MSSRVS1.atlas.de (mssrvs1.atlas.de [10.200.101.71])
	by mgsrv01.atlas.de (Postfix) with ESMTP id 0743227169;
	Fri, 27 Sep 2013 10:55:04 +0200 (CEST)
Received: from [10.200.54.97] (10.200.54.97) by MSSRVS1.atlas.de
 (10.200.101.71) with Microsoft SMTP Server (TLS) id 8.3.279.1; Fri, 27 Sep
 2013 10:55:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <87vc1mg01t.fsf@aeneas.oslo.osa>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235449>

Am 27.09.2013 10:07, schrieb Morten Stenshorne:
> I've just upgraded to Debian testing (jessie), and with that I got a
> brand new (for me) git version:
> 
>     $ git --version
>     git version 1.8.4.rc3
> 
> Some of my repos I use an ssh tunnel to reach, so when I want to reach a
> repo forwarded to local port 2223, using the ssh protocol, the following
> used to work (.git/config) in older git versions:
> 
>     [remote "exp"]
>             url = [localhost:2223]:blink.git
>             fetch = +refs/heads/*:refs/remotes/exp/*
> 
> However, now I get this message:
> 
>     $ git fetch exp
>     fatal: ':blink.git' does not appear to be a git repository
>     fatal: Could not read from remote repository.

I wonder why that worked (especially the "[...]") at all ?
I thought specifying a port for a SSH connection was always only
possible when using

       ssh://user@host:port/path/to/repo.git
- or -
       ssh://user@host:port/~user/path/to/repo.git

At least that's what I always read out of the git-clone man page.

Stefan
-- 
----------------------------------------------------------------
/dev/random says: Don't ask me, I have random access memory.
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')"
