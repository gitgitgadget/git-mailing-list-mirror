From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] No diff -b/-w output for all-whitespace changes
Date: Thu, 19 Nov 2009 23:14:35 +0100
Message-ID: <200911192314.41542.trast@student.ethz.ch>
References: <1258665144-26520-1-git-send-email-gbacon@dbresearch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <gitster@pobox.com>
To: Greg Bacon <gbacon@dbresearch.net>
X-From: git-owner@vger.kernel.org Thu Nov 19 23:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBFHr-00067c-RG
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 23:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbZKSWPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 17:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755664AbZKSWPX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 17:15:23 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:57025 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755647AbZKSWPW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 17:15:22 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 19 Nov
 2009 23:15:26 +0100
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Thu, 19 Nov
 2009 23:15:25 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <1258665144-26520-1-git-send-email-gbacon@dbresearch.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133262>

Greg Bacon wrote:
> Change git-diff's whitespace-ignoring modes to generate
> output only if a non-empty patch results, which git-apply
> rejects.

Judging from the test, this parses as

  Change git-diff's whitespace-ignoring modes to generate
  output only if a non-(empty patch, which git-apply
  rejects) results.

which is a bit weird, isn't it? :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
