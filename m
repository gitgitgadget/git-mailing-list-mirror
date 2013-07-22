From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 5/6] blame-options.txt: place each -L option variation on its own line
Date: Mon, 22 Jul 2013 12:38:49 +0200
Message-ID: <87txjr4tzx.fsf@linux-k42r.v.cablecom.net>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
	<1374096332-7891-6-git-send-email-sunshine@sunshineco.com>
	<87hafs84jc.fsf@linux-k42r.v.cablecom.net>
	<7vvc473gfe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <tr@thomasrast.ch>,
	Eric Sunshine <sunshine@sunshineco.com>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 12:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1DW6-000090-6U
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 12:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252Ab3GVKiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 06:38:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:34675 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab3GVKix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 06:38:53 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 22 Jul
 2013 12:38:49 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (217.235.60.35) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 22 Jul 2013 12:38:49 +0200
In-Reply-To: <7vvc473gfe.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 18 Jul 2013 10:51:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [217.235.60.35]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230971>

Junio C Hamano <gitster@pobox.com> writes:

> Also I wonder if this one Documentation/git-log.txt:156
>
>     git log -L '/int main/',/^}/:main.c
>
> should be more like one of these:
>
>     git log -L '/int main/,/^}/':main.c
>     git log -L '/int main/,/^}/:main.c'
>
> I find it somewhat hard to spot the closing sq in the middle of a
> string.

There's a distinct advantage to keeping the sq before the colon, at
least in my config (and I think I haven't changed the defaults as far as
this goes): bash will try to complete a filename if you type

  git log -L '...':mai<TAB>

but not if you instead do

  git log -L '...:'mai<TAB>


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
