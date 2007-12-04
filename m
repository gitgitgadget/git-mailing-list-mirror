From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 04 Dec 2007 10:05:40 -0800
Message-ID: <7vve7e49or.fsf@gitster.siamese.dyndns.org>
References: <20071204130922.731c407a@pc09.procura.nl>
	<Pine.LNX.4.64.0712041343040.27959@racer.site>
	<20071204140326.14d9e7a0@pc09.procura.nl>
	<Pine.LNX.4.64.0712041439590.27959@racer.site>
	<20071204150102.7f3ec3e9@pc09.procura.nl> <47556EE2.6040105@op5.se>
	<20071204152240.6cb6018e@pc09.procura.nl>
	<Pine.LNX.4.64.0712041536180.27959@racer.site>
	<20071204155655.053f4fb4@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 04 19:06:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzcAH-00022w-Ap
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 19:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbXLDSFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 13:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752195AbXLDSFu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 13:05:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47625 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbXLDSFt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 13:05:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 035632F9;
	Tue,  4 Dec 2007 13:06:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BDA79CD74;
	Tue,  4 Dec 2007 13:06:04 -0500 (EST)
In-Reply-To: <20071204155655.053f4fb4@pc09.procura.nl> (H. Merijn Brand's
	message of "Tue, 4 Dec 2007 15:56:55 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67072>

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> On Tue, 4 Dec 2007 15:39:47 +0000 (GMT), Johannes Schindelin
> ...
> I found it! unset returns false
> ...
> I must leave now.

Thanks, you two.

I do not see "unset VAR... &&" outside t0001 test, but there are
instances of "unset VAR... &&" in git-submodule implementations as well.

In short, not too many places to fix.
