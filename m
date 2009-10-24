From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 12:06:33 +0200
Message-ID: <m2ws2lt8ba.fsf@whitebox.home>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
	<20091023202524.GE4615@mx.loc> <20091023210648.GA23122@mx.loc>
	<7vocnxajj6.fsf@alter.siamese.dyndns.org>
	<20091024091758.GF4615@mx.loc> <m28wf1unop.fsf@whitebox.home>
	<m38wf1dsjf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 12:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1dWC-0002xW-TO
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 12:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbZJXKGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 06:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbZJXKGb
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 06:06:31 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47568 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbZJXKGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 06:06:31 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 061301C15492;
	Sat, 24 Oct 2009 12:06:34 +0200 (CEST)
X-Auth-Info: lnFoPmf8S5EO7AUejOoGILP/As/t3gdgOYYfv16gzVw=
Received: from whitebox.home (DSL01.83.171.146.84.ip-pool.NEFkom.net [83.171.146.84])
	by mail.mnet-online.de (Postfix) with ESMTP id B0E1B90171;
	Sat, 24 Oct 2009 12:06:34 +0200 (CEST)
Received: by whitebox.home (Postfix, from userid 501)
	id 89A131E5379; Sat, 24 Oct 2009 12:06:33 +0200 (CEST)
X-Yow: I joined scientology at a garage sale!!
In-Reply-To: <m38wf1dsjf.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Sat, 24 Oct 2009 02:56:33 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131158>

Jakub Narebski <jnareb@gmail.com> writes:

> I don't quite understand why 'o' has to be spelled using long name
> --no-same-owner, instead of just correcting the ordering of "old style"
> short options to have 'f' last, i.e.
>
>   $(TAR) xof -
>
> and not (current)
>
>   $(TAR) xfo -

Both do exactly the same, traditionally.  Note the lack of '-' preceding
'xfo', which does not use getopt-style option parsing.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
