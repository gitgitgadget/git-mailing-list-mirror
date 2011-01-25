From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git filter-branch can "forget" directories on case insensitive filesystems
Date: Tue, 25 Jan 2011 22:56:03 +0100
Message-ID: <201101252256.03644.j6t@kdbg.org>
References: <AANLkTimOs9m==KaD3BNHcgkTTqNQF1yV0NLA_Ew+iS-N@mail.gmail.com> <4D3F38E9.9060902@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: smaxein@googlemail.com
X-From: git-owner@vger.kernel.org Tue Jan 25 22:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phqs1-0003Hp-Gg
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 22:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680Ab1AYV4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 16:56:07 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:21930 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752255Ab1AYV4G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 16:56:06 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 819D8A7EBE;
	Tue, 25 Jan 2011 22:55:45 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id B9DFA19F5F2;
	Tue, 25 Jan 2011 22:56:03 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4D3F38E9.9060902@googlemail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165485>

On Dienstag, 25. Januar 2011, Simeon Maxein wrote:
> In my opinion this is a quite serious issue, because files are lost
> without any indication to the user. As of git 1.7.3.1 (tested on
> Windows/NTFS with msysGit this time), the problem still exists. Please
> give it a look. Fullquote of the problem description / steps to
> reproduce follows.

> > mkdir testdir
> > echo 'abc' >testdir/testfile
> > git add testdir
> > git commit -m foo
> > git rm -r testdir
> > mkdir testDir
> > echo 'abc' >testDir/testfile
> > git add testDir
> > git commit -m bar

Please retry with current release condidate of 1.7.4; it has some 
core.ignorecase improvements w.r.t. directories. It could well be that your 
problem is fixed.

-- Hannes
