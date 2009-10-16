From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] grep: do not segfault when -f is used
Date: Fri, 16 Oct 2009 12:34:23 +0200
Message-ID: <4AD84C2F.5000809@viscovery.net>
References: <1255683204-28988-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Fri Oct 16 12:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MykCl-0004z7-5o
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 12:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756408AbZJPKfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 06:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbZJPKfF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 06:35:05 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:49880 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbZJPKfE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 06:35:04 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Myk8e-0007FZ-61; Fri, 16 Oct 2009 12:34:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D84DEA4A1; Fri, 16 Oct 2009 12:34:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1255683204-28988-1-git-send-email-kraai@ftbfs.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130473>

Matt Kraai schrieb:
> "git grep" would segfault if its -f option was used because it would
> try to use an uninitialized strbuf, so initialize the strbuf.

Thanks for noticing and for the patch.

But...

> +test_expect_success 'grep should not segfault with -f' '
> +        test_must_fail git grep -f /dev/null
> +'

there must be a better way to test whether grep -f behaves correctly.

-- Hannes
