From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC PATCH 0/3] git-p4: move to toplevel
Date: Tue, 14 Feb 2012 10:20:48 +0100
Message-ID: <20120214092048.GC1762@ecki>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
 <7vehtyec64.fsf@alter.siamese.dyndns.org>
 <20120213203709.GA31671@ecki>
 <7vhayuctwm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 10:29:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxEhK-0006Jw-Dw
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 10:29:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759818Ab2BNJ3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 04:29:12 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:63633 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759940Ab2BNJ3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 04:29:10 -0500
Received: from localhost (p5B22E1C5.dip.t-dialin.net [91.34.225.197])
	by bsmtp.bon.at (Postfix) with ESMTP id 82ABFA7F18;
	Tue, 14 Feb 2012 10:29:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhayuctwm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190712>

On Mon, Feb 13, 2012 at 01:20:25PM -0800, Junio C Hamano wrote:
> Clemens Buchacher <drizzd@aon.at> writes:
> 
> >> Erm,... do you really need the alias if you add git-p4 in a directory on
> >> your $PATH?
> >
> > With recent git versions, this has stopped working.
> 
> Erm, I am confused.

Looks like in my case it did not work because I had a PATH entry with a
'~' in it. It probably stopped working for me because I moved some
executables around.

It's not a regression (I just tried with 1.6.0 and I get the same
result).  And dash does not apply tilde expansion to PATH either.  So
maybe it's not even a bug.
