From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad
 file descriptor
Date: Mon, 23 Mar 2015 19:36:34 +0000
Message-ID: <20150323193634.GA3454@dcvr.yhbt.net>
References: <CAK6Z60ciheWOUGOv1sYcA==B2WR1Rs_eMU+9a=R3FBwc_37CyQ@mail.gmail.com>
 <CAK6Z60fhyY3wPG6hx7YJ4y7wZsWb=33JhqejmpVBgZLGdB1XMA@mail.gmail.com>
 <cbcb926c1b7edd31548a15ea4966a35@74d39fa044aa309eaea14b9f57fe79c>
 <20150226212721.GA2930@dcvr.yhbt.net>
 <xmqqa8z3a5rm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>, Mike <ipso@snappymail.ca>,
	Minty <mintywalker@gmail.com>,
	Nico =?utf-8?B?U2NobMO2bWVy?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:37:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya89Y-0003Zb-4K
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 20:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249AbbCWTgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 15:36:43 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50140 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460AbbCWTgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 15:36:43 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id E90311F5CD;
	Mon, 23 Mar 2015 19:36:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqa8z3a5rm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266159>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > "Kyle J. McKay" <mackyle@gmail.com> wrote:
> >> The updated patch with the additional fix is below.
> >
> > Thanks, signed-off and pushed to master on git://bogomips.org/git-svn
> > I've dropped my "destroy all tempfiles..." patch.
> 
> I think I missed this exchange.  I see these two patches:
> 
>     e0b4cad Git::SVN::*: avoid premature FileHandle closure
>     ce1b57b git-svn: fix localtime=true on non-glibc environments
> 
> on the 'master' branch of your git://git.bogomips.org/git-svn.git/
> repository.  Is this a good time to pull from you, and should I
> expect more during this cycle (I am guessing that the answers would
> be yes and no, but just to make sure...)?

Correct, it's a good time to pull and I don't expect to have more time
to work on new features (lazy load) for a bit.  I was under the
impression you already pulled:

http://mid.gmane.org/xmqq61aol44q.fsf@gitster.dls.corp.google.com
