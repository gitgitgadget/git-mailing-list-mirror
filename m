From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Best single user practice
Date: Sun, 10 Oct 2010 17:33:34 +0200
Message-ID: <m21v7yvz8x.fsf@igel.home>
References: <loom.20101009T233356-82@post.gmane.org>
	<DAA5096E-00DF-4454-A905-EA2E10329DBB@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maaartin <grajcar1@seznam.cz>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 17:35:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4xvm-0001yY-FH
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 17:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab0JJPdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 11:33:37 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:47091 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240Ab0JJPdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 11:33:36 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id F056D1C15451;
	Sun, 10 Oct 2010 17:33:34 +0200 (CEST)
Received: from igel.home (ppp-93-104-129-211.dynamic.mnet-online.de [93.104.129.211])
	by mail.mnet-online.de (Postfix) with ESMTP id B8C311C0008F;
	Sun, 10 Oct 2010 17:33:34 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 8ECFACA2A0; Sun, 10 Oct 2010 17:33:34 +0200 (CEST)
X-Yow: Yow!  Am I cleansed yet?!
In-Reply-To: <DAA5096E-00DF-4454-A905-EA2E10329DBB@sb.org> (Kevin Ballard's
	message of "Sat, 9 Oct 2010 15:44:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158676>

Kevin Ballard <kevin@sb.org> writes:

> On Oct 9, 2010, at 3:24 PM, Maaartin wrote:
>
>> - Because of the low version, I can't use "git init --bare" on the server. So I 
>> create an usual depository and change the configuration to bare=true. Is it OK 
>> (I really don't mind the repo being placed in DIR/.git instead of DIR itself.)?
>
> `git init --bare` is incorrect anyway. What you really want is `git --bare init`.

`git init --bare' has been added in 1.5.6 as a synonym for `git --bare init'.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
