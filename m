From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix initialization of a bare repository
Date: Wed, 15 Aug 2007 12:26:35 -0700
Message-ID: <7v8x8cr444.fsf@gitster.siamese.dyndns.org>
References: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708151821260.19496@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vlkccr4wu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILOWb-0000cd-CR
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 21:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760152AbXHOT0n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760151AbXHOT0m
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 15:26:42 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758837AbXHOT0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 15:26:41 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A7B0E121EFD;
	Wed, 15 Aug 2007 15:26:59 -0400 (EDT)
In-Reply-To: <7vlkccr4wu.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 Aug 2007 12:09:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55939>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for a quick fix.

Gaah.  I spoke way too early.  This breaks even more things than
it fixes.  Even something as simple as "git add ." does not work
anymore.
