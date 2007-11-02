From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Fri, 02 Nov 2007 12:11:19 -0700
Message-ID: <7vtzo431k8.fsf@gitster.siamese.dyndns.org>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
	<20071031195702.GB24332@atjola.homenet> <874pg73u6h.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0710312111170.4362@racer.site>
	<7vhck7gdzs.fsf@gitster.siamese.dyndns.org>
	<87ve8m2mfn.fsf@osv.gnss.ru>
	<Pine.LNX.4.64.0711011423440.4362@racer.site>
	<20071101151016.GA26103@fieldses.org>
	<7v8x5hbtvv.fsf@gitster.siamese.dyndns.org> <472AF840.1070609@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sergei Organov <osv@javad.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Nov 02 20:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io1vm-0006fZ-Bi
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 20:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039AbXKBTL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753886AbXKBTL3
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 15:11:29 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:47991 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbXKBTL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 15:11:28 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E595B2F2;
	Fri,  2 Nov 2007 15:11:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 5FB2F9093F;
	Fri,  2 Nov 2007 15:11:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63157>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>>
>> Now, we have established that this is a real problem worth
>> solving, what's next?
>
> Make "git rebase --skip" skip patches regardless of tree and index state,
> but still refuse to *start* with dirty tree or index. That way, there's
> no risk of losing anything that can't be re-created unless the user asks
> for it.

Sounds like a plan.
