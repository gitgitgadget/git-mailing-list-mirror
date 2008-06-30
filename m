From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: perl t9700 failures?
Date: Mon, 30 Jun 2008 08:11:48 +0200
Message-ID: <48687924.7020309@viscovery.net>
References: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org> <7vzlp47zy8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Lea Wiemann <LeWiemann@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 08:13:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDCdJ-0006er-3d
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 08:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbYF3GLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 02:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752617AbYF3GLy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 02:11:54 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:4737 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbYF3GLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 02:11:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KDCc9-0000Vy-AO; Mon, 30 Jun 2008 08:11:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E2E884E4; Mon, 30 Jun 2008 08:11:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vzlp47zy8.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86879>

Junio C Hamano schrieb:
> I'll commit this

> +perl -MTest::More -e 0 2>/dev/null || {
> +	say skip "Perl Test::More unavailable, skipping test"

But without the "skip", right? ;)

-- Hannes
