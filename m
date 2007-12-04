From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] install-sh from automake does not like -m without delimiting space
Date: Mon, 03 Dec 2007 17:02:10 -0800
Message-ID: <7v1wa3e0h9.fsf@gitster.siamese.dyndns.org>
References: <20071201170540.GS11347@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzMBI-0001ru-MR
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXLDBCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXLDBCR
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:02:17 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59725 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbXLDBCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:02:16 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 39CFE320;
	Mon,  3 Dec 2007 20:02:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 9F39F9CA9C;
	Mon,  3 Dec 2007 20:02:33 -0500 (EST)
In-Reply-To: <20071201170540.GS11347@schiele.dyndns.org> (Robert Schiele's
	message of "Sat, 1 Dec 2007 18:05:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66984>

Robert Schiele <rschiele@gmail.com> writes:

> The install-sh script as shipped with automake requires a space between
> the -m switch and its argument.  Since this is also the regular way of
> doing it with other install implementations this change inserts the
> missing space in all makefiles.

I do not think this is risky, so I'll take it but please yell if it
breaks some existing setups.

I'll ask Shawn to do that part separately.

Thanks.
