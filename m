From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Where has "git ls-remote" reference pattern matching gone?
Date: Sat, 08 Dec 2007 17:34:06 -0800
Message-ID: <7vve78tzw1.fsf@gitster.siamese.dyndns.org>
References: <4E5E5B1E-A303-45C9-9944-57D54FD50F80@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sun Dec 09 02:34:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1B45-0003uS-O3
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 02:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbXLIBeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 20:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbXLIBeU
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 20:34:20 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:64731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbXLIBeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 20:34:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC684104;
	Sat,  8 Dec 2007 20:34:14 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F70E4101;
	Sat,  8 Dec 2007 20:34:10 -0500 (EST)
In-Reply-To: <4E5E5B1E-A303-45C9-9944-57D54FD50F80@orakel.ntnu.no> (Eyvind
	Bernhardsen's message of "Sat, 8 Dec 2007 23:05:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67581>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> writes:

> ls-remote was recently made a builtin; was reference filtering
> deliberately removed, or was it just lost in translation from the
> shell script?

I suspect that to be the case.  Daniel, I think this is yours.
