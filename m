From: David Kastrup <dak@gnu.org>
Subject: Re: Usability of git stash
Date: Thu, 16 Oct 2008 13:24:30 +0200
Message-ID: <86vdvsg4up.fsf@lola.quinscape.zz>
References: <87wsg9acfv.fsf@cup.kalibalik.dk>
	<nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 13:25:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqQzI-0003ar-P2
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 13:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbYJPLYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 07:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754191AbYJPLYl
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 07:24:41 -0400
Received: from main.gmane.org ([80.91.229.2]:54755 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbYJPLYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 07:24:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KqQy6-0007Mp-Mu
	for git@vger.kernel.org; Thu, 16 Oct 2008 11:24:38 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 11:24:38 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 11:24:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:Q9rBvhwUN3palpu4Dr09fzzsplM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98367>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Anders Melchiorsen wrote:
>
>> When trying to recover from that scenario, I do "git stash apply" as
>> recommended by the "git stash" output. Now I still lost my index
>> state, all changes are unstaged.
>
> See the documentation, apply has a '--index' option.

Still, the shoot-yourself-in-the-foot potential is quite larger than
appropriate for what is mostly workflow porcelaine.  It is even larger
than appropriate for plumbing IMHO.

I mean, even misspellings like
git stash lisp

cause action that is not easily reversible, and the given help output is
misleading with regard to index state.

-- 
David Kastrup
