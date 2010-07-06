From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: help moving boost.org to git
Date: Tue, 06 Jul 2010 20:36:24 +0530
Message-ID: <878w5o7iq7.fsf@hariville.hurrynot.org>
References: <4C31E944.30801@boostpro.com> <4C31F0D4.1040207@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 20:41:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWD4w-0005M2-PO
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 20:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab0GFSkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 14:40:24 -0400
Received: from lo.gmane.org ([80.91.229.12]:48787 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab0GFSiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 14:38:51 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OWD2g-0003uv-G6
	for git@vger.kernel.org; Tue, 06 Jul 2010 20:38:50 +0200
Received: from 117.192.143.200 ([117.192.143.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 20:38:50 +0200
Received: from harinath by 117.192.143.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 20:38:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 117.192.143.200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:x3wPrMw7fUIbEJjQpIUUMnGJOJA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150386>

Hi,

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 7/5/2010 16:16, schrieb Eric Niebler:
>> I have a question about the best approach to take for refactoring a
>> large svn project into git. The project, boost.org, is a collection of
>> C++ libraries (>100) that are mostly independent. (There may be
>> cross-library dependencies, but we plan to handle that at a higher
>> level.) After the move to git, we'd like each library to be in its own
>> git repository.
>
> You could use svn2git: http://gitorious.org/svn2git
> KDE uses it to split its SVN repository into pieces. The tool is driven by
> a "ruleset" that specifies SVN subdirectories and revision numbers that
> make up a module.

I'm also involved in moving a large SVN project to git (the mono
project).  I have found and fixed several issues with svn2git

  git://gitorious.org/~harinath/svn2git/rrh-svn2git.git

- Hari
