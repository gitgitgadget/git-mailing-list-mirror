From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Test failures in today's pu: 0025, 4046, 4203, 9300, 9301
Date: Wed, 20 Oct 2010 18:56:54 +0200
Message-ID: <201010201856.54756.trast@student.ethz.ch>
References: <201010201148.51551.trast@student.ethz.ch> <7vvd4wvmv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 18:57:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8byd-0005Ye-UA
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 18:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754422Ab0JTQ5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 12:57:17 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:17094 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab0JTQ5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 12:57:16 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 20 Oct
 2010 18:57:14 +0200
Received: from pctrast.inf.ethz.ch (129.132.149.150) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 20 Oct
 2010 18:56:53 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.36-rc8-32-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7vvd4wvmv6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159418>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > * t4203-mailmap: bisected to d8d2eb7d (mailmap: fix use of freed
> >   memory).  I saw some list traffic possibly related to this, is it
> >   fixed already?
> 
> I found one issue that will trigger if you do not run this test with its
> standard input corrected to a terminal and pushed out a fix last night.
> Did you have 3e3e1ef (t4203: do not let "git shortlog" DWIM based on tty,
> 2010-10-19) when your automated test ran?

No.  False alarm then?

> > * t9300-fast-import: bisected to a544a23c (t9300 (fast-import):
> >   another test for the "replace root" feature).
> 
> Jonathan noticed breakage caused while I was applying his patch; should be
> corrected as of last night with 971728c (t9300 (fast-import): another test
> for the "replace root" feature, 2010-10-17).

Same here.  I thought I saw a valgrind failure, but it was only caused
by -O0 apparently.  In any case I cannot reproduce the test failur
with current pu (b19f0de).

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
