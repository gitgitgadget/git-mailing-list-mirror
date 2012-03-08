From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git push default behaviour?
Date: Thu, 8 Mar 2012 11:11:53 +0100
Message-ID: <87k42vs8pi.fsf@thomas.inf.ethz.ch>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 11:12:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aKI-00037a-CX
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab2CHKL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 05:11:57 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:54264 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880Ab2CHKL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 05:11:56 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:11:53 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 8 Mar
 2012 11:11:53 +0100
In-Reply-To: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	(Jeremy Morton's message of "Thu, 8 Mar 2012 10:01:46 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192548>

Jeremy Morton <jeremy@configit.com> writes:

> I've noticed that the default behaviour of 'git push' is to push to
> *all* branches that have a remote branch set up.
[...]
> Wouldn't it be better for git's default push behaviour (at least with
> the '--force' option) to be just to push to the current branch in the
> current repo?=C2=A0 To push to all branches you could have an
> '--allbranches' option.

See push.default in git-config(1).

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
