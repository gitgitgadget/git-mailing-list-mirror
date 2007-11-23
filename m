From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add config_int() method to the Git perl module
Date: Fri, 23 Nov 2007 11:59:25 -0800
Message-ID: <7vabp4u40y.fsf@gitster.siamese.dyndns.org>
References: <200711231904.53551.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Dan Zwell <dzwell@zwell.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 21:00:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ivegp-0004Pv-EF
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 20:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757363AbXKWT7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 14:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757360AbXKWT7d
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 14:59:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:34886 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbXKWT7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 14:59:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DC455310;
	Fri, 23 Nov 2007 14:59:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F10298F09;
	Fri, 23 Nov 2007 14:59:49 -0500 (EST)
In-Reply-To: <200711231904.53551.jnareb@gmail.com> (Jakub Narebski's message
	of "Fri, 23 Nov 2007 19:04:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65921>

Jakub Narebski <jnareb@gmail.com> writes:

> Integer variables can have optional 'k', 'm' or 'g' suffix.
> config_int() method will return simple decimal number, taking
> care of those suffixes.

Good.  I forgot about --int option to "git config" already.

Maybe in a similar way, we might want to add --color to "git
config" to return ANSI sequence, so that Git::config_color() can
work without even loading Term::ANSIColor?
