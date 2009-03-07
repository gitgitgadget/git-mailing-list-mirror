From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] MinGW: fix diff --no-index /dev/null ...
Date: Sat, 7 Mar 2009 22:18:39 +0100
Message-ID: <200903072218.39087.j6t@kdbg.org>
References: <cover.1236441065u.git.johannes.schindelin@gmx.de> <dba002b9e521c639847650fbaeb8b87b66b9562e.1236441065u.git.johannes.schindelin@gmx.de> <7v8wnhnl6t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 22:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lg3wP-0001Od-0K
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 22:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbZCGVSs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2009 16:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbZCGVSs
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 16:18:48 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:36095 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbZCGVSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 16:18:47 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 64DE6CDF88;
	Sat,  7 Mar 2009 22:18:39 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 33A712814F;
	Sat,  7 Mar 2009 22:18:39 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v8wnhnl6t.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112587>

On Samstag, 7. M=E4rz 2009, Junio C Hamano wrote:
> Should this go to 'maint'?

I don't think that's necessary. It fixes only that someone literally wr=
ites on=20
the Windows command line

   git diff --no-index nul foo.c

when on Unix one would have written

   git diff --no-index /dev/null foo.c

In practice, only the test suite does this ;)

-- Hannes
