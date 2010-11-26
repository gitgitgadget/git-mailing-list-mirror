From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] git-send-email.perl: Deduplicate "to:" and "cc:"
 entries with names
Date: Fri, 26 Nov 2010 13:34:28 -0800
Message-ID: <1290807268.11971.310.camel@Joe-Laptop>
References: <1290272809.27951.30.camel@Joe-Laptop>
	 <m2mxp3zr88.fsf@igel.home> <1290286877.31117.15.camel@Joe-Laptop>
	 <4CE84FF3.2070906@pcharlan.com> <1290294365.31117.40.camel@Joe-Laptop>
	 <7vmxowq6gz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Pete Harlan <pgit@pcharlan.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 22:34:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM5wP-00010a-Gi
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 22:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab0KZVec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 16:34:32 -0500
Received: from mail.perches.com ([173.55.12.10]:1866 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab0KZVec (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 16:34:32 -0500
Received: from [192.168.1.162] (unknown [192.168.1.162])
	by mail.perches.com (Postfix) with ESMTP id 7AE4524368;
	Fri, 26 Nov 2010 13:34:28 -0800 (PST)
In-Reply-To: <7vmxowq6gz.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162279>

On Fri, 2010-11-26 at 10:34 -0800, Junio C Hamano wrote:
> I wonder if we should remove addresses from To: and Cc: if the same
> address appears in @bcclist, by the way, but that is a separate topic.

Most likely it should be culled from the bcclist.
