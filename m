From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Documentation: remove '\' from front of options in
	githooks doc
Date: Tue, 30 Sep 2008 19:21:55 +0200
Message-ID: <20080930172155.GJ6941@neumann>
References: <1222781831-6620-1-git-send-email-szeder@ira.uka.de>
	<200809301756.41518.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Sep 30 19:23:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkiwg-0001hS-0j
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 19:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbYI3RV5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Sep 2008 13:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752016AbYI3RV4
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 13:21:56 -0400
Received: from francis.fzi.de ([141.21.7.5]:12962 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751927AbYI3RV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 13:21:56 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 30 Sep 2008 19:21:54 +0200
Content-Disposition: inline
In-Reply-To: <200809301756.41518.trast@student.ethz.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 30 Sep 2008 17:21:54.0226 (UTC) FILETIME=[089E6120:01C92321]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97133>

Hi Thomas,

On Tue, Sep 30, 2008 at 05:56:32PM +0200, Thomas Rast wrote:
> This must be checked against older asciidocs to verify that it does
> not turn the unescaped sequence -- into an em-dash.  The \-- traces
> back to e1ccf53 ([PATCH] Escape asciidoc's built-in em-dash
> replacement, 2005-09-12), which indicates that it _was_ a problem in
> the past.  (The asciidoc 8.2.5 on my system does not use an em-dash i=
n
> either case.)
Indeed, now that I look more closely, I had those '\' characters only
in front of short options in the outputs.

However, it worth noting that there are plenty other places where
the double dash in long options are not escaped with a '\'.

> ACK on all single-dash cases though, which are indeed wrong and were
> apparently introduced later in 8089c85 (git-commit: add a
> prepare-commit-msg hook, 2008-02-05).
I will send a corrected patch shortly.

Thanks,
G=E1bor
