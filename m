From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Our cumbersome mailing list workflow
Date: Thu, 27 Nov 2014 22:53:34 +0000
Message-ID: <20141127225334.GA29203@dcvr.yhbt.net>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>
 <1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>
 <546F4B5B.2060508@alum.mit.edu>
 <xmqq61e81ljq.fsf@gitster.dls.corp.google.com>
 <5473CD28.5020405@alum.mit.edu>
 <54776367.1010104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 27 23:53:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xu7wQ-0007l4-MD
	for gcvg-git-2@plane.gmane.org; Thu, 27 Nov 2014 23:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbaK0Wxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Nov 2014 17:53:34 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36722 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750756AbaK0Wxe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2014 17:53:34 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0A71FA80;
	Thu, 27 Nov 2014 22:53:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <54776367.1010104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260355>

Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
> On 2014-11-25 01.28, Michael Haggerty wrote:
> >   * Or I save the emails to a temporary directory (awkward because,=
 Oh
> > Horror, I use Thunderbird and not mutt as email client), hope that =
I've
> > guessed the right place to apply them, run "git am", and later try =
to
> > remember to clean up the temporary directory.
>=20
> Is there a "mutt howto" somewhere?

Not that I'm aware of, but Documentation/email-clients.txt in
the Linux kernel has some short notes...

My muttrc has had the following since my early days as a git user:

  macro index A ":unset pipe_decode\n|git am -3\n:set pipe_decode\n"
  macro pager A ":unset pipe_decode\n|git am -3\n:set pipe_decode\n"

(Hit Shift-A while viewing/selecting a message to apply a patch,
 it requires you run mutt in your project working directory, though).

Perhaps there can be a similar document or reference to it in our
Documentation/

> In short:
> We can ask every contributor, if the patch send to the mailing list
> is available on a public Git-repo, and what the branch name is,
> like _V2.. Does this makes sense ?

Not unreasonable.  I hope that won't give folks an excuse to refuse
to mail patches, though.  Some folks read email offline and can't
fetch repos until they're online again.

> I like Gerrit as well.
> But it is less efficient to use, a WEB browser is slower (often), and
> you need to use the mouse...

IMNSHO, development of non-graphical software should never depend on
graphical software.  Also, I guess there is no way to comment on Gerrit
via email (without registration/logins?).

Lately, I've been trying to think of ways to make collaboration less
centralized.  Moving to more centralized collaboration tools is a step
back for decentralized VCS.

> But there is another thing:
> Once a patch is send out, I would ask the sender to wait and collect =
comments
> at least 24 hours before sending a V2.
> We all living in different time zones, so please let the world spin o=
nce.
>=20
> My feeling is that a patch > 5 commits should have
> a waiting time > 5 days, otherwise I start reviewing V1, then V2 come=
s,
> then V3 before I am finished with V1. That is not ideal.
>=20
> What does it cost to push your branch to a public repo and
> include that information in the email ?
>=20
> And how feasable/nice/useful is it to ask contributers for a wait
> time between re-rolling ?

All that sounds good.
