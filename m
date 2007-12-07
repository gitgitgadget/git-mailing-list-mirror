From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this version of git
Date: Fri, 07 Dec 2007 11:29:15 -0800
Message-ID: <7vbq921eyc.fsf@gitster.siamese.dyndns.org>
References: <87hciv7jkt.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de>
	<87d4ti7qu1.fsf@osv.gnss.ru>
	<7vodd23i1v.fsf@gitster.siamese.dyndns.org>
	<871w9y7mei.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 20:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0ize-00066x-DF
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 20:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbXLGTfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 14:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbXLGTft
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 14:35:49 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:33872 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbXLGTfs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 14:35:48 -0500
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2007 14:35:48 EST
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D9371A7E;
	Fri,  7 Dec 2007 14:29:25 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A9A21A7A;
	Fri,  7 Dec 2007 14:29:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67446>

Sergei Organov <osv@javad.com> writes:

> First, I don't think you need to clarify like this. It is just
> implementation detail of git-help that it uses 'man', and thus
> implicitly relies on MANPATH. The essential thing has been already
> stated above: git-help should show correct documentation.

Ok, this is a good argument for the patch.  With Christian's
enhancements, we will handle -i(nfo) and -w(eb) and we will tell the
"info" and "html" browsers where the documentation we installed for the
running instance of git is, so we should do so consistently for
"manpage" browser (aka "man").  You are right.
