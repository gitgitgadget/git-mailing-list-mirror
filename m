From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: wishlist: git gui not listing untracked files in unstaged list
Date: Thu, 11 Mar 2010 13:52:59 +0100
Message-ID: <m24oknc95g.fsf@igel.home>
References: <loom.20100310T203316-38@post.gmane.org>
	<7vaaugrlqs.fsf@alter.siamese.dyndns.org>
	<20100310200728.GD21994@spearce.org>
	<loom.20100310T225229-469@post.gmane.org>
	<20100310221228.GA4223@sigill.intra.peff.net>
	<20100310221403.GF21994@spearce.org>
	<20100310223210.GC4223@sigill.intra.peff.net>
	<4B9896D4.2020106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Patrick Higgins <patrick133t@yahoo.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 11 13:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npht4-0007MP-U8
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 13:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757811Ab0CKMxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 07:53:09 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35970 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab0CKMxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 07:53:07 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 901331C00361;
	Thu, 11 Mar 2010 13:53:01 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.6.166])
	by mail.m-online.net (Postfix) with ESMTP id 1B03D902FD;
	Thu, 11 Mar 2010 13:53:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.6.166]) (amavisd-new, port 10024)
	with ESMTP id wZv9CZocMxn9; Thu, 11 Mar 2010 13:53:00 +0100 (CET)
Received: from igel.home (DSL01.83.171.161.144.ip-pool.NEFkom.net [83.171.161.144])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 11 Mar 2010 13:52:59 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id C874FCA297; Thu, 11 Mar 2010 13:52:59 +0100 (CET)
X-Yow: He is the MELBA-BEING...  the ANGEL CAKE...
  XEROX him...  XEROX him --
In-Reply-To: <4B9896D4.2020106@viscovery.net> (Johannes Sixt's message of
	"Thu, 11 Mar 2010 08:08:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141959>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Jeff King schrieb:
>> On Wed, Mar 10, 2010 at 02:14:03PM -0800, Shawn O. Pearce wrote:
>>> I'd say its git-gui, yes?  Doesn't my shell automatically do
>>> --exclude-from=~/my.list for me?  Its not the command's job
>>> to do that expansion.
>> 
>> It depends on the shell. Bash will expand it in _some_ cases (but not
>> this one). Dash never will:
>> 
>>   $ echo $BASH_VERSION
>>   4.1.0(1)-release
>>   $ echo foo=~/foo ;# expands
>>   foo=/home/peff/foo
>
> This is wrong, FWIW.

It's a bash extension and disabled in POSIX mode.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
