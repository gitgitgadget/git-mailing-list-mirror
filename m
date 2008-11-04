From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] git send-email: turn --compose on when more than one
 patch.
Date: Tue, 04 Nov 2008 15:54:54 -0800
Message-ID: <7vprlbnj1t.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
 <1225815858-30617-4-git-send-email-madcoder@debian.org>
 <1225815858-30617-5-git-send-email-madcoder@debian.org>
 <1225815858-30617-6-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:56:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxVlO-0006wl-4p
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038AbYKDXzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758953AbYKDXzJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:55:09 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55661 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760833AbYKDXzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:55:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 912F7793FF;
	Tue,  4 Nov 2008 18:55:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D1D4E793FD; Tue,
  4 Nov 2008 18:55:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 017A626C-AACC-11DD-8134-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100124>

Pierre Habouzit <madcoder@debian.org> writes:

> Automatically turn --compose on when there is more than one patch, and
> that the output is a tty.

I do not think this is a good idea.  I suspect I am not the only person
who uses "format-patch --cover-letter", edit the files to review and
prepare, and runs send-email to fire them off.
