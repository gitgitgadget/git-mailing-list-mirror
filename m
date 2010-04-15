From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] format-patch: use current date in mbox 'From COMMIT DATE' header line
Date: Thu, 15 Apr 2010 17:35:31 +0200
Message-ID: <201004151735.31415.trast@student.ethz.ch>
References: <9946ffbdf26e7b08b9b00b87d4b575fea774be4c.1271342450.git.chris@arachsys.com> <20100415151619.GK12365@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 17:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2R6U-0004Hg-Jw
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 17:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab0DOPfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 11:35:34 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:25452 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab0DOPfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 11:35:33 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 15 Apr
 2010 17:35:32 +0200
Received: from thomas.localnet (129.132.210.61) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 15 Apr
 2010 17:35:32 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100415151619.GK12365@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144994>

Chris Webb wrote:
> Chris Webb <chris@arachsys.com> writes:
> 
> > Put the current date in the 'From COMMIT DATE' header line instead of using
> > the fixed date 'Mon Sep 17 00:00:00 2001'. A DATE_UTC mode for show_date() is
> > introduced so we can easily generate this line in the correct format.
> 
> ...but this will break t4013-diff-various which expects the exact date
> string 'Mon Sep 17 00:00:00 2001' in the mbox header. Patch to fix this test
> to follow!

Have you read

  http://thread.gmane.org/gmane.comp.version-control.git/124082/focus=124092

Not that I really care either way, but you should at least convince us
why it is broken as it stands :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
