From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Data Integrity & un-Commited Branches
Date: Fri, 14 Sep 2007 23:37:22 -0700
Message-ID: <7vk5qs8me5.fsf@gitster.siamese.dyndns.org>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	<2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	<7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
	<2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
	<20070915025129.GY3099@spearce.org>
	<2a8a071a0709142324i29a863b7x8c164a589c1f1f9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Brian Scott Dobrovodsky" <brian@pontech.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 08:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWRHc-0004C4-Qs
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 08:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbXIOGhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 02:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908AbXIOGha
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 02:37:30 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:53015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbXIOGha (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 02:37:30 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id E958B133B4F;
	Sat, 15 Sep 2007 02:37:46 -0400 (EDT)
In-Reply-To: <2a8a071a0709142324i29a863b7x8c164a589c1f1f9a@mail.gmail.com>
	(Brian Scott Dobrovodsky's message of "Fri, 14 Sep 2007 23:24:42
	-0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58221>

"Brian Scott Dobrovodsky" <brian@pontech.com> writes:

>> It isn't unreasonable to want Git to save uncommitted work for the
>> current branch and then you switch to another, ending up with a
>> clean working directory when you finally get there.  Today we have
>> git-stash to help you with this, but I'm thinking maybe we want to
>> connect git-checkout with it?
>
> That would be great as a default action when using checkout!

I would not bet you will stay feeling that way as you gain
experience.  With "git stash create" (will be in 'next' this
weekend), we could start using stashes more transparently from
other commands, but I do not think this will ever become the
default for branch switching, while I do not oppose to have such
an option.
