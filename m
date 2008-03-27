From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Allow git-cvsserver database table name prefix to be
 specified.
Date: Thu, 27 Mar 2008 16:13:53 -0700
Message-ID: <7v3aqbahfy.fsf@gitster.siamese.dyndns.org>
References: <20080327205727.GN2324@opal.elsasser.org>
 <12066517343988-git-send-email-josh@elsasser.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Josh Elsasser <josh@elsasser.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 00:14:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jf1Iy-00020Q-Tt
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 00:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463AbYC0XOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2008 19:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYC0XOE
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Mar 2008 19:14:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbYC0XOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2008 19:14:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A5F737B1;
	Thu, 27 Mar 2008 19:14:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EE91F37B0; Thu, 27 Mar 2008 19:13:54 -0400 (EDT)
In-Reply-To: <12066517343988-git-send-email-josh@elsasser.org> (Josh
 Elsasser's message of "Thu, 27 Mar 2008 14:02:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78378>

Josh Elsasser <josh@elsasser.org> writes:

> Adds a gitcvs.dbtablenameprefix config variable, the contents of which
> are prepended to any database tables names used by git-cvsserver. The
> same substutions as gitcvs.dbname and gitcvs.dbuser are supported, and
> any non-alphabetic characters are replaced with underscores.
>
> A typo found in contrib/completion/git-completion.bash is also fixed.

Wow, sharp eyes.

> This version of the patch is a bit cleaner, it calls a function to get
> the table names instead of pasting a variable reference everywhere.

Looks much cleaner then the previous one, indeed.

I consider it signed-off?
