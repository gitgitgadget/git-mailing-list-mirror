From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Restricting access to a branch
Date: Wed, 21 May 2008 17:17:25 -0700
Message-ID: <7vhccrxkdm.fsf@gitster.siamese.dyndns.org>
References: <20080521163616.31fad56f@extreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
X-From: git-owner@vger.kernel.org Thu May 22 02:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyyVq-0004cH-Go
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 02:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937669AbYEVARi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2008 20:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937659AbYEVARi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 May 2008 20:17:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937550AbYEVARg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2008 20:17:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 99ED1195C;
	Wed, 21 May 2008 20:17:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 145D61956; Wed, 21 May 2008 20:17:29 -0400 (EDT)
In-Reply-To: <20080521163616.31fad56f@extreme> (Stephen Hemminger's message
 of "Wed, 21 May 2008 16:36:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78CAD470-2794-11DD-98BD-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82589>

Stephen Hemminger <shemminger@vyatta.com> writes:

> Is there some standard way to freeze a branch and not allow anymore changes to
> be pushed?
>
> Yes, I know it is possible by playing with hook files, but that doesn't seem
> very admin friendly.

If you do not want to use hooks, then the answer is no.  Sorry.
