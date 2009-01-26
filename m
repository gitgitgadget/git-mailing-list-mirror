From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: rerere: how to remove an erroneous resolution?
Date: Mon, 26 Jan 2009 16:13:26 +0100
Message-ID: <20090126151326.GA2618@neumann>
References: <20090126144239.GA494@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 16:14:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRTAq-0001OR-8M
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 16:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbZAZPN1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2009 10:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbZAZPN1
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 10:13:27 -0500
Received: from francis.fzi.de ([141.21.7.5]:4887 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750775AbZAZPN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 10:13:26 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 16:13:25 +0100
Content-Disposition: inline
In-Reply-To: <20090126144239.GA494@neumann>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 26 Jan 2009 15:13:25.0222 (UTC) FILETIME=[A2703860:01C97FC8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107217>

On Mon, Jan 26, 2009 at 03:42:39PM +0100, SZEDER G=E1bor wrote:
> some time ago I mistakenly resolved a merge conflict incorrectly.  Of
> course, rerere noted the erroneous conflict resolution, and whenever
> the same merge conflict occurs rerere offers me that erroneous
> conflict resolution, even though I correct it each time.
>=20
> So, the question is how could I make rerere forget that particular
> merge conflict resolution?  Is it at all possible?

Ok, I should have investigated a little longer before sending that
email.

I thought that .git/rr-cache contains some kind of sha1-named objects,
and did not realize that those are indeed directories with just
plaintext pre- and postimage files in it.  So, after some grepping I
could identify the sought conflict resolution fairly easily, and
correct it.

Best,
G=E1bor
