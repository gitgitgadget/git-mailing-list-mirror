From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitweb and remote branches
Date: Thu, 30 Aug 2007 14:07:13 -0700
Message-ID: <7vbqco91fi.fsf@gitster.siamese.dyndns.org>
References: <favitd$3ff$1@sea.gmane.org> <200708300001.39203.jnareb@gmail.com>
	<cb7bb73a0708300018u37f5c465u5d87eae0eb23543c@mail.gmail.com>
	<200708301016.17552.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:07:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQrEv-0006Gl-OK
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 23:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932780AbXH3VHV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXH3VHU
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 17:07:20 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:53845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617AbXH3VHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 17:07:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 322C212AFC1;
	Thu, 30 Aug 2007 17:07:36 -0400 (EDT)
In-Reply-To: <200708301016.17552.jnareb@gmail.com> (Jakub Narebski's message
	of "Thu, 30 Aug 2007 10:16:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57071>

Jakub Narebski <jnareb@gmail.com> writes:

> That reminds me that gitweb has no support for detached HEAD as of yet,
> although I don't think we want to encourage detached HEAD in public 
> repo.

That logic is flawed, I am afraid.  If you have been talking
only about serving public repository via gitweb, then the topic
of the thread becomes totally moot.  Exposing or even having
remotes/ in public distribution point repository would be even
more wrong than using detached HEAD in public repository.  Other
people who interact with you should not have any business what
you happened to have fetched from _your_ upstream --- if you
want to publish them and act as a relay for your downstream,
then they should be fetched from your branch namespace.

But obviously people use gitweb/instaweb as a way to view their
own live repository, and I think it makes sense to show and
support remotes/ in such a case.  It also would make sense to
support detached HEAD there as well.
