From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [git-svn PATCH] Add --no-rebase option to git-svn dcommit
Date: Fri, 04 May 2007 11:08:07 +0200
Message-ID: <87slad553c.fsf@morpheus.local>
References: <20070503054749.20115.53805.stgit@yoghurt> <20070504075908.GB17526@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 13:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjvcH-0007JH-5G
	for gcvg-git@gmane.org; Fri, 04 May 2007 13:06:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767905AbXEDLGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 4 May 2007 07:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767898AbXEDLGV
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 07:06:21 -0400
Received: from main.gmane.org ([80.91.229.2]:58376 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767903AbXEDLGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 07:06:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hjvc9-0001VN-FE
	for git@vger.kernel.org; Fri, 04 May 2007 13:06:17 +0200
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 13:06:17 +0200
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 04 May 2007 13:06:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:weSAeWgQlpNItTu32MjV0MMGGco=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46165>

Eric Wong <normalperson@yhbt.net> writes:

> Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
>> git-svn dcommit exports commits to Subversion, then imports them bac=
k
>> to git again, and last but not least rebases or resets HEAD to the
>> last of the new commits. I guess this rebasing is convenient when
>> using just git, but when the commits to be exported are managed by
>> StGIT, it's really annoying. So add an option to disable this
>> behavior. And document it, too!
>
> Cool, I've been planning to add this myself, too.

One thing I haven't figured out, although I haven't looked at the code
much, is this:  When does git-svn do a merge rather than a rebase?
How can there ever be a diff?  Is this perhaps something that can
happen if you use set-tree, because I don't see how it happens with
dcommit.

--=20
David K=C3=A5gedal
