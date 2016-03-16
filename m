From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 12/17] rebase-todo: introduce rebase_todo_item
Date: Wed, 16 Mar 2016 16:55:01 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603161647560.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-13-git-send-email-pyokagan@gmail.com> <CAP8UFD0Fw1ZOQzPfF=bbEsCOhkoHfV5B5ayprxR6kWr6vApT5Q@mail.gmail.com>
 <CACRoPnRH1D=8k5uuUahh1MJOAXsWkhY0fWev2AQhJm5+WWk5rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Christian Couder <christian.couder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 16:55:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agDnD-0007DD-9l
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 16:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090AbcCPPzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 11:55:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:61947 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbcCPPzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 11:55:22 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lm34j-1a6bqx1zu5-00Zd9M; Wed, 16 Mar 2016 16:55:02
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CACRoPnRH1D=8k5uuUahh1MJOAXsWkhY0fWev2AQhJm5+WWk5rQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:HjjQmNdOCX4as1YdRpcSUS0rGr2vtOjIO+KALf37sWBQW9jnzVo
 XwKq8AZ9JPCZAy/uF3iqT5AxBxCYIDi0tZeN+x+FMK2mr9+lqw07SU1D5qvBBMBAK0CWv7R
 dS3q83mYWKFtQFQa1JkKVs3ICalVT8PgjTg/KVNy51+XJHnIYiwvFlV0p9PyIeqTCp/20vL
 QWmNoEOkClF3lML62GaJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YSIIYh9U/Q4=:EjaqJJMksEyrnYsW2gwZMI
 +ZV1zO7OHxaz3lQpiD1/oCrkCajkpqbGmVPjB8P2V2CMzMgfEztZJ2yRZpIWilhf39yfQVSdB
 EVN5xO84I83RrgihIovqKTxtg1EzKkXYNn5bsuBoVmAJH6S1nv31/mk8FQCrVhPjli4kcUfmf
 uc1vAZCh3fdfCLw4GU6hBUqjn9ujdZ44/SsflMbzEWjAF+pisLYRERJOt2gd/hxa7o2LNa5kT
 ReF1/qoFPkGwK6MGPB9F2Yuo7sh7szFRyXbIhj+iu8+UNdB0CQjBUIrBGGd3ppoBdTf2GAXoA
 eavzAsTLV3WwF0fPEAZBtfWXyO8DgECL/LA1ObPWk8j64FUFlrpgctqWEjlS+P6SLRR6s1lnz
 egGtJPGLh+tL9KB2VDvk7d2/2ocLanlUJ8iib9EpNI1rqlQ2xlrEXhTHiv0uNhR7a0f04rfW+
 lx/Ar65q220PNQG7xnBocT9dF3c9PAl4rt65UDtyx4iH81YG5SOwNOHZ5z9sYi4pxSyOKiS9v
 V8fm3pgrH9FnrcL0tjeaIm635QqfIaCxiUA5/x86cZNfNQoFSIFAMtmi9/Xm+OZYSR05sGeeo
 SpuxCLB8prmjqDELzwI6S7SfyBlysxRoTL31VUW9tTHxFk1+H3CFxrBj1cF8DfNrJ9u2Nvp8p
 WYaFRtN8VEsCmo4k/T/YRT6RpJC6TRHBZ+y07wYUMNbBVcbXDJoAUXzq2edGvHBh0KwLbwRFF
 xNKmUGEeu7kKwT0UpAh+xuqyKxzTEmqws/ojXIgVMBsW4WAHEeJPb2mnWWgjEVFwH5PDNLxE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288982>

Hi Paul,

On Wed, 16 Mar 2016, Paul Tan wrote:

> On Mon, Mar 14, 2016 at 9:43 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
> > On Sat, Mar 12, 2016 at 11:46 AM, Paul Tan <pyokagan@gmail.com> wrote:
> >> In an interactive rebase, commands are read and executed from a todo
> >> list (.git/rebase-merge/git-rebase-todo) to perform the rebase.
> >>
> >> In the upcoming re-implementation of git-rebase -i in C, it is useful
> >> to be able to parse each command into a data structure which can then
> >> be operated on. Implement rebase_todo_item for this.
> >
> > sequencer.{c,h} already has some code to parse and create todo lists
> > for cherry-picking or reverting multiple commits, so I am wondering if
> > it would be possible to share some code?
> 
> AFAIK, sequencer.c as it is in master parses the todo list
> destructively and does not keep the associated action for each commit
> and the "rest" string.

This is a *serious* mistake in the implementation of the sequencer, I
agree.

Therefore it is a good idea to fix that mistake instead of leaving it in
place.

And that is exactly what I did:

	https://github.com/dscho/git/commit/b9b5b7351

Please note that the commit is marked as a "TODO" because it has to
reintroduce a stupidly strict behavior (the sequencer expects the commands
in the todo script to agree with the overall action, i.e. if the action is
REPLAY_REVERT, the todo script can only contain "revert" commands, if the
action is REPLAY_PICK, the todo list can only contain "pick" commands). Of
course this restriction is totally arbitrary and even unwanted, so I will
lift it after this commit. Or maybe I'll just lift it before this commit.
Yeah, I'll do that instead.

> As I said in another thread, originally I wanted to keep the scope
> simple, and just do the rewrite of rebase from C to shell, and let any
> further libifications and optimizations come after, so I didn't want
> to touch sequencer for now.

We know, however, how leaving technical debt for later will just make sure
that technical debt accumulates...

And while I have a *tremendous* respect for what Karthik did (and
continues to do, even long after his GSoC project ended!), I do not want
to ask any future GSoC student to clean up the mess that we produce right
now... So let's just not add more technical debt than we absolutely have
to.

Ciao,
Dscho
