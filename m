From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: clone branching?
Date: Tue, 12 Aug 2008 09:34:35 +0200
Message-ID: <20080812073435.GA30811@diana.vm.bytemark.co.uk>
References: <4b6f054f0808111124g58309f64v496ceb250a068985@mail.gmail.com> <20080811203917.GA20662@diana.vm.bytemark.co.uk> <4b6f054f0808111324x5a7c44afj6f93bc1e36fc481a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Trans <transfire@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 09:13:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSo4S-0007jR-UK
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 09:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbYHLHM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 03:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYHLHM2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 03:12:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1923 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbYHLHM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 03:12:28 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KSoOp-00086N-00; Tue, 12 Aug 2008 08:34:35 +0100
Content-Disposition: inline
In-Reply-To: <4b6f054f0808111324x5a7c44afj6f93bc1e36fc481a@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92075>

On 2008-08-11 16:24:57 -0400, Trans wrote:

> On Mon, Aug 11, 2008 at 4:39 PM, Karl Hasselstr=F6m <kha@treskal.com>
> wrote:
>
> > git supports multiple branches per repository/working copy, but
> > doesn't force you to have more than one. And it's very easy to
> > pull changes from one repo to another.
>
> In retrospect, It's more the tags I need rather then branches, but
> just the same... So if I have a repository like:
>
>   myapp/
>     1.0.0/
>     1.0.1/
>     1.1.0/
>     current/
>
> This would be okay? No other "giter" is going to look at this and
> think "what the hell?"

That would be OK. But "myapp" wouldn't be a repository -- it'd be a
directory that contains four repositories. Each of those repositories
would have a specific branch checked out, but they'd probably all
contain the full set of tags and branches.

> Hmm... actually I don't see how this can work. If .get is under
> current/ than no one will be able to see the tags on my shared repo,
> but if it is under myapp/ then I'd be branching and tagging my tags
> --that's doesn't make any sense. I'm confused.

All your repositories have a .git directory. That's what makes them
git reppositories.

I think what you need to do to get un-confused is to learn about how
git stores history. Specifically, that

  1. the history consists of a DAG of commits, and

  2. that branches and tags are just named pointers to commits.

http://eagain.net/articles/git-for-computer-scientists/ is a short and
sweet introduction.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
