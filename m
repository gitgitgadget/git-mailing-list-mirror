From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag.c: remove global variable to use the
 callback data of git-config.
Date: Sat, 14 Mar 2009 13:54:48 -0700
Message-ID: <7vprgjakpz.fsf@gitster.siamese.dyndns.org>
References: <1237015035.9952.10.camel@luis-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, gitster@pobox.com
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:56:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiauA-0001tc-US
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754376AbZCNUy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZCNUy6
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:54:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbZCNUy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:54:58 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C3F3A6861;
	Sat, 14 Mar 2009 16:54:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 16E856860; Sat,
 14 Mar 2009 16:54:51 -0400 (EDT)
In-Reply-To: <1237015035.9952.10.camel@luis-desktop> (Carlos Rica's message
 of "Sat, 14 Mar 2009 08:17:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 600AD61C-10DA-11DE-93DB-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113263>

Carlos Rica <jasampler@gmail.com> writes:

> Signed-off-by: Carlos Rica <jasampler@gmail.com>
> ---
>
> Here I declare a struct to wrap the new local array along with its size.
> QUESTION: An alternative to this is strbuf, would it be preferable?

The command already uses strbuf for other purposes, so why not?
