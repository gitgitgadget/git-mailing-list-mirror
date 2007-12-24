From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git rev-list --first-parent
Date: Mon, 24 Dec 2007 00:30:59 -0800
Message-ID: <7v3atstry4.fsf@gitster.siamese.dyndns.org>
References: <1198484450-16454-1-git-send-email-avi@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 09:31:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6iim-0005Lv-Jx
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 09:31:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbXLXIbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 03:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbXLXIbL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 03:31:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXLXIbK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 03:31:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 52CDC5907;
	Mon, 24 Dec 2007 03:31:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E9ADD5906;
	Mon, 24 Dec 2007 03:31:05 -0500 (EST)
In-Reply-To: <1198484450-16454-1-git-send-email-avi@qumranet.com> (Avi
	Kivity's message of "Mon, 24 Dec 2007 10:20:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69205>

Avi Kivity <avi@qumranet.com> writes:

> Document git rev-list's --first-parent option.  Documentation taken from
> git log.
> ...
> +--first-parent::
> +	Follow only the first parent commit upon seeing a merge
> +	commit.  This  option gives a better overview of the
> +	evolution of a particular branch.
> +

I am afraid that this description is not sufficient.  The
history given by --first-parent is useful only in a very limited
use case, and the user needs to be aware of it.
