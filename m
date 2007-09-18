From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Wed, 19 Sep 2007 01:25:23 +1200
Message-ID: <46EFD1C3.4080008@vilain.net>
References: <20070918072627.GB3506@coredump.intra.peff.net> <Pine.LNX.4.64.0709181115250.28586@racer.site> <46EFA84C.3080906@op5.se> <20070918103051.GA22239@coredump.intra.peff.net> <Pine.LNX.4.64.0709181217200.28586@racer.site> <46EFBD40.1070102@vilain.net> <Pine.LNX.4.64.0709181334210.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 15:24:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXd40-0001kc-Fp
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 15:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbXIRNY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 09:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757192AbXIRNY0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 09:24:26 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48674 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757173AbXIRNYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 09:24:25 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 3FB4023C266; Wed, 19 Sep 2007 01:24:24 +1200 (NZST)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 6776623C266;
	Wed, 19 Sep 2007 01:24:19 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <Pine.LNX.4.64.0709181334210.28586@racer.site>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58606>

Johannes Schindelin wrote:
>> I personally want to be able to dump patches, including merges, to
>> git-format-patch format, in such a way that all other information (eg,
>> committer, date, etc) is preserved.
>>     
>
> We already talked about that on IRC, and you have not even _begun_ to 
> think about the fundamental issues with merges-in-a-patch.  I mentioned a 
> few on IRC, and am still awaiting your reply.
>   

Well, you could store diffs from both parents, or a custom diff format
that marks different ancestors, etc. Sure, they wouldn't apply with
'patch', but that's the breaks.

I don't see the encoding of the information as such a fundamental and
insurmountable issue. Why do you consider it so?

Sam.
