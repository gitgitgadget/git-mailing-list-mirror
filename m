From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 00/11] perf improvements past v1.7.10
Date: Mon, 12 Mar 2012 17:35:22 +0100
Message-ID: <87sjhd4w1h.fsf@thomas.inf.ethz.ch>
References: <cover.1331561353.git.trast@student.ethz.ch>
	<CACsJy8BQXvX6iOH0txcw5wmW-2ddnG3A39BxsrspfkqPTwDy_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:35:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S78DZ-0002P7-3L
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 17:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294Ab2CLQfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 12:35:25 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46164 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab2CLQfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 12:35:24 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:35:23 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 12 Mar
 2012 17:35:23 +0100
In-Reply-To: <CACsJy8BQXvX6iOH0txcw5wmW-2ddnG3A39BxsrspfkqPTwDy_g@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 12 Mar 2012 22:28:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192901>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Not really related to the series, how do I compare the same tests on
> different repositories? These repositories share the same DAG, but may
> have different object representation (all loose, single pack, zillion
> of packs, different versions of pack...)

Currently the only way is to run the test once for each setting of
GIT_PERF_REPO.  The only comparisons it does so far is between
revisions/build directories.

That's just because at the time, I saw neither a clear need nor a simple
syntax that I could use.  I'd welcome suggestions, however.

My only use-case that 'run' does not handle so far would just be
mirroring the table, i.e., getting a comparison of different tests (such
as 'rebase', 'rebase -m' etc.)  from the same build tree.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
