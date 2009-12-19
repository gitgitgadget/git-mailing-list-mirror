From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCHv2] am: fix patch format detection for Thunderbird "Save As" emails
Date: Sat, 19 Dec 2009 11:26:47 +0100
Message-ID: <m2y6kzi7iw.fsf@igel.home>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>
	<1261172078-9174-1-git-send-email-bebarino@gmail.com>
	<loom.20091218T223918-175@post.gmane.org>
	<1261173577.14059.5.camel@swboyd-laptop>
	<loom.20091218T234129-280@post.gmane.org> <4B2C395A.6080300@gmail.com>
	<4B2C66D3.1070508@byu.net> <4B2C70ED.1020602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Blake <ebb9@byu.net>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 11:27:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLwWX-0000Sp-BJ
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 11:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbZLSK0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 05:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbZLSK0x
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 05:26:53 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:45776 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760AbZLSK0v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 05:26:51 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 0721E1C15C3C;
	Sat, 19 Dec 2009 11:26:49 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 0560F9048A;
	Sat, 19 Dec 2009 11:26:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id yIz3AP1Mzdlv; Sat, 19 Dec 2009 11:26:47 +0100 (CET)
Received: from igel.home (DSL01.83.171.167.154.ip-pool.NEFkom.net [83.171.167.154])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 19 Dec 2009 11:26:47 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9EBDFCA28C; Sat, 19 Dec 2009 11:26:47 +0100 (CET)
X-Yow: Hmmm...  a PINHEAD, during an EARTHQUAKE, encounters an ALL-MIDGET FIDDLE
 ORCHESTRA...  ha..  ha..
In-Reply-To: <4B2C70ED.1020602@gmail.com> (Stephen Boyd's message of "Fri, 18
	Dec 2009 22:21:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135470>

Stephen Boyd <bebarino@gmail.com> writes:

> On 12/18/2009 09:38 PM, Eric Blake wrote:
>> Closer, but not there yet.  "$/" is still not defined.  Then, as a matter
>> of style, '\' is more readable than "\\" for representing a backslash.  So
>> as long as we are shifting to '', we might as well do it everywhere in
>> that line - write it like this:
>>
>> } | sed -e 's/$/;/' | tr ';' '\015'>  patch1-crlf.eml
>>
>> and you should be set.
>
> Ah, I think you missed that this stuff is inside single quotes already. I
> would love to just do what you suggest here.

You can replace every use of ' by '\''.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
