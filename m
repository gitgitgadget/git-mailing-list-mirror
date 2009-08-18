From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] tests: disable interactive hunk selection tests if perl not available
Date: Tue, 18 Aug 2009 10:33:32 +0200
Message-ID: <200908181033.33353.trast@student.ethz.ch>
References: <20090818061244.GA20659@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 10:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdK97-0007vJ-4p
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 10:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755015AbZHRId6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 04:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755013AbZHRId4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 04:33:56 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:22752 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbZHRIdz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 04:33:55 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 18 Aug
 2009 10:33:53 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Tue, 18 Aug
 2009 10:33:52 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <20090818061244.GA20659@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126358>

Jeff King wrote:
> +++ b/t/lib-patch-mode.sh
> @@ -1,5 +1,10 @@
>  . ./test-lib.sh
>  
> +if ! test_have_prereq PERL; then

Thanks.  I always forget about these little things...

Acked-By: Thomas Rast <trast@student.ethz.ch>

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
