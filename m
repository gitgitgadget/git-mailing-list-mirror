From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/3] archive: rename attribute specfile to export-subst
Date: Thu, 06 Sep 2007 14:03:40 -0700
Message-ID: <7vd4wva4lv.fsf@gitster.siamese.dyndns.org>
References: <46DC4D45.4030208@lsrfire.ath.cx>
	<7vtzqb8fw2.fsf@gitster.siamese.dyndns.org> <46DCF0EF.9020604@op5.se>
	<Pine.LNX.4.64.0709041139140.28586@racer.site>
	<46DDE69C.1080908@lsrfire.ath.cx>
	<7vzm02klip.fsf@gitster.siamese.dyndns.org>
	<46E02FFF.8090902@lsrfire.ath.cx>
	<Pine.LNX.4.64.0709061811460.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>,
	Thomas Glanzmann <thomas@glanzmann.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:04:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITOW5-0004rx-K3
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 23:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbXIFVDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 17:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbXIFVDv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 17:03:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59400 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbXIFVDv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 17:03:51 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 466DD12DFFB;
	Thu,  6 Sep 2007 17:04:04 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709061811460.28586@racer.site> (Johannes
	Schindelin's message of "Thu, 6 Sep 2007 18:13:29 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57932>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The bigger question is now if these two patches should be folded back into 
> your original patch series, or stand alone as commits of their own...

That is no brainer, as there is a simple and hard rule that any
topic already in 'next' are not to be rewound ever.  Follow-up
patches are the right thing to do in this case.
