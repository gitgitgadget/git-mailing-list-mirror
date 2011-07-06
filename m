From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 14/14] revert: Change insn sheet format
Date: Wed, 6 Jul 2011 05:33:21 -0500
Message-ID: <20110706103321.GK15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-15-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 12:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QePQB-0004AA-JW
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 12:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457Ab1GFKd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 06:33:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61820 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab1GFKd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 06:33:26 -0400
Received: by iwn6 with SMTP id 6so5958061iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wac/T8dHcnxw8A9omZapfGurJBXb1MKbBwG1Mxfs3AE=;
        b=cZH7q+3JeBs6bbwej4K1q2PRhjdEV7CJIkkKAQB3cNSh8jpjGSZ+E2Tftxs8IN/lZq
         3m4f3PJdg7ax18Akhq/+rWKIsUS4j/p4mIbJdhvyxD7iQSdxdM9N0gPxVDSU4N+4Hrrc
         /dHpA/WrfDKYbw+nDpzpOIbsSu4Df46J6NJis=
Received: by 10.42.27.137 with SMTP id j9mr5259729icc.311.1309948405551;
        Wed, 06 Jul 2011 03:33:25 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id ft12sm4794042ibb.53.2011.07.06.03.33.23
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 03:33:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309938868-2028-15-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176682>

Ramkumar Ramachandra wrote:

>  I've intentionally left parse_cmdline_args unimplemented
[...]
>                  Existing implementations in libraries like Glib are
>  much too heavyweight.

Wait, how did glib enter the picture? :)  The implementation of
shell-style quoting in [1] is not very complicated; perhaps it could
complement git's existing parsers for shell-style single-quoted
expressions and C-style double-quoted expressions in quote.c.

Of course, a more basic question is whether we want to allow passing
arbitrary command-line arguments through the insn sheet at all (a
part of me wishes "no", at least at first).

Could you give an example to illustrate what this functionality would
be used for?  I can understand wanting to pass "-s" and "-X" flags to
a merge insn and "-X" to pick, but that's as far as my imagination
goes.

> [1]: http://article.gmane.org/gmane.comp.version-control.git/162198
