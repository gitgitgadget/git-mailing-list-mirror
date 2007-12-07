From: Sergei Organov <osv@javad.com>
Subject: Re: [PATCH] Let git-help prefer man-pages installed with this version of git
Date: Fri, 07 Dec 2007 15:49:20 +0300
Message-ID: <87prxi6567.fsf@osv.gnss.ru>
References: <87hciv7jkt.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0712062107520.21625@wbgn129.biozentrum.uni-wuerzburg.de>
	<87d4ti7qu1.fsf@osv.gnss.ru>
	<7vodd23i1v.fsf@gitster.siamese.dyndns.org>
	<871w9y7mei.fsf@osv.gnss.ru> <47593EB2.3020309@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Dec 07 13:55:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0cje-0007ed-4j
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 13:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295AbXLGMy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 07:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbXLGMy4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 07:54:56 -0500
Received: from javad.com ([216.122.176.236]:1189 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbXLGMy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 07:54:56 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lB7CnRU27431;
	Fri, 7 Dec 2007 12:49:27 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1J0cds-0003db-Rh; Fri, 07 Dec 2007 15:49:20 +0300
In-Reply-To: <47593EB2.3020309@op5.se> (Andreas Ericsson's message of "Fri\, 07 Dec 2007 13\:38\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67422>

Andreas Ericsson <ae@op5.se> writes:
> Sergei Organov wrote:
[...]
>> To tell the truth, I'd prefer to just use -M option of man and don't
>> rely on MANPATH at all, so that 'git help' will issue error if there is
>> no documentation installed for this particular version of git.
>>
>
> Does "man -M" work everywhere, or is your patch opening a can of worms
> to get probably-not-needed functionality?

This patch doesn't use "man -M", it tweaks MANPATH instead. Partly because
the rest of 'git' tweaks 'PATH' to get correct executable to be run, and
not run it using explicit absolute path, so tweaking MANPATH is
consistent with the rest of git.

-- 
Sergei.
