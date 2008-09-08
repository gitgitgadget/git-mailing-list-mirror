From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] prefix discovery at runtime (on Windows)
Date: Mon, 08 Sep 2008 15:50:43 -0700
Message-ID: <7vprnedzgc.fsf@gitster.siamese.dyndns.org>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de>
 <7v3al35xmy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Sep 09 00:52:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcpaS-0000vY-PH
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 00:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYIHWux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 18:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753317AbYIHWuw
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 18:50:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbYIHWuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 18:50:52 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 39A995F18F;
	Mon,  8 Sep 2008 18:50:51 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 10DE15F18B; Mon,  8 Sep 2008 18:50:45 -0400 (EDT)
In-Reply-To: <7v3al35xmy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 17 Aug 2008 11:01:25 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 95F570F4-7DF8-11DD-9992-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95313>

Junio C Hamano <gitster@pobox.com> writes:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Apologies for proposing such large changes that late in the release cycle.
>> Maybe we want to postpone the series until 1.6.0.1 or even 1.6.1.
>
> Well, from the cursory look, it does not seem to be 1.6.0.1 material, even
> though it is possible to fork a topic at 1.6.0 and use the changes in
> 'next', then 'master', and eventually to 'maint' to produce 1.6.0.X, if
> all of this hapapens before 1.6.1.
>
> I wouldn't mind at all if the binary distribution on Windows is based on
> "git.git plus port specific patchset that will eventually be sent
> upstream" like it used to be.  In fact it might even be preferrable, as I
> won't be testing ports to that platform myself anyway.

If the depth difference between /usr/libexec/git-cat-file and /bin/git is
the major source of this headache, I do not think it is unreasonable for
the mingw git port to use "gitexecdir=$(bindir)" layout by default.  After
all, Windows users do not really care where bulk of things are, as long as
they see one single clickable icon on the desktop, don't they?
