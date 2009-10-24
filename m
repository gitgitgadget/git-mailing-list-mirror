From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 12:44:46 +0200
Message-ID: <m2ocnxt6jl.fsf@whitebox.home>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
	<20091023202524.GE4615@mx.loc> <20091023210648.GA23122@mx.loc>
	<7vocnxajj6.fsf@alter.siamese.dyndns.org>
	<20091024091758.GF4615@mx.loc> <m28wf1unop.fsf@whitebox.home>
	<20091024100502.GG4615@mx.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 12:49:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1eBP-0003VD-3z
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 12:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbZJXKoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 06:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbZJXKoo
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 06:44:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46998 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbZJXKoo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 06:44:44 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 387D41C154F0;
	Sat, 24 Oct 2009 12:44:46 +0200 (CEST)
X-Auth-Info: uxQ7c9+GrvExufGAu677ZmIhamcA3MJaP83UGdbMgrs=
Received: from whitebox.home (DSL01.83.171.146.84.ip-pool.NEFkom.net [83.171.146.84])
	by mail.mnet-online.de (Postfix) with ESMTP id D8ABF90289;
	Sat, 24 Oct 2009 12:44:46 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id 595F31E5379; Sat, 24 Oct 2009 12:44:46 +0200 (CEST)
X-Yow: I was in a HOT TUB!  I was NORMAL!  I was ITALIAN!!  I enjoyed th'
 EARTHQUAKE!
In-Reply-To: <20091024100502.GG4615@mx.loc> (Bernhard Reutner-Fischer's
	message of "Sat, 24 Oct 2009 12:05:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131159>

Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:

> On Sat, Oct 24, 2009 at 11:49:10AM +0200, Andreas Schwab wrote:
>>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>>
>>> I suppose xf - -o would work?
>>
>>Isn't that the same as 'xfo -'?
>
> Not really (if you do not permute the arguments which we don't in
> busybox, for size reasons).

There is no argument permutation.  The traditional argument parsing of
tar does not cluster option letters with option arguments.

Of course, just using 'xof -' will work around this busybox bug.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
