From: Sergei Organov <osv@javad.com>
Subject: Re: The meaning of x~0 and x~ as rev-spec.
Date: Fri, 14 Mar 2008 20:21:30 +0300
Message-ID: <87zlt1mdb9.fsf@osv.gnss.ru>
References: <87bq5ho31d.fsf@osv.gnss.ru>
	<7vwso5p92q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDcB-00085T-QK
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755924AbYCNRV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbYCNRV5
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:21:57 -0400
Received: from javad.com ([216.122.176.236]:1403 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbYCNRV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:21:57 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id m2EHLaV02829;
	Fri, 14 Mar 2008 17:21:36 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1JaDb0-0004zj-TP; Fri, 14 Mar 2008 20:21:30 +0300
In-Reply-To: <7vwso5p92q.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 14 Mar 2008 09\:24\:45 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77255>

Junio C Hamano <gitster@pobox.com> writes:

> Sergei Organov <osv@javad.com> writes:
>
>> Testing suggests that <name>~0 and <name>~ are the same and are just
>> synonyms for <name> as rev-specs. Is that correct? Is that by design, or
>> by accident?
>
> sed -n -e '/name~3/,/x = 0;/p' sha1_name.c

OK, I'll send a patch for documentation.

-- Sergei.
