From: Steve Wagner <lists@lanwin.de>
Subject: Re: .gitk should created hidden in windows
Date: Tue, 17 Mar 2009 17:06:00 +0100
Message-ID: <49BFCA68.2080800@lanwin.de>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AF295@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjbqR-00010g-Uc
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757218AbZCQQGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754921AbZCQQGj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:06:39 -0400
Received: from lanwin.de ([77.37.16.229]:45576 "EHLO vs5923.vserver4free.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756820AbZCQQGi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:06:38 -0400
Received: from [10.10.11.46] (unknown [213.61.128.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by vs5923.vserver4free.de (Postfix) with ESMTP id CCF661F45D;
	Tue, 17 Mar 2009 17:06:35 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.6.666
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AF295@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113488>

> I didn't even notice that file, and I use gitk all the time.  That
> directory it put it in, the "top level" user directory based on profile,
> is not something that is directly examined by most users.

This is true for XP and before, but in Vista, 2008 and Windows 7 the
user have directly access to the user profile directory (simply click on
the username in startmenue) and can see the .gitk file.

Steve

John Dlugosz schrieb:
> === Re: ===
> The problem is that windows dose not hides files beginning with a dot as
> it is in unix. So the .gitk file is created as visible in the windows
> user profile. Problematic too is that i can no set the hidden attribute
> to this file, because it is recreated every time i start gitk, so the
> hidden attribute gets lost.
> === end ===
> 
> I didn't even notice that file, and I use gitk all the time.  That
> directory it put it in, the "top level" user directory based on profile,
> is not something that is directly examined by most users.  It is
> probably used as roughly equivalent to the home directory under Unix,
> but is not exactly---Windows has separate defined locations for
> programs's settings, user documents, and desktop among others.  I think
> this file properly belongs in %APPDATA%, which is a hidden directory.
> The stuff in that directory is not itself hidden.
> 
> That is, use the APPDATA environment variable to locate the file, rather
> than the HOME environment variable.
> 
> --John
> 
> 
> 
> 
> TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ GS: TRAD) of three operating subsidiaries, TradeStation Securities, Inc. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc., a trading software and subscription company, and TradeStation Europe Limited, a United Kingdom, FSA-authorized introducing brokerage firm. None of these companies provides trading or investment advice, recommendations or endorsements of any kind. The information transmitted is intended only for the person or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon, this information by persons or entities other than the intended recipient is prohibite
 d. If you received this in error, please contact the sender and delete the material from any computer.
> 
