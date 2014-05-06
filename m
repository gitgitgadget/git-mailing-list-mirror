From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Tue, 06 May 2014 20:00:22 +0200
Message-ID: <87mweuss7d.fsf@fencepost.gnu.org>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140505184441.GS9218@google.com>
	<110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
	<xmqqppjqg6an.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	d9ba@mailtor.net, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whjfh-0007TI-4U
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 20:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbaEFSAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 14:00:49 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:39693 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaEFSAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 14:00:48 -0400
Received: from localhost ([127.0.0.1]:38731 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Whjfa-0002Xt-Up; Tue, 06 May 2014 14:00:47 -0400
Received: by lola (Postfix, from userid 1000)
	id 18FEBE075E; Tue,  6 May 2014 20:00:22 +0200 (CEST)
In-Reply-To: <xmqqppjqg6an.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 06 May 2014 10:34:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248227>

Junio C Hamano <gitster@pobox.com> writes:

> I still find the output from "git blame" disturbing, though.  The
> first thing I do in "git blame" output is to scroll to the right in
> order to identify the the area I am interested in, and this first
> step is not negatively affected, because the right scrolled output 
> automatically wraps long lines.
>
> But my second step is to scroll back to the left edge to find the
> commit object name and at that point, the new default output without
> "S" gets somewhat annoying, because most of the output lines from
> "git blame" are longer than my window width.

git blame sucks in anything but fullscreen either way.  It would help to
display _only_ the source code and have the other info as mouse-over,
but that's not something a pager can do.

It is a pity that the content can be columnized much worse than the
metadata: otherwise it would make much more sense to display the content
_first_ in line.  The metadata is useless without the content anyway.

-- 
David Kastrup
