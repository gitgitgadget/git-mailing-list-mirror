From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Mon, 29 Jul 2013 21:37:56 +0200
Message-ID: <874nbdnomj.fsf@hexa.v.cablecom.net>
References: <cover.1370806329.git.trast@inf.ethz.ch>
	<874nblpamj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 29 21:38:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tGc-00030v-WC
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab3G2Th7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 15:37:59 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:21516 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab3G2Th6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 15:37:58 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 29 Jul
 2013 21:37:55 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 29 Jul
 2013 21:37:56 +0200
In-Reply-To: <874nblpamj.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Tue, 23 Jul 2013 17:19:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231321>

Thomas Rast <trast@inf.ethz.ch> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> Now that git log -L has hit master, I figure it's time to discuss the
>> corresponding change to gitk.
>
> Paul, any news on this?  Any chance we can get it into the next release,
> since that will also be the first release to ship with 'git log -L'?

Jens pointed out privately that the handling of unstuck -L options is
unfortunate, to put it mildly.  I'll send a reroll.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
