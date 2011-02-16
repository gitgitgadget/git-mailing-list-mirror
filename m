From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Corrupted git repository?
Date: Wed, 16 Feb 2011 19:54:26 +0100
Message-ID: <201102161954.26766.j6t@kdbg.org>
References: <AANLkTimMon7ztbyT26YhotiZ=jd=QpNTvOkPCKwHg+e_@mail.gmail.com> <7vk4h1nk3x.fsf@alter.siamese.dyndns.org> <AANLkTimZgpWUAncLgO=y5CvKsYGdYWTHNUzncjrC5UO6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 19:54:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpmWK-0008Sh-GH
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 19:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab1BPSyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 13:54:32 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:22722 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750857Ab1BPSya (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 13:54:30 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2A969A7EB5;
	Wed, 16 Feb 2011 19:54:25 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id ED25819F5AA;
	Wed, 16 Feb 2011 19:54:26 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTimZgpWUAncLgO=y5CvKsYGdYWTHNUzncjrC5UO6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166986>

On Mittwoch, 16. Februar 2011, Piotr Krukowiecki wrote:
> I have deleted the whole top-level directory in which the file was and run:
>
> $ git status | grep  <<PATH>>
> #	deleted:    <<PATH>>
>
> $ git checkout -- <<top dir>>
>
> $ git status
> # On branch master
> nothing to commit (working directory clean)
>
> $ git cherry-pick 7d193bb0c1f14908361d9d9d5e30f0c12d5f2c2f
> error: Your local changes to the following files would be overwritten by
> merge: <<PATH>>
> Please, commit your changes or stash them before you can merge.
> Aborting

A wild guess: You are on Windows or OS/X, and the file exists in your worktree 
with different uppercase/lowercase name? Rename the file so that its case is 
the same as it is recorded in the repository.

-- Hannes
