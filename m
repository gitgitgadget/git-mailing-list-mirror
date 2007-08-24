From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tags of non-commits
Date: Fri, 24 Aug 2007 11:49:23 -0700
Message-ID: <7vwsvkdaz0.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0708241337560.5774@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Aug 24 20:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOeDq-0006Ip-Pm
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 20:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764388AbXHXSt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 14:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764333AbXHXSt1
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 14:49:27 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764331AbXHXSt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 14:49:26 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D95F11259AF;
	Fri, 24 Aug 2007 14:49:46 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708241337560.5774@iabervon.org> (Daniel
	Barkalow's message of "Fri, 24 Aug 2007 14:11:33 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56590>

Daniel Barkalow <barkalow@iabervon.org> writes:

> There seems to be an inconsistency between the fetch and tag over whether 
> lightweight tags of non-commits are allowed. Fetch doesn't like them, but 
> tag creates them without any particular fuss.

Is your "fetch does not like them" about the automated
following?  If you say "git fetch $remote tag $that_tag" there
shouldn't be any difference.

And the difference in the automated following behaviour is
deliberate.  Lightweight ones tend to be private "anchor point"
during development (these days we need that less often, thanks
to reflogs), and annotated ones, especially the signed kinds are
meant for public consumption.
