From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [remote rejected] master -> master (n/a (unpacker error))
Date: Thu, 13 May 2010 15:22:08 +0200
Message-ID: <m2r5lgaqdb.fsf@igel.home>
References: <AANLkTinV2U6Lbbl0N7jVAESEi0mZQ_D3slMEYa68vRT4@mail.gmail.com>
	<20100513005218.GA20655@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Buck <buck.robert.j@gmail.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>,
	Chris Packham <judge.packham@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 15:22:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCYMm-0003OI-1r
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 15:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782Ab0EMNWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 09:22:13 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39444 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab0EMNWL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 09:22:11 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id B0F131C00518;
	Thu, 13 May 2010 15:22:09 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A87199112D;
	Thu, 13 May 2010 15:22:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id oGYdJo37dLZ2; Thu, 13 May 2010 15:22:08 +0200 (CEST)
Received: from igel.home (ppp-88-217-107-177.dynamic.mnet-online.de [88.217.107.177])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 13 May 2010 15:22:08 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7A3EFCA297; Thu, 13 May 2010 15:22:08 +0200 (CEST)
X-Yow: I feel better about world problems now!
In-Reply-To: <20100513005218.GA20655@progeny.tock> (Jonathan Nieder's message
	of "Wed, 12 May 2010 19:52:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147003>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In your case, all 16384 trials yielded the same result: file already
> existed.

IMHO it is much more likely that a race happened between two git
processes each wanting to create the .git/objects/e6 directory.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
