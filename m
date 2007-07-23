From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What is a reasonable mixed workflow for git/git-cvsserver?
Date: Mon, 23 Jul 2007 13:34:56 +0200
Message-ID: <AD8AD244-0B20-44E9-AEE6-9D2A75BC5091@zib.de>
References: <E8B0B250-A428-4CDC-A4D2-FFCF45953076@zib.de> <46a038f90707230359u5fac77a4i7b6a350d3bb29e3b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 13:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICwBi-0007Qw-ID
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 13:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761104AbXGWLeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 07:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760842AbXGWLeu
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 07:34:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:56402 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758935AbXGWLet (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 07:34:49 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6NBXxD1003905;
	Mon, 23 Jul 2007 13:34:46 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6NBXxYU018660
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 23 Jul 2007 13:33:59 +0200 (MEST)
In-Reply-To: <46a038f90707230359u5fac77a4i7b6a350d3bb29e3b@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53430>


On Jul 23, 2007, at 12:59 PM, Martin Langhoff wrote:

>> What is a reasonable way to handle the unsorted commits
>> from a shared branch in a more git-ish way? I googled a bit
>> but didn't find a good explanation on the web.
>
> I am not sure what you mean by unsorted commits... "proposed patches"?
> The git project itself has a proposed-updates branch that might serve
> as an example. And repo.or.cz has the strange concept of the mob
> branch that you might want to have a look at.

The mob branch seems to be related, although I do not plan for
an anonymous mob but only for the cvs mob ...

If several people commit to the same shared branch exported by
git-cvsserver they most likely will generate a series of unsorted
commits, as they did in the past on a single cvs branch. The
commits will probably deal with various topics, include bug fixes,
and some are likely more experimental and not really ready for a
stable branch.

My question is how to deal with this shared branch on the git
side. Should a core developer rebuild a sane history from such
a shared/mixed/unsorted branch by cherry picking the commits
to one or more topic branches? If one did so, how could one
bring the git-ish history back to the people connected by cvs?
Am I allowed to reset branches exported by git-cvsserver?
Probably not?

	Steffen
