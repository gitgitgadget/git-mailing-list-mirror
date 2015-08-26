From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Git's inconsistent command line options
Date: Wed, 26 Aug 2015 08:28:36 +0200
Message-ID: <877foief6z.fsf@igel.home>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CA+P7+xoQnq-nCP=_Wtfh39fxxwTvEo+m-=o7fcmrdyaBBfbt8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 08:28:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUUCV-00071o-AH
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 08:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbbHZG2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 02:28:43 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47013 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbbHZG2m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 02:28:42 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3n1HMC1fHhz3hhnP;
	Wed, 26 Aug 2015 08:28:39 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3n1HMC0GnSzvh2K;
	Wed, 26 Aug 2015 08:28:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id GudtkpCX1ZYa; Wed, 26 Aug 2015 08:28:37 +0200 (CEST)
X-Auth-Info: mO8lPBSssYj0CuoXjD/ExW0ZIbG2H/vRNVhYZ59JhTn7OMxf1kGyBNuaKjapmNec
Received: from igel.home (ppp-93-104-186-179.dynamic.mnet-online.de [93.104.186.179])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed, 26 Aug 2015 08:28:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id B24F32C0833; Wed, 26 Aug 2015 08:28:36 +0200 (CEST)
X-Yow: Am I accompanied by a PARENT or GUARDIAN?
In-Reply-To: <CA+P7+xoQnq-nCP=_Wtfh39fxxwTvEo+m-=o7fcmrdyaBBfbt8A@mail.gmail.com>
	(Jacob Keller's message of "Tue, 25 Aug 2015 21:09:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276597>

Jacob Keller <jacob.keller@gmail.com> writes:

> "if you really mean to create a tag named create, use
>
> git tag -- create master

In all other uses of -- refs must be put on the *left* side.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
