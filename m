From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: get rid of --index-info in favor of --build-fake-ancestor
Date: Mon, 17 Sep 2007 15:42:01 -0700
Message-ID: <7v7imozzgm.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709172330400.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:42:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPIG-0005ln-Cx
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689AbXIQWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 18:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756101AbXIQWmM
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:42:12 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:43362 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756667AbXIQWmL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:42:11 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7BDC7136F04;
	Mon, 17 Sep 2007 18:42:25 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709172330400.28586@racer.site> (Johannes
	Schindelin's message of "Mon, 17 Sep 2007 23:34:06 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58488>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Suggested by Junio, but the errors are all mine.
>
> 	I am not quite certain, though, if there is really no porcelain 
> 	using that option.  It has been around since Oct 7 2005 (!), so 
> 	there is a real chance that StGit, guilt or QGit use it.  In that 
> 	case, this patch is obviously wrong.

You do not have to do the deprecating/removing part if that is
the issue.
