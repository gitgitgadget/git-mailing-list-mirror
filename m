From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: upload-pack is slow with lots of refs
Date: Tue, 09 Oct 2012 22:46:42 +0200
Message-ID: <50748D32.8020907@kdbg.org>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com> <20121003180324.GB27446@sigill.intra.peff.net> <7vobkj4cb4.fsf@alter.siamese.dyndns.org> <20121003185542.GA3635@sigill.intra.peff.net> <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com> <506E7D01.8080509@viscovery.net> <CAJo=hJsYVdWeG0ZyqexEXNfOq_k1XDR_gGP+fy_z==LvdnWJTQ@mail.gmail.com> <5072EBD1.40500@kdbg.org> <CAJo=hJsJgqZqPxucRcSgYSa0N3pcw5seT9vcu2BE8WwfJVrvKQ@mail.gmail.com> <5074894D.90307@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 22:46:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLghc-0007ow-0V
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 22:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab2JIUqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 16:46:45 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:51525 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753276Ab2JIUqo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 16:46:44 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 73739130047;
	Tue,  9 Oct 2012 22:46:43 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C565C19F3D5;
	Tue,  9 Oct 2012 22:46:42 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <5074894D.90307@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207344>

Am 09.10.2012 22:30, schrieb Johannes Sixt:
> Am 09.10.2012 08:46, schrieb Shawn Pearce:
>> As it turns out we don't really have this problem with git://. Clients
>> can bury a v2 request in the extended headers where the host line
>> appears today.
> 
> I tried, but it seems that todays git-daemons are too strict and accept
> only \0host=foo\0, nothing else :-(

I take that back: Modern git-daemons accept "\0host=foo\0\0version=2\0",
as you said.

It looks like SSH is the only stubborn protocol.

-- Hannes
