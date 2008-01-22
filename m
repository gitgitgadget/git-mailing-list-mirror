From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Tue, 22 Jan 2008 23:34:58 +0100
Message-ID: <200801222334.58874.robin.rosenberg.lists@dewire.com>
References: <fn1nl6$ek5$1@ger.gmane.org> <alpine.LFD.1.00.0801212304460.2957@woody.linux-foundation.org> <7vmyqythwa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:38:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHRl7-0001zd-6u
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 23:38:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbYAVWhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 17:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033AbYAVWhu
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 17:37:50 -0500
Received: from [83.140.172.130] ([83.140.172.130]:28549 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbYAVWht (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 17:37:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1562480264C;
	Tue, 22 Jan 2008 23:37:46 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QfMLwEoKnoKg; Tue, 22 Jan 2008 23:37:45 +0100 (CET)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 1BBF080019B;
	Tue, 22 Jan 2008 23:37:44 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vmyqythwa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71475>

tisdagen den 22 januari 2008 skrev Junio C Hamano:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Again, as an OSX-only workaround it's probably acceptable, and perhaps 
> > that's the only thing to look at right now. But it does strike me as a 
> > design mistake to do it at that level.
> 
> Yes, we would need a reverse conversion when going from index to
> work tree, including entry.c, in order to be able to emulate
> this on filesystems that do not take "equivalent" but different
> names on open(), creat() and lstat().

About this size:

http://rosenberg.homelinux.net/cgi-bin/gitweb/gitweb.cgi?p=GIT.git;a=commitdiff;h=766d84eff841172c3754f67c66363a1d60038de5

And messed up expanded tests:

http://rosenberg.homelinux.net/cgi-bin/gitweb/gitweb.cgi?p=GIT.git;a=commitdiff;h=5d73e28397f7ec0f85fcb8e31e91326afbcfea19

Junio: @Maybe in five years@, you said.. Four more to go.

-- robin
