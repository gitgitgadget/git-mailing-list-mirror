From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 20:27:17 +0100
Message-ID: <m21ut5dyei.fsf@igel.home>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
	<20111118034142.GA25228@elie.hsd1.il.comcast.net>
	<CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
	<buor516m3w7.fsf@dhlpc061.dev.necel.com>
	<CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Miles Bader <miles@gnu.org>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 20:27:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRU5w-0001hS-BA
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 20:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755713Ab1KRT1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 14:27:24 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:50374 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755407Ab1KRT1X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 14:27:23 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id D09DD1C1DA11;
	Fri, 18 Nov 2011 20:27:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id C8DA61C00101;
	Fri, 18 Nov 2011 20:27:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id aEFMTRUe+v3z; Fri, 18 Nov 2011 20:27:18 +0100 (CET)
Received: from igel.home (ppp-88-217-105-250.dynamic.mnet-online.de [88.217.105.250])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri, 18 Nov 2011 20:27:18 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id AEF1CCA29C; Fri, 18 Nov 2011 20:27:17 +0100 (CET)
X-Yow: Did I do an INCORRECT THING??
In-Reply-To: <CACsJy8BuCdT3rRjc5u6Ex5RRgSbL_0SFF0GW-dTGqet4sG2cwg@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Fri, 18 Nov 2011 18:34:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185675>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> OK it's not gcc problem. I upgraded to 4.5.3 and still had the same
> problem. I used ccache though. Without ccache, gcc produced correct
> .o.d files.

I'm also using ccache (version 3.1.3) and get correct dependencies.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
