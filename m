From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 14:46:59 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603171444210.4690@virtualbox>
References: <56E9F5B3.6030903@fb.com> <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal> <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com> <CACsJy8A2D8CqeWZ6CFdTVXzXiWdonBE=3tWFPpe7-ZmDtNGYNw@mail.gmail.com> <alpine.DEB.2.20.1603171402330.4690@virtualbox>
 <CACsJy8DH297aV2pYL7xGNZ5X24rR5PxvrpJQ+15YxpDNvqgS5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:47:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agYGu-0002LA-3q
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936108AbcCQNrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:47:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:49801 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932983AbcCQNrR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:47:17 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MQdAP-1aFMkL3uJB-00U6ea; Thu, 17 Mar 2016 14:47:01
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACsJy8DH297aV2pYL7xGNZ5X24rR5PxvrpJQ+15YxpDNvqgS5Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:+vHqOGAbmLVnhDTGGdSz0VEC9cEIoCPSKWgvexprm4XHGdXGqmd
 9aq8J4bi0XMxkuSNqFGI1kVLl2AXTdbXsS63X6nUWfjkQUBN3Zrrmjamq0h95m3yVka2Cg8
 tPMTsiS3PkZIFJH0TAhRyXfvPogytXDu1BPOr+w4K7uGAUWqUcFlE3YJHxbHbTztT/gnUr5
 kMae2rN5fw/mmxaHAF8PA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xnZ3x3nOii8=:QeqXcP4YY1g3BAQb53iERh
 oMbrYWxui9fH0lDQ2qpdxGDoZd3dIlvt2KX7b5vyPwWx67NBn0exTEcEfbIaQ1mJNQWAwJBff
 A2EvCnwu+8pXC1S3NYrnWm6CAuBiRZm+1AOnjwiKEEVGLrdQbbBfCj7Uat/twZx/jgDsOXnUJ
 rUAs80YsTLfRigTKxTvRBWCkVD30YOTztKjzT+qATqWnJLA9YMe/92Xufcxtru1kJdoM6C5V5
 Ibtvxh5A2IqImxYMO7xYWLV5FueiX07hcRhFScp0mUljq5S5AFoI2Vf+qSm/PFw8b8LvkEtGl
 K10RiKw0Z5JMu7wtmkzxypZOvnoWuilxQPyYKe3xUgKwHOVv9jnukKjDf1z6q3Z1Dvq83sUVh
 iJEoVxEYLCk+LJED8xT9dOKWKKM0ucEwfO5TbDisPuxJs/QRUM481zVfP9+mkbdH63J2uxUnh
 vbjNfZZxx1dkFyedoGIGFPLeZopPBsRqJm/mvfVzU5PF4zsomE+Z14RFMR9yA1COH/74CGUgL
 ojJBdL9LbabQNjEKsd+6yVPrlgHj1RVLyM7izopRN75T1zG8t7f+rRL+wD67jDrXZI8mOz8c3
 vLgAUSdppJwRJIbvba/0GFoe9QkykxHABJ03YWF5cjvs2cSdOBcQemx3ThwcVcgwqZSlgvvwP
 7WQOnsfieBkrSB1JgMTX8hJFsrzYCno9UQ9kjHNnadFZrrdlgjrb8yk5tTibHCRgXZ37I7uV5
 QTXFlNKh8e9BihZEmgwRhlLvROnY8FLgAE4tGsbdtKAVJZ03Ke+8yZJ+l0K9JRDpFkxmKXsI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289115>

Hi Duy,

On Thu, 17 Mar 2016, Duy Nguyen wrote:

> On Thu, Mar 17, 2016 at 8:04 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Thu, 17 Mar 2016, Duy Nguyen wrote:
> >
> >> Good news for you is there's "sparse checkout v2" in the work, that
> >> would not rely on exclude engine and should be both faster and more
> >> elegant. That should reduce "sparse checkout v1" usage to really
> >> small cases.
> >
> > I dabbled myself with speeding up the entire exclude engine
> > (essentially, I use a hash map of the non-wildcard prefixes to the
> > corresponding line number). So I am interested to see what your
> > approach is. Could you point me to it (I did not see any obvious
> > branch in your GitHub space)?
> 
> First of all it's not about speeding up exclude engine. I think I did
> that (sort of) already with untracked cache (have you tried it on
> Windows?)

Yes, I tested the untracked cache and enabled it in a couple of my
repositories. It works great. But it has little to do with the exclude
engine ;-)

> It's Junio's idea actually, what I'm implementing. The index contains
> a list of _files_ yes?
> What if the index contains also _directories_? Of course we can't
> "refresh" or check if the whole directory is "dirty" like a file, so
> those dirs will stay registered in the index, but be entirely missing
> from worktree. The effect is the same as sparse checkout, except that
> we keep all "hidden" files of sparse checkout in the index. In fact I
> plan to reuse CE_SKIP_WORKTREE (from sparse checkout) to mark those
> dirs.

Oh, I see.

Unfortunately, this does not help me at all. In the use case I am trying
to get to work fast, we have tons and tons of directories and need *one*
file in pretty much *all* of those directories, and exclude most of the
other files.

To make matters even worse, the list of excluded (or included) files is
constantly changing.

> The advantage is obvious: the index can be much smaller, which leads
> to faster update and access. Of course now you can only hide either
> whole directory, or hide nothing. It's less flexible than sparse
> checkout "v1", but you can use "v1" on top of "v2" for that. Changing
> checkout regions involves unfolding or folding certain directories,
> sparse patterns are not used.
> 
> If you are still curious, you can check out my 'narrow-checkout'
> branch on github. The basic is working. Folding/unfolding is not. Be
> warned that it's even dirtier than your rebase-helper branch (and will
> not be released any time soon either, lots of other stuff to be
> finished first).

Thanks!
Dscho
