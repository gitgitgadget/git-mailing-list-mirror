From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Reset by checkout?
Date: Sat, 31 May 2014 09:03:05 +0200
Message-ID: <m261kmmnva.fsf@linux-m68k.org>
References: <20140531144610.754B.B013761@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Atsushi Nakagawa <atnak@chejz.com>
X-From: git-owner@vger.kernel.org Sat May 31 09:03:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqdK7-0004jF-AR
	for gcvg-git-2@plane.gmane.org; Sat, 31 May 2014 09:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbaEaHDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2014 03:03:16 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38217 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbaEaHDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2014 03:03:16 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ggYWh60Pjz3hhZs;
	Sat, 31 May 2014 09:03:12 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ggYWh5bzVzbbvf;
	Sat, 31 May 2014 09:03:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 4AcdzKwxSPzJ; Sat, 31 May 2014 09:03:11 +0200 (CEST)
X-Auth-Info: cPcWfG3ZOrK1hK6ipgyTn7NjHBEb4jCeGl5vqhOdf/w=
Received: from linux.local (ppp-93-104-159-37.dynamic.mnet-online.de [93.104.159.37])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 31 May 2014 09:03:11 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id BEBD21E56D6; Sat, 31 May 2014 09:03:06 +0200 (CEST)
X-Yow: I decided to be JOHN TRAVOLTA instead!!
In-Reply-To: <20140531144610.754B.B013761@chejz.com> (Atsushi Nakagawa's
	message of "Sat, 31 May 2014 14:46:12 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250502>

Atsushi Nakagawa <atnak@chejz.com> writes:

> Ok, the typical use case is: I'm on 'master' and I make a few test
> commits.  Afterwards, I want to discard the commits and move back to
> 'origin/master'.  I could type 'reset --hard origin/master' and risk
> blowing away dirty files if I'm not careful.  Or, I could use "reset by
> checkout" and be carefree.

I think that is what 'reset --keep' is doing.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
