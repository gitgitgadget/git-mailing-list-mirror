From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: recursive aliases
Date: Fri, 24 Sep 2010 00:49:45 +0200
Message-ID: <m239t0gjna.fsf@igel.home>
References: <AANLkTi=VDmyhUDYKc38bOZWLncZ_twQGB2n5KgbgP_tf@mail.gmail.com>
	<4C9B3B2A.2080604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramana Kumar <ramana.kumar@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 24 00:50:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyucC-0007O5-86
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 00:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab0IWWtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 18:49:49 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35678 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab0IWWtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 18:49:49 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id AF2F41C15A56;
	Fri, 24 Sep 2010 00:49:46 +0200 (CEST)
Received: from igel.home (ppp-88-217-115-11.dynamic.mnet-online.de [88.217.115.11])
	by mail.mnet-online.de (Postfix) with ESMTP id A2DAF1C0020C;
	Fri, 24 Sep 2010 00:49:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 30B8DCA2A0; Fri, 24 Sep 2010 00:49:46 +0200 (CEST)
X-Yow: I am having a CONCEPTION--
In-Reply-To: <4C9B3B2A.2080604@op5.se> (Andreas Ericsson's message of "Thu, 23
	Sep 2010 13:34:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156922>

Andreas Ericsson <ae@op5.se> writes:

> On 09/23/2010 08:07 AM, Ramana Kumar wrote:
>> Are recursive aliases in any way allowed?
>
> They're not just not allowed; they're not even possible.

$ git config alias.foo foo
$ git foo
fatal: recursive alias: foo

:-)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
