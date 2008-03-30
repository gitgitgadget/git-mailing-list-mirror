From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with	non-ascii
 characters
Date: Sun, 30 Mar 2008 15:12:46 +1300
Message-ID: <47EEF71E.7060805@vilain.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803290944.55273.robin.rosenberg.lists@dewire.com> <20080329085304.GC19200@coredump.intra.peff.net> <200803291038.48847.robin.rosenberg.lists@dewire.com> <20080329095238.GB21814@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 30 04:10:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jfn0W-00078H-GF
	for gcvg-git-2@gmane.org; Sun, 30 Mar 2008 04:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbYC3CJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 22:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbYC3CJw
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 22:09:52 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60331 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbYC3CJv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 22:09:51 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id E6EA221C96F; Sun, 30 Mar 2008 15:09:49 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 5E95521C967;
	Sun, 30 Mar 2008 15:09:45 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <20080329095238.GB21814@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78495>

Jeff King wrote:
> Any idea what version of perl started shipping I18N::Langinfo? I
> couldn't see anything useful from grepping the Changes files.

Module::CoreList knows.  See the man page for that.

Sam.
