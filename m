From: Junio C Hamano <gitster@pobox.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 02:07:40 -0700
Message-ID: <7vbqchjx9f.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <46DE6DBC.30704@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 11:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqrW-0001Ct-Ly
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 11:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135AbXIEJHq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 05:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756118AbXIEJHq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 05:07:46 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbXIEJHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 05:07:46 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1980012EC27;
	Wed,  5 Sep 2007 05:08:03 -0400 (EDT)
In-Reply-To: <46DE6DBC.30704@midwinter.com> (Steven Grimm's message of "Wed,
	05 Sep 2007 01:50:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57697>

Steven Grimm <koreth@midwinter.com> writes:

> The fact that git sometimes stores your files individually in the .git
> directory and sometimes bundles them together into big archives should
> be an implementation detail that end-users don't have to worry about
> day to day...

[alias]
        begin = gc
	leave = gc

That is, the user's manual says 'at the beginning of the day,
run "git begin" to start the day, and at the end of day, run
"git leave" to conclude your day', without saying why ;-)
