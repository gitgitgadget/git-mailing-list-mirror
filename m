From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: RFC: reverse bisect
Date: Thu, 29 Sep 2011 18:27:07 +0200
Message-ID: <4E849C5B.7050201@kdbg.org>
References: <20110929142027.GA4936@zelva.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michal Vyskocil <mvyskocil@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:27:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9JSD-0006L6-JP
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab1I2Q1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 12:27:13 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:48025 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752292Ab1I2Q1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:27:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2A34010028;
	Thu, 29 Sep 2011 18:25:58 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9922F19F47E;
	Thu, 29 Sep 2011 18:27:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.22) Gecko/20110907 SUSE/3.1.14 Thunderbird/3.1.14
In-Reply-To: <20110929142027.GA4936@zelva.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182405>

Am 29.09.2011 16:20, schrieb Michal Vyskocil:
> git bisect start --reverse HEAD~999 HEAD

With the regular meaning of the start subcommand, the revs given are
ordered: bad good good...

With the reversed meaning, this would have to become: good bad bad...

This would have to be mentioned clearly in the documentation.

> git bisect good/bad/skip/run

Last time this came up on the list I suggested to add the following
commands:

   git bisect regression  # a synonym for git bisect start
   git bisect improvement # your --reverse

-- Hannes
