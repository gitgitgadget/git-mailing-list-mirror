From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: dependable submodules
Date: Tue, 22 Mar 2011 19:56:31 +0100
Message-ID: <4D88F0DF.8080808@web.de>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>	<7vd3lmv2k1.fsf@alter.siamese.dyndns.org>	<AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>	<4D877A70.8070907@jku.at>	<AANLkTikv+Wf_nSt0GZj0WgPjpbk6Kr_WG-ueO6US9bUM@mail.gmail.com>	<201103221428.p2MESAkG018553@no.baka.org> <AANLkTinrvg=UkZJWCQt3hZXpAAgW=manhGPvk9s9KsCs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: in-gitvger@baka.org, Robert Pollak <robert.pollak@jku.at>,
	git <git@vger.kernel.org>, apenwarr@gmail.com
To: Daniel <daniel@netwalk.org>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:56:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q26l4-0006Fx-Ny
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263Ab1CVS4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 14:56:42 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33570 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab1CVS4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:56:40 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 7D4E318B37027;
	Tue, 22 Mar 2011 19:56:34 +0100 (CET)
Received: from [93.240.123.209] (helo=[192.168.178.43])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q26ks-0006eh-00; Tue, 22 Mar 2011 19:56:34 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTinrvg=UkZJWCQt3hZXpAAgW=manhGPvk9s9KsCs@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19CLobEGpdSWtw8FeRcF1062NSig6h72AlDs40u
	YCUKjUoSXrcD7XKL41mcIN9KUfibP2wABPg+lnSjIatAjUIdBH
	/nlZaaIWg6m+IYJStg0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169763>

Am 22.03.2011 15:55, schrieb Daniel:
> My current setup is that I'm simply versioning my home directory with
> mercurial. Some vim plugins are under git and since it's a different
> version control system I can check in the plugins easily. When I need
> to update those plugins, I just run git update, and check them into
> mercurial again. No problem, very easy.  I'm looking into what it
> would take to convert my repo to be completely git, and so far I have
> no exact way of dealing with those vim plugins since via submodules I
> have to rely on the external repos being present when I clone my
> homedir repo. Granted, if the repos have gone away a decade from now
> and my vim plugins are not present, it won't be the end of the world,
> but I want to see how close I can get to my current functionality when
> using git instead of mercurial.

You could add the .git directories of the vim plugin direcories that
are under git to the .gitignore in your home directory. Then you can
just continue to do what you are used to: Go into the vim plugin dir,
run git update there, go back into your home directory and commit the
new files and push everything to your remote. You'll lose the pointers
from the vim plugin directories to their origins that way, but that
doesn't seem to be a problem for you.
