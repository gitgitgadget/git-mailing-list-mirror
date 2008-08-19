From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Tue, 19 Aug 2008 10:49:53 +0200
Message-ID: <48AA8931.1030009@viscovery.net>
References: <20080818123727.GB11842@schiele.dyndns.org> <7vy72tkfu0.fsf@gitster.siamese.dyndns.org> <20080819072650.GE11842@schiele.dyndns.org> <7vpro5fnke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Robert Schiele <rschiele@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 10:51:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVMvg-00071L-Pr
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 10:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557AbYHSIt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 04:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbYHSIt7
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 04:49:59 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:61434 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYHSIt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 04:49:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KVMuY-0004D0-FM; Tue, 19 Aug 2008 10:49:54 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E556B4FB; Tue, 19 Aug 2008 10:49:53 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vpro5fnke.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92833>

Junio C Hamano schrieb:
> Even if that is the case, I do not like the prospect of having to maintain
> a set of duplicated variable definitions.  If we really wanted to address
> this issue, maybe we would want a separate source file that is linked to
> both git-shell and to the rest of the system that has nothing but
> definitions of these variables?  I thought environment.c was meant to be
> something like that -- would linking environment.o pull in too many extra
> references these days (again, I didn't try)?

Why not just revert 5b8e6f85f (shrink git-shell)? It was a nice try. If it
had not proved as a maintainance burden, it would have had merits. But who
these days cares whether git-shell takes 300K or 30K in the light of that
it goes out of the way anyway by execing some other process at the first
opportunity?

-- Hannes
