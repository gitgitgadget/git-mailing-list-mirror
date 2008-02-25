From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] daemon: send more error messages to the syslog
Date: Mon, 25 Feb 2008 11:02:45 -0800
Message-ID: <7v3argkgfe.fsf@gitster.siamese.dyndns.org>
References: <47C2C1C0.5070903@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTic0-0004On-73
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:03:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758240AbYBYTDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757894AbYBYTDE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:03:04 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757826AbYBYTDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:03:03 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4957D2153;
	Mon, 25 Feb 2008 14:02:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 918CC2152; Mon, 25 Feb 2008 14:02:53 -0500 (EST)
In-Reply-To: <47C2C1C0.5070903@viscovery.net> (Johannes Sixt's message of
 "Mon, 25 Feb 2008 14:25:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75048>

Johannes Sixt <j.sixt@viscovery.net> writes:

> There were a number of die() calls before the syslog was opened; hence,
> these error messages would have been sent to /dev/null in detached mode.
> Now we install the daemon-specific die routine before any error message is
> generated so that these messages go to the syslog.

Makes sense.  Thanks.
