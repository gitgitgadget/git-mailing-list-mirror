From: Geert Bosch <bosch@adacore.com>
Subject: Re: RFC: New diff-delta.c implementation
Date: Mon, 24 Apr 2006 14:27:19 -0400
Message-ID: <EC4542D3-2C18-44D4-8FDB-86918054CA9B@adacore.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com> <444A2334.3030501@lsrfire.ath.cx> <20060424025741.GA636@adacore.com> <Pine.LNX.4.64.0604232327500.3603@localhost.localdomain> <20060424151901.GA2663@adacore.com> <Pine.LNX.4.64.0604241123490.18520@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 24 20:27:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FY5mP-00078K-KL
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 20:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWDXS1U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Apr 2006 14:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDXS1U
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Apr 2006 14:27:20 -0400
Received: from nile.gnat.com ([205.232.38.5]:43193 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1751098AbWDXS1T (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Apr 2006 14:27:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id 3731748CC13;
	Mon, 24 Apr 2006 14:27:19 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 19785-01-2; Mon, 24 Apr 2006 14:27:19 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 10BEA48CBE6;
	Mon, 24 Apr 2006 14:27:19 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0604241123490.18520@localhost.localdomain>
To: Nicolas Pitre <nico@cam.org>
X-Mailer: Apple Mail (2.749.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19099>

On Apr 24, 2006, at 11:57, Nicolas Pitre wrote:
>> As a compiler writer, I am more than aware of this.
>> Your change results in a 70% slowdown on PowerPC.
>
> Huh!?

2.5s instead of 1.5s comparing gcc-2.95.1.tar against
gcc-2.95.2.tar. Byte loads are relatively expensive on
this platform. I'll put the word loads back in and make
sure they don't slow things down on x86.

   -Geert
