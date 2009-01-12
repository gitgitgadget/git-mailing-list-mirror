From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Removing a commit from a local branch
Date: Mon, 12 Jan 2009 01:20:26 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngml6mq.d1r.sitaramc@sitaramc.homelinux.net>
References: <a038bef50901111441w21959397tc41922656a25027c@mail.gmail.com>
 <a038bef50901111442y16695664y4fed7cdd9d8af27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 02:22:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMBVe-0004rF-9C
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 02:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZALBUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 20:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbZALBUl
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 20:20:41 -0500
Received: from main.gmane.org ([80.91.229.2]:59820 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315AbZALBUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 20:20:40 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LMBTs-0008Fr-3U
	for git@vger.kernel.org; Mon, 12 Jan 2009 01:20:40 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:20:40 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 01:20:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105265>

On 2009-01-11, Chris Packham <judge.packham@gmail.com> wrote:
> Consider the following example. The maintainer has the
> following branch locally
>
>   todeliver: A-B-C-D
>
> He is happy with commits A, C and D but wants to reject B. Ideally I
> want to be able to say
>   git rebase --onto <parent of B> <child of B> todelvier
>
> and get
>   todeliver: A-C'-D'

you have an off-by-one error here.  You need B, not child of
B.  Problem solved :-)
