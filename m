From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Re: Minor grammar fix in the 'Not a git repository'
 message
Date: Mon, 16 Feb 2009 16:51:03 -0800
Message-ID: <7vk57pevig.fsf@gitster.siamese.dyndns.org>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de>
 <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de> <7vd4diez2z.fsf@gitster.siamese.dyndns.org> <20090217001747.GA23278@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 01:52:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZECX-00075p-7z
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZBQAvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbZBQAvK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:51:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39531 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbZBQAvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:51:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C39892B48D;
	Mon, 16 Feb 2009 19:51:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2EB4D2B47D; Mon,
 16 Feb 2009 19:51:05 -0500 (EST)
In-Reply-To: <20090217001747.GA23278@vidovic> (Nicolas Sebrecht's message of
 "Tue, 17 Feb 2009 01:17:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1077B400-FC8D-11DD-A3AF-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110274>

Nicolas Sebrecht <nicolas.s-dev@laposte.net> writes:

> The message
> 	"Not inside a git repository" 
> of Wincent looks like the clearest and the fairest one.

I tend to agree.  I was only trying to see if we can salvage a more
precise diagnosis f66bc5f (Always show which directory is not a git
repository, 2008-12-22) tried to give users, but to do it throughly the
sentence will become even more awkward.

    "Not inside a bare git repository nor a work tree that has .git/ somewhere in it."
