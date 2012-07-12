From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Thu, 12 Jul 2012 17:41:44 +0900
Message-ID: <874npds75j.fsf@catnip.gol.com>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	<1341939181-8962-2-git-send-email-cmn@elego.de>
	<20120710191354.GE8439@burratino>
	<7v1ukjiehe.fsf@alter.siamese.dyndns.org>
	<20120710201105.GH8439@burratino>
	<7vsjczgx3h.fsf@alter.siamese.dyndns.org>
	<20120710210901.GI8439@burratino>
	<7vehojgqgk.fsf@alter.siamese.dyndns.org>
	<20120710234717.GA21467@burratino>
	<7vzk77f602.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 10:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpF8P-0004gV-DN
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 10:52:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758342Ab2GLIwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 04:52:24 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:44353 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392Ab2GLIwW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 04:52:22 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Jul 2012 04:52:21 EDT
Received: from 218.33.195.114.eo.eaccess.ne.jp ([218.33.195.114] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1SpEy1-0007Hg-1z; Thu, 12 Jul 2012 17:41:45 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 3038CDFF4; Thu, 12 Jul 2012 17:41:44 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <7vzk77f602.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 10 Jul 2012 18:20:29 -0700")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201352>

Junio C Hamano <gitster@pobox.com> writes:
> is easier to understand, while I think
>
> 	git branch <branch> [<start>]
>         git branch --set-upstream-to=<upstream> [<branch>]

Isn't one problem with this that even if a "--set-upstream-to" option
exists, inevitably some [and I'm guessing, many] people will not be
aware of it (after all, nobody reads documentation more than they have
to), and will attempt to use "--set-upstream" with an argument
(that's the natural thing to do, after all) -- which may succeed with
weird results ...?

-miles

-- 
One of the lessons of history is that nothing is often a good thing to
do, and always a clever thing to say.  -- Will Durant
