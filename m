From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] fix some clang warnings
Date: Fri, 01 Feb 2013 14:37:59 +0900
Message-ID: <87fw1gwq4o.fsf@catnip.gol.com>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
	<20130116160410.GC22400@sigill.intra.peff.net>
	<7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
	<CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
	<20130116171809.GA2476@farnsworth.metanate.com>
	<7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
	<20130116175057.GB27525@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 06:46:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U19Sa-0003Rw-ND
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 06:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab3BAFq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 00:46:26 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:37292 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab3BAFqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 00:46:25 -0500
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Feb 2013 00:46:25 EST
Received: from 61.245.23.117.eo.eaccess.ne.jp ([61.245.23.117] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1U19K4-0002OP-Jx; Fri, 01 Feb 2013 14:38:00 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 96D4EDFBB; Fri,  1 Feb 2013 14:37:59 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20130116175057.GB27525@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Jan 2013 09:50:57 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215207>

Jeff King <peff@peff.net> writes:
> It seems a little weird to me that clang defines __GNUC__, but I
> assume there are good reasons for it.

The thing is that "gcc" is as much a language dialect these days as it
is a compiler implementation, and many other compilers, including
clang, explicitly try to implement that dialect (clang goes even
further by trying to be compatible in other ways, e.g. command-line
syntax, but that's not relevant here).

__GNUC__ is a way many programs try to detect the presence of a
compiler that implements that dialect, they have little choice but to
define it...

-Miles

-- 
Love, n. A temporary insanity curable by marriage or by removal of the patient
from the influences under which he incurred the disorder. This disease is
prevalent only among civilized races living under artificial conditions;
barbarous nations breathing pure air and eating simple food enjoy immunity
from its ravages. It is sometimes fatal, but more frequently to the physician
than to the patient.
