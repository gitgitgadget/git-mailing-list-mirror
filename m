From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: how to combine 2 commits?
Date: Tue, 13 Jan 2009 11:32:49 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmouv1.9mk.sitaramc@sitaramc.homelinux.net>
References: <20090113045422.GA6940@b2j>
 <slrngmodgv.ple.sitaramc@sitaramc.homelinux.net>
 <vpqiqojpuqn.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 12:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMhXU-0005wJ-4Z
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 12:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbZAMLdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 06:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754294AbZAMLdG
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 06:33:06 -0500
Received: from main.gmane.org ([80.91.229.2]:47909 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbZAMLdF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 06:33:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMhVx-0007fy-5n
	for git@vger.kernel.org; Tue, 13 Jan 2009 11:32:57 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 11:32:57 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 11:32:57 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105488>

On 2009-01-13, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> I like using "git rebase -i HEAD~5" (if I want to rebase the
>> last 5 commits).  In the editor that pops up, I reorder the
>> ones that I know should be together, and on each set to be
>> squashed, I change the "pick" to "s" (for squash) on all but
>> the first one.  Save the file and it's all done.
>
> And right after, you probably want to do stg like
>
>   git diff master@{1} master
>
> to see whether you actually changed the result by reordering your
> patches.

I used to do that, but now I've stopped.  If it doesn't
conflict, I know it's good.  I go straight to the equivalent
of make && make test.

I must mention though, that I don't reorder the relative
sequences of commits affecting the same file/set of files.
That might have something to do with my confidence :-)
