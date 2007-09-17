From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-archive not working correctly ?
Date: Sun, 16 Sep 2007 17:35:19 -0700
Message-ID: <7vtzpu3z94.fsf@gitster.siamese.dyndns.org>
References: <1189983026.22727.61.camel@niki2.guldbrand.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Niki Guldbrand <niki.guldbrand@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 02:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX4aG-0008Qf-3Q
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 02:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbXIQAfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 20:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbXIQAfY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 20:35:24 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbXIQAfX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 20:35:23 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D3821365D0;
	Sun, 16 Sep 2007 20:35:42 -0400 (EDT)
In-Reply-To: <1189983026.22727.61.camel@niki2.guldbrand.net> (Niki Guldbrand's
	message of "Mon, 17 Sep 2007 00:50:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58370>

Niki Guldbrand <niki.guldbrand@gmail.com> writes:

> git-archive --format=<fmt> [--list] [--prefix=<prefix>/] [<extra>]
> [--remote=<repo>] <tree-ish> [path...]
>
> <extra>
>         This can be any options that the archiver backend understand.
>         See next section.
>         
> I want to git tar the "--exclude=option", but i can't get it through.
> Is this option only valid for the zip format with the options "-0" and
> "-9" ?

The "next section" that sentence refers to is "BACKEND EXTRA
OPTIONS" section, which lists -0 and -9 for zip backend.  There
is no --exclude=option in either tar or zip backend.

Note that we do not use GNU tar or zip as archiver backends.
