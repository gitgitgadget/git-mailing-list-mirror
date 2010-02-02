From: Petr Baudis <pasky@suse.cz>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Tue, 2 Feb 2010 01:15:30 +0100
Message-ID: <20100202001530.GL9553@machine.or.cz>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
 <87aavsu9b3.fsf@osv.gnss.ru>
 <ron1-6F8B85.14520801022010@news.gmane.org>
 <7vwrywplxz.fsf@alter.siamese.dyndns.org>
 <ron1-ABA66E.15563101022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 01:15:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc6Qf-0002ZG-7H
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 01:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab0BBAPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 19:15:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56376 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919Ab0BBAPe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 19:15:34 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 10FDD86202A; Tue,  2 Feb 2010 01:15:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ron1-ABA66E.15563101022010@news.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138662>

On Mon, Feb 01, 2010 at 03:56:31PM -0800, Ron Garret wrote:
> In article <7vwrywplxz.fsf@alter.siamese.dyndns.org>,
>  Junio C Hamano <gitster@pobox.com> wrote:
> > Ron Garret <ron1@flownet.com> writes:
> > > And as long as I'm weighing in, it would also help to prevent confusion 
> > > if it were made clear that this unnamed branch doesn't actually come 
> > > into existence unless and until you do a commit.
> > 
> > This shows that you are still thinking a branch is a line (or multiple
> > lines).  It is not.
> 
> The git user's guide says it is:
> 
> "When we need to be precise, we will use the word "branch" to mean a 
> line of development..."
> 
> But I understand that a branch is not necessarily a line.  In general 
> it's a DAG.  I get that.

Again, no. In the most narrow sense, "branch == branch head". Branch is
just a pointer. Which is the reason why your original statement does not
make sense.

We could say that the "branch closure" is the DAG of ancestry of the
commit we point to. We use "branch" in that sense since we have to
express ourselves in natural language, we are not in a calculus class,
there is mapping to various real-world and other-VCS concepts in play,
etc. But in order to use "branch" in the ambiguous sense, you should
first realize what it means in the _strict_ sense, so that you
understand the texts correctly and don't reach wrong conclusions or
create invalid concepts like "branches coming into existence". :-)

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
