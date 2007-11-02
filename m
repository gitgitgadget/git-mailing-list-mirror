From: Remi Vanicat <vanicat@debian.org>
Subject: Re: git rm --cached
Date: Fri, 02 Nov 2007 17:13:32 +0100
Organization: none
Message-ID: <87mytwiq1f.dlv@vanicat.homelinux.org>
References: <20071102021711.GA28703@fawkes.hq.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 20:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io24G-0000Lt-1R
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 20:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755633AbXKBTUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Nov 2007 15:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755027AbXKBTUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 15:20:16 -0400
Received: from main.gmane.org ([80.91.229.2]:54876 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755633AbXKBTUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 15:20:15 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Io23m-0007Ks-H5
	for git@vger.kernel.org; Fri, 02 Nov 2007 19:20:02 +0000
Received: from 77.193.75.123 ([77.193.75.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 19:20:02 +0000
Received: from vanicat by 77.193.75.123 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 19:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 77.193.75.123
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:11fiYwp3U55iN58DbGy9FCFntbA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63159>

Jing Xue <jingxue@digizenstudio.com> writes:

> In the following scenario, why do I have to run 'git reset' following
> 'git rm --cached 1.txt' to revert to exactly where I was before 'git =
add
> 1.txt'?  Shouldn't 'git rm --cached' have done that already?

Observed behavior are exactly what I expected: 'git rm --cached' mark
the file in the index as been deleted without deleting it in the
working directories, it did not but the index it was before the=20
'git add 1.txt'.

You probably want to use git reset HEAD -- 1.txt to unstage
modification on 1.txt

--=20
R=C3=A9mi Vanicat
