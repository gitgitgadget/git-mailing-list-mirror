From: Kevin Ryde <user42@zip.com.au>
Subject: Re: git-blame.el: does not show one-line summary in echo area
Date: Sat, 05 Feb 2011 08:49:26 +1100
Message-ID: <87pqr7a2s9.fsf@blah.blah>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <20110204014315.GB28525@elie>
	<87tygkm8h7.fsf@krank.kagedal.org>
	<201102041103.10770.jnareb@gmail.com>
	<87r5bom7g3.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Sergei Organov <osv@javad.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Martin Nordholts <enselic@gmail.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Xavier Maillard <zedek@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 04 23:21:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlU2L-0005uR-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 23:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab1BDWVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 17:21:48 -0500
Received: from mailout2-2.pacific.net.au ([61.8.2.225]:37573 "EHLO
	mailout2.pacific.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751971Ab1BDWVs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 17:21:48 -0500
X-Greylist: delayed 1935 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Feb 2011 17:21:47 EST
Received: from mailproxy2.pacific.net.au (mailproxy2.pacific.net.au [61.8.2.163])
	by mailout2.pacific.net.au (Postfix) with ESMTP id 890842AC73A;
	Sat,  5 Feb 2011 08:49:27 +1100 (EST)
Received: from blah.blah (unknown [203.26.175.90])
	by mailproxy2.pacific.net.au (Postfix) with ESMTP id EADB527409;
	Sat,  5 Feb 2011 08:49:26 +1100 (EST)
Received: from gg by blah.blah with local (Exim 4.72)
	(envelope-from <gg@zip.com.au>)
	id 1PlTWx-00017e-Ad; Sat, 05 Feb 2011 08:49:27 +1100
In-Reply-To: <87r5bom7g3.fsf@krank.kagedal.org> ("David =?iso-8859-1?Q?K?=
 =?iso-8859-1?Q?=E5gedal=22's?= message of
	"Fri, 04 Feb 2011 11:15:40 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166060>

David K=E5gedal <davidk@lysator.liu.se> writes:
>
> But we can
> of course let the echo area grow to two lines, or even three.

Though xemacs 21 can't grow it, and emacs doesn't if you turn off
message-truncate-lines.

If message-truncate-lines is nil or unbound you might collapse out
newlines or perhaps ellipsize or something.
