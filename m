From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t4027, t4041: Use printf instead of echo -n
Date: Thu, 24 Jun 2010 21:34:53 +0200
Message-ID: <201006242134.54081.j6t@kdbg.org>
References: <1277401578-20984-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:35:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORsCW-0005b1-BA
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab0FXTe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 15:34:58 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:50351 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751769Ab0FXTe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 15:34:57 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CEBEDA7EB7;
	Thu, 24 Jun 2010 21:34:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 317A319F792;
	Thu, 24 Jun 2010 21:34:54 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <1277401578-20984-1-git-send-email-brian@gernhardtsoftware.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149626>

On Donnerstag, 24. Juni 2010, Brian Gernhardt wrote:
> BSD's echo doesn't recognize the -n option, so use printf instead
...
> -	echo -n "" | test_cmp - actual2 &&
> +	printf "" | test_cmp - actual2 &&

Shouldn't you replace these by

	! test -s actual2 &&

-- Hannes
