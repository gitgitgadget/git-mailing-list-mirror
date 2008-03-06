From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Wed, 05 Mar 2008 22:18:14 -0800
Message-ID: <7vy78wgyu1.fsf@gitster.siamese.dyndns.org>
References: <20080305225123.GA8485@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, newsletter@dirk.my1.cc, git@vger.kernel.org
To: kaitanie@cc.helsinki.fi
X-From: git-owner@vger.kernel.org Thu Mar 06 07:19:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX9RZ-0008UF-75
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 07:19:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbYCFGS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 01:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755063AbYCFGS1
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 01:18:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36701 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYCFGS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 01:18:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 95334348C;
	Thu,  6 Mar 2008 01:18:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D9694348B; Thu,  6 Mar 2008 01:18:17 -0500 (EST)
In-Reply-To: <20080305225123.GA8485@localdomain> (Pekka Kaitaniemi's message
 of "Thu, 6 Mar 2008 00:51:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76341>

Pekka Kaitaniemi <kaitanie@cc.helsinki.fi> writes:

> Adding horizontal scroll bar makes the scrolling feature more
> discoverable to the users.
>
> Signed-off-by: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
> ---
> Here is a patch that adds horizontal scroll bar to the gitk diff
> pane. It makes the scrolling feature a bit more discoverable and
> accessible. The only downside is that it uses some screen real estate.

An obvious solution is to show the scrollbar on-demand (i.e. when the
lines are overlong), but I do not talk Tcl/Tk and do not know if you can
do that easily.


