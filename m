From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch: print informative messages to stdout, not stderr
Date: Fri, 26 Oct 2007 14:01:15 -0700
Message-ID: <7vr6jhwpyc.fsf@gitster.siamese.dyndns.org>
References: <20071026085355.24930.qmail@2c06371a7c3ae6.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Oct 26 23:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlWJB-0000qC-RC
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 23:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbXJZVBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 17:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753366AbXJZVBU
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 17:01:20 -0400
Received: from rune.pobox.com ([208.210.124.79]:52760 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbXJZVBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 17:01:19 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6D17014E4D7;
	Fri, 26 Oct 2007 17:01:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id EA6FC14E4CD;
	Fri, 26 Oct 2007 17:01:38 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62444>

Gerrit Pape <pape@smarden.org> writes:

> git-fetch writes informations about storing tags and the like to stderr,
> which should only be used for errors.  This patch changes it to use
> stdout instead.

I do not have strong preference but the reason this goes to
stderr is because it is considered part of the progress
reporting.  It is not designed for consumption by scripted
callers, and its formatting is subject to change freely, which
is what allows the recent "terse fetch" discussion.
