From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] Bisect: factorise "bisect_write_*" functions.
Date: Tue, 23 Oct 2007 15:13:12 -0700
Message-ID: <7v640x7a4n.fsf@gitster.siamese.dyndns.org>
References: <20071014142938.d722299c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:13:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkS0F-0007eQ-7m
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 00:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754771AbXJWWNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 18:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbXJWWNW
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 18:13:22 -0400
Received: from rune.pobox.com ([208.210.124.79]:46164 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754557AbXJWWNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 18:13:21 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 2EBEF14EBC8;
	Tue, 23 Oct 2007 18:13:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 790D814EAD1;
	Tue, 23 Oct 2007 18:13:36 -0400 (EDT)
In-Reply-To: <20071014142938.d722299c.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 14 Oct 2007 14:29:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62164>

Sort of offtopic, but is "factorise" a correct verb here?  I
thought "factorise" is to express a non prime number as the
product of prime numbers.

"refactor" is the act of splitting and merging pieces of
functions for better reuse, isn't it?
