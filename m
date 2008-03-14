From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The meaning of x~0 and x~ as rev-spec.
Date: Fri, 14 Mar 2008 09:24:45 -0700
Message-ID: <7vwso5p92q.fsf@gitster.siamese.dyndns.org>
References: <87bq5ho31d.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 17:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaCiy-0000vh-8J
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 17:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbYCNQZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 12:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132AbYCNQZB
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 12:25:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58646 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYCNQZA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 12:25:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 51C7D1A69;
	Fri, 14 Mar 2008 12:24:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 82E2B1A3E; Fri, 14 Mar 2008 12:24:53 -0400 (EDT)
In-Reply-To: <87bq5ho31d.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
 14 Mar 2008 16:20:30 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77252>

Sergei Organov <osv@javad.com> writes:

> Testing suggests that <name>~0 and <name>~ are the same and are just
> synonyms for <name> as rev-specs. Is that correct? Is that by design, or
> by accident?

sed -n -e '/name~3/,/x = 0;/p' sha1_name.c
