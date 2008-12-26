From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] ls-tree: add --full-tree option
Date: Fri, 26 Dec 2008 09:16:45 +0100
Message-ID: <200812260916.45401.j6t@kdbg.org>
References: <7v63l7rc1s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Deskin Miller <deskinm@umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 09:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG7ta-00007J-CE
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 09:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394AbYLZIQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 03:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYLZIQu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 03:16:50 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:12840 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbYLZIQu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 03:16:50 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3E548CDF82;
	Fri, 26 Dec 2008 09:16:46 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id D64CE122F2;
	Fri, 26 Dec 2008 09:16:45 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v63l7rc1s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103923>

On Freitag, 26. Dezember 2008, Junio C Hamano wrote:
> This new option makes the command operate on the full tree object,
> regardless of where in the work tree it is run from.  It also implies the
> behaviour that is triggered by the existing --full-name option.

What's wrong with using 'git ls-tree ${rev}:'?

Except that it does not work and still silently inserts the subdirectory, 
which I consider a serious bug...

-- Hannes
