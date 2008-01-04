From: Yannick Gingras <ygingras@ygingras.net>
Subject: Re: [PATCH] Documentation: rename gitlink macro to linkgit
Date: Fri, 04 Jan 2008 00:22:55 -0500
Message-ID: <873ateyxjk.fsf@enceladus.ygingras.net>
References: <87sl1mqt10.fsf@offby1.atm01.sea.blarg.net>
	<4775B87D.4010507@gmail.com>
	<20071229155705.GA23659@genesis.frugalware.org>
	<449c10960712290824yd2c5783l8d0ba91bbad95789@mail.gmail.com>
	<47767710.7040405@gmail.com>
	<7vejcypqsp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: asciidoc-discuss@lists.metaperl.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 06:23:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAf21-00037w-Eq
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 06:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbYADFXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 00:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbYADFXI
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 00:23:08 -0500
Received: from mail.cooptel.qc.ca ([216.144.115.12]:36071 "EHLO
	amy.cooptel.qc.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751426AbYADFXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 00:23:07 -0500
Received: (qmail 25403 invoked by uid 360); 4 Jan 2008 05:23:04 -0000
Received: from 216.144.118.66 by amy (envelope-from <ygingras@ygingras.net>, uid 301) with qmail-scanner-2.01 
 (clamdscan: 0.91.1/3957.  
 Clear:RC:1(216.144.118.66):. 
 Processed in 0.020966 secs); 04 Jan 2008 05:23:04 -0000
Received: from unknown (HELO verdandi.ygingras.net) (216.144.118.66)
  by smtp.cooptel.qc.ca with ESMTP; 4 Jan 2008 05:23:04 -0000
Received: from [192.168.0.15] (helo=enceladus.ygingras.net)
	by verdandi.ygingras.net with esmtp (Exim 4.50)
	id 1JAf1D-0001mD-JF; Fri, 04 Jan 2008 00:23:03 -0500
Received: from enceladus (localhost [127.0.0.1])
	by enceladus.ygingras.net (Postfix) with ESMTP id 473E518506;
	Fri,  4 Jan 2008 00:22:55 -0500 (EST)
In-Reply-To: <7vejcypqsp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 03 Jan 2008 13\:01\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: 192.168.0.15
X-SA-Exim-Rcpt-To: asciidoc-discuss@lists.metaperl.com, gitster@pobox.com, git@vger.kernel.org
X-SA-Exim-Mail-From: ygingras@ygingras.net
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on 
	verdandi.ygingras.net
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.5 tests=AWL autolearn=disabled 
	version=3.1.7
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on verdandi.ygingras.net)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69549>

Junio C Hamano <gitster@pobox.com> writes:

> Stuart, is there anything we can help you to set up some automated
> tests to catch AsciiDoc regression, so we do not have to suffer like
> this again?

We considered adding a nose test suite.  The upcoming v9.0 release
involves quite a bit of code massaging and we will definitely need an
extensive test suite.  But the test suite can only catch obvious
rendering failures so any help in eyeballing the output will be
appreciated.

Should we setup a distributed proof reading system like Project
Gutenberg?  I hope we don't need it.  But a few scripts to batch
render all the doc of popular projects would be nice.  We could upload
such snapshot render jobs where everyone could take a quick glance and
spot obvious rendering errors.

If you follow AsciiDoc's mailing list [1], we'll go through a series
of release candidates before the final 9.0.  "With enough eyeballs,
all bugs are shallow."

[1]: asciidoc-discuss@lists.metaperl.com

I reply to two mailing lists; I think this particular problem belongs
to asciidoc-discuss.

Best regards, 

-- 
Yannick Gingras
