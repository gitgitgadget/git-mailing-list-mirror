From: Nix <nix@esperi.org.uk>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Wed, 25 Jul 2007 23:43:44 +0100
Message-ID: <877iooxfxb.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix>
	<85y7h6dewp.fsf@lola.goethe.zz> <87lkd6n62i.fsf@hades.wkstn.nix>
	<87hcnun5dc.fsf@hades.wkstn.nix> <f83bfv$95g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 00:44:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDpaG-00009r-3l
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 00:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378AbXGYWnw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 18:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757040AbXGYWnw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 18:43:52 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:60019 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757275AbXGYWnv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 18:43:51 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l6PMhjho023817;
	Wed, 25 Jul 2007 23:43:46 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l6PMhivJ031165;
	Wed, 25 Jul 2007 23:43:44 +0100
Emacs: it's like swatting a fly with a supernova.
In-Reply-To: <f83bfv$95g$1@sea.gmane.org> (Jakub Narebski's message of "Tue, 24 Jul 2007 00:52:47 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
X-DCC--Metrics: hades 102; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53729>

On 23 Jul 2007, Jakub Narebski spake thusly:

> Nix wrote:
>
>> And the problem is that while git has a lot of strategies for merging
>> *trees*, its file merge system is totally unpluggable: it just falls
>> back to xdiff's merging system. I guess I'll have to add that feature :)
>
> Not true. You can add custom diff driver for files using gitattributes
> system.

Oo. Excellent, I didn't notice that. Thank you.
