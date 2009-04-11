From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] git add -p: new "quit" command at the prompt.
Date: Sat, 11 Apr 2009 12:22:58 -0700
Message-ID: <7vws9rdmgd.fsf@gitster.siamese.dyndns.org>
References: <1239375421-2556-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:25:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsipG-0004sO-1g
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927AbZDKTXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 15:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758919AbZDKTXF
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:23:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758914AbZDKTXE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 15:23:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D415A9E60;
	Sat, 11 Apr 2009 15:23:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 51D98A9E5F; Sat,
 11 Apr 2009 15:23:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2D4E6DD8-26CE-11DE-B7C0-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116325>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> There's already 'd' to stop staging hunks in a file, but no command to
> stop the interactive staging (for the current files and the remaining
> ones). This patch implements this functionality, and binds it to 'q'.
> ---
>
> I'm not familiar at all with the code in git-add--interactive.perl, so
> my code is mostly cut-and-pasted+adapted from the 'd' command.

You can say 'd' and then ^C, I think.
