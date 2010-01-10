From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 0/4] Documentation style fixes
Date: Sun, 10 Jan 2010 13:10:10 +0100
Message-ID: <201001101310.21455.trast@student.ethz.ch>
References: <7vaawp4wvz.fsf@alter.siamese.dyndns.org> <201001100107.29920.trast@student.ethz.ch> <7vfx6efox9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 13:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTwd7-0006rf-DO
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 13:10:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab0AJMKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 07:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752499Ab0AJMKp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 07:10:45 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:30498 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385Ab0AJMKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 07:10:44 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:10:43 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:10:21 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <7vfx6efox9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136569>

Junio C Hamano wrote:
> 
> I'd like to proceed with this series by (1) pulling from you and queuing
> the result in 'next', (2) asking other people (including Jonathan) to
> proofread and send necessary updates to the list, (3) asking you to check
> and queue these updates from others yourself and tell me to pull again to
> my 'next', and (4) merging the result to 'master' when done.
> 
> Does it sound workable?  Am I placing too much undue burden on you?

No, that's fine, and indeed I'm glad I'm not putting too much
conflict-resolution burden on you.

I took the not-yet-merged (I hope I understood the above right :-)
liberty of squashing fixes from Jonathan's review.  I'll send the
interdiffs as a reply to this mail.  They're now at

  git://repo.or.cz/git/trast.git doc-style/for-next

(I'm leaving the old head in place for comparison).  I'm gathering
incremental updates in

  git://repo.or.cz/git/trast.git doc-style/pu

For now we have

Jonathan Nieder (2):
      Documentation: git gc packs refs by default now
      Documentation: tiny git config manual tweaks

Thomas Rast (1):
      Documentation: show-files is now called git-ls-files

I'll also send the last one for review shortly, though it's rather
trivial.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
