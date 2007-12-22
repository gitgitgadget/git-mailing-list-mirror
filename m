From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pushing and fetching sha1s directly
Date: Sat, 22 Dec 2007 15:12:05 -0800
Message-ID: <7vlk7mwchm.fsf@gitster.siamese.dyndns.org>
References: <20071222211308.GA27281@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Sun Dec 23 00:12:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6DWU-0004WD-8v
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 00:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbXLVXMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 18:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbXLVXMN
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 18:12:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbXLVXMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 18:12:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B2F26433D;
	Sat, 22 Dec 2007 18:12:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C6B433C;
	Sat, 22 Dec 2007 18:12:07 -0500 (EST)
In-Reply-To: <20071222211308.GA27281@pvv.org> (Finn Arne Gangstad's message of
	"Sat, 22 Dec 2007 22:13:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69158>

Finn Arne Gangstad <finnag@pvv.org> writes:

> Currently there seems to be no way of pusing a sha1 directly, or to
> fetch a sha1 directly. When working with submodules, it is convenient
> to be able to work with detached HEADs, so it would be good if this
> could be supported also by fetch and push.

At least push of an arbitrary commit is already supported, I
think.

For fetch, I would normally say "check the list archives", but
it was very long time ago that it was proposed and discussed.
It has some security and performance implications.
