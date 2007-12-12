From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-clone: Implement git clone as a builtin command.
Date: Tue, 11 Dec 2007 19:20:14 -0800
Message-ID: <7vabogbnv5.fsf@gitster.siamese.dyndns.org>
References: <20071211195712.GA3865@bitplanet.net>
	<Pine.LNX.4.64.0712111549490.5349@iabervon.org>
	<1197416286.7552.4.camel@hinata.boston.redhat.com>
	<7vejdsbo7d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 04:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2I9R-0004C9-VS
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 04:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbXLLDU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 22:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbXLLDU2
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 22:20:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbXLLDU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 22:20:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 90B685668;
	Tue, 11 Dec 2007 22:20:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 250EC5664;
	Tue, 11 Dec 2007 22:20:16 -0500 (EST)
In-Reply-To: <7vejdsbo7d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 11 Dec 2007 19:12:54 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67987>

Junio C Hamano <gitster@pobox.com> writes:

> What the current "git clone" does that are not naturally expressed by
> the above sequence are:
>
>  * HEAD discovery
>
>    The code can be lifted from the scripted version and transplanted to
>    git-remote.  And to make "origin" and other remotes added by "git
>    remote add", this logic needs to be moved to "git remote".

s/remote add", this/remote add" more equal, this/;
