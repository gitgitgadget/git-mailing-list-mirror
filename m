From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-merge: add option --no-ff
Date: Tue, 18 Sep 2007 19:30:41 +1200
Message-ID: <46EF7EA1.6020402@vilain.net>
References: <8c5c35580709170817s467fa7dv375952f872bba0e3@mail.gmail.com>	<11900461843997-git-send-email-hjemli@gmail.com>	<20070918005013.GA6368@muzzle>	<8c5c35580709172312w55613a1bw8cc58b200c526fab@mail.gmail.com> <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>, Eric Wong <normalperson@yhbt.net>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 09:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXXW2-0001UR-HH
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 09:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766AbXIRH2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 03:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754780AbXIRH2y
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 03:28:54 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42895 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbXIRH2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 03:28:54 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 1972723C262; Tue, 18 Sep 2007 19:28:53 +1200 (NZST)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 7B47820C2CA;
	Tue, 18 Sep 2007 19:28:48 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7v4phsxy55.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58537>

Junio C Hamano wrote:
> "Lars Hjemli" <hjemli@gmail.com> writes:
> 
>> On 9/18/07, Eric Wong <normalperson@yhbt.net> wrote:
>>> Would automatically enabling --no-ff when it detects merging of two (or
>>> more) SVN branches be a good thing?
>> I'd say 'git-svn merge' as a wrapper for 'git merge --no-ff' would be cleaner.
> 
> That unfortunately does not solve the problem.

I think we 'just' need to fix pushing merges back to SVN - so that they
properly set Subversion 1.5+ (and possibly SVK) merge attributes - and
if it is ambiguous which branch to push to, force the user to decide.

Sam.
