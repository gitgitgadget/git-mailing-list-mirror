From: larsbj@gullik.org (Lars Gullik =?iso-8859-1?Q?Bj=F8nnes?=)
Subject: Re: Wrap commit messages on `git commit -m`
Date: Thu, 01 Nov 2012 17:29:56 +0100
Organization: LyX Developer http://www.lyx.org/
Message-ID: <m3a9v170ca.fsf@black.gullik.net>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 22:40:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU2VC-0003JC-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 22:40:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992569Ab2KAVkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 17:40:00 -0400
Received: from plane.gmane.org ([80.91.229.3]:40164 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762340Ab2KAVj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 17:39:58 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TU2Ue-0002dw-3q
	for git@vger.kernel.org; Thu, 01 Nov 2012 22:40:04 +0100
Received: from cm-84.209.196.8.getinternet.no ([84.209.196.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 22:40:04 +0100
Received: from larsbj by cm-84.209.196.8.getinternet.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 22:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cm-84.209.196.8.getinternet.no
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Cancel-Lock: sha1:RWDMaG2KWB3RKhRLFRscEkSWTn8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208890>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

| Hi,
>
| Some of my colleagues are lazy to fire up an editor and write proper
| commit messages- they often write one-liners using `git commit -m`.
| However, that line turns out to be longer than 72 characters, and the
| resulting `git log` output is ugly.  So, I was wondering if it would
| be a good idea to wrap these one-liners to 72 characters
| automatically.

git commit -m 'foo: fix this problem

This problem is fixed by doing foo,
bar and baz.

Signed-off-by: me
'

works.

-- 
	Lgb
