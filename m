From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk - work around stderr redirection on Cygwin
Date: Sun, 13 Jul 2008 14:35:00 -0700
Message-ID: <7vfxqdqxh7.fsf@gitster.siamese.dyndns.org>
References: <1213462668-424-1-git-send-email-mlevedahl@gmail.com>
 <487A6780.7030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9Em-0003Mx-Bv
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbYGMVfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYGMVfI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:35:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbYGMVfH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:35:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 021452AAD5;
	Sun, 13 Jul 2008 17:35:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AD04E2AAD4; Sun, 13 Jul 2008 17:35:02 -0400 (EDT)
In-Reply-To: <487A6780.7030500@gmail.com> (Mark Levedahl's message of "Sun,
 13 Jul 2008 16:37:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8FD76C6A-5123-11DD-883B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88341>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Mark Levedahl wrote:
>> Cygwin is *still* shipping with antiquated Tcl 8.4.1, and will continue
>> to do so for the indefinite future. This version does not understand
>> the "2>@1" redirection syntax, so such redirection of stderr must be
>> done using sh.
>
> Ping. This bug is in 1.5.6.x, and thus also in the current Cygwin git
> release: as a result, several gitk context menu items cause
> errors. (Let me know if I should resend the patch).

In the meantime, is it an option to apply this as a port specific patch
when Cygwin and whichever distribution ship with old Tcl package their
binary releases?

Just checking how urgent this issue is (8.4.1 was from Oct 2002 if I am
not mistaken) for maintainers of Cygwin port, and I am suspecting that
kernel folks are somewhat busy near/around OLS/KS timeframe (but not me).
