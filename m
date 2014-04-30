From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/12] MINGW: fix main() signature in http-fetch.c and
 remote-curl.c
Date: Wed, 30 Apr 2014 14:31:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404301424590.14982@s15462909.onlinehome-server.info>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org> <1398762726-22825-9-git-send-email-marat@slonopotamus.org> <5360B5EC.1070907@gmail.com> <CABPQNSbSipaCAgJV0LimP-J1-WOXHQU5w9qOoBq-ccRYQFrAxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>,
	GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 14:31:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfTff-0006zs-J5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 14:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbaD3Mb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 08:31:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:58865 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933556AbaD3MbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 08:31:25 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Maa3B-1WQH8828Xx-00K71N;
 Wed, 30 Apr 2014 14:31:01 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSbSipaCAgJV0LimP-J1-WOXHQU5w9qOoBq-ccRYQFrAxw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:As6d/Mdv5SxMzvzYi0looLCKevv1692vey8v55w+4T4EG++lJ+F
 JSpHgqGdM5DvHb44ebpETc8dPiOwRQ9ALSbqUelz8CGl1iiy4ociXvKHClWx2Cmc8psanT1
 3pzW8U8Muh7jysXmry1LOzbfRss7bB0cFXC1JxvQybJG3srjzH9G2SfGeqQwzteJhBN310X
 W8FSB1MC0A/Obr06yAYfQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247709>

Hi kusma,

On Wed, 30 Apr 2014, Erik Faye-Lund wrote:

> While it's certainly a good point, I think this is *our* fault for not
> upstreaming our changes, and the responsibility of cleaning up merges
> should lie on our shoulders. We've diverged a lot. Sure, Dscho does a
> great job making the divergence less painful, but IMO we should try to
> reduce the delta as well.

Just for historical context: we *did* try to get our changes upstream. In
fact, that was in large part everything Steffen Prohaska did while he was
maintaining Git for Windows. The going has been tough, though, to the
point that we were losing contributors who were not *quite* willing to put
up with such a detailed vetting process as the Git mailing list requires.

I have to admit that it is really, really hard even for someone like me,
who is used to the ways of the Git mailing list, because just a simple
thing like this curl-config issue already eats up several days of my Git
time budget.

So while I am sympathetic to the point of view that the Git for Windows
project failed to upstream its changes, I am *equally* sympathetic to the
point of view that it is an undue burden to have to go through the process
of getting patches included by upstream Git. I, for one, simply ain't got
the time, man.

Ciao,
Johannes
