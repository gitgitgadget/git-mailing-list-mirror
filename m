From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the
 callback data of git-config.
Date: Tue, 10 Mar 2009 09:36:56 -0700
Message-ID: <7vzlft8hcn.fsf@gitster.siamese.dyndns.org>
References: <1236690219.20402.28.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 17:38:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh4yR-0005be-40
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 17:38:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbZCJQhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 12:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753665AbZCJQhF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 12:37:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938AbZCJQhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 12:37:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6EA7DA0B5F;
	Tue, 10 Mar 2009 12:37:02 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2CAAFA0B5E; Tue,
 10 Mar 2009 12:36:57 -0400 (EDT)
In-Reply-To: <1236690219.20402.28.camel@luis-desktop> (Carlos Rica's message
 of "Tue, 10 Mar 2009 14:03:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AEF3528C-0D91-11DE-B93F-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112831>

Carlos Rica <jasampler@gmail.com> writes:

> Signed-off-by: Carlos Rica <jasampler@yahoo.es>
> ---
>
> This way the data flow is much clearer.

Good.  I think the Subject is backwards, though.
