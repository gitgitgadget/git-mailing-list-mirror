From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [BUG] git archive formats and dashdash
Date: Fri, 11 Dec 2009 00:25:03 +0200
Message-ID: <20091210222503.GA27840@Knoppix>
References: <20091210212636.GA27722@Knoppix>
 <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:25:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIrRh-0005uT-CW
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 23:25:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761960AbZLJWZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 17:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761937AbZLJWZB
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 17:25:01 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:59942 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761248AbZLJWZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 17:25:00 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id 91F3E18D299;
	Fri, 11 Dec 2009 00:25:06 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A00B5C8A04A; Fri, 11 Dec 2009 00:25:06 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 7B32C41BE3;
	Fri, 11 Dec 2009 00:25:04 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7v1vj2a3ik.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135045>

On Thu, Dec 10, 2009 at 02:05:39PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > --format option of git archive stops working if -- is used:
> 
> Good catch.  Is this a regression between 1.6.5 and the current code?

Doesn't appear to be so:

Based on quick look at source, it seems that this is indeed regression,
and the commit which introduced it is:

commit 0f4b377c20fb7d93f8bfeec39efb2b9392d6aebc
Author: Dmitry Potapov <dpotapov@gmail.com>
Date:   Mon Sep 14 00:17:01 2009 +0400

Describe: v1.6.5-rc1-7-g0f4b377 / v1.6.5-rc2~34

-Ilari
