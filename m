From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk from subdirectory
Date: Thu, 30 Aug 2007 22:51:04 -0700
Message-ID: <7vabs845h3.fsf@gitster.siamese.dyndns.org>
References: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0708302200160.25853@woody.linux-foundation.org>
	<7vejhk45q5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 07:51:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQzPY-0002WE-1T
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 07:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586AbXHaFvM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 01:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbXHaFvK
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 01:51:10 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbXHaFvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 01:51:09 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 70E46129E05;
	Fri, 31 Aug 2007 01:51:28 -0400 (EDT)
In-Reply-To: <7vejhk45q5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 30 Aug 2007 22:45:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57117>

Junio C Hamano <gitster@pobox.com> writes:

> "git log" family of commands, even when run from a subdirectory,
> do not limit the revision range with the current directory as
> the path limiter, but with double-dash without any paths after
> it, i.e. "git log --" do so.  It was a mistake to have a
> difference between "git log --" and "git log" introduced in
> commit ae563542bf10fa8c33abd2a354e4b28aca4264d7 (First cut at
> libifying revlist generation).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

In case it was not obvious, this patch is meant to make the
previous patch from me to change gitk unneeded.
