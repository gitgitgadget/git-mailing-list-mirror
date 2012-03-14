From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 1/3] Demonstrate a bug in --word-diff where diff.*.wordregex
 is "sticky"
Date: Wed, 14 Mar 2012 22:53:29 +0100
Message-ID: <4F611359.70109@kdbg.org>
References: <3bb99e938624ae674674b304c24c48b9dc05871b.1331749299.git.trast@student.ethz.ch> <7vsjhboujp.fsf@alter.siamese.dyndns.org> <4F60F67D.9050003@kdbg.org> <7vhaxqoobe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7w8Y-0004nX-UU
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 22:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031026Ab2CNVxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 17:53:33 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:29020 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760725Ab2CNVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 17:53:32 -0400
X-Greylist: delayed 7388 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Mar 2012 17:53:32 EDT
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 4583613004A;
	Wed, 14 Mar 2012 22:53:29 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9A55319F458;
	Wed, 14 Mar 2012 22:53:29 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <7vhaxqoobe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193166>

Am 14.03.2012 22:38, schrieb Junio C Hamano:
> Thanks, but using a.tex and z.tex and marking only the former as tex
> does not change anything in the puzzlement I mentioned in my response.

Oh, I see. I didn't notice this detail. Please squash in your proposed
fixup that uses z.txt.

Thanks,
-- Hannes
