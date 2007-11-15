From: Miles Bader <miles.bader@necel.com>
Subject: Re: git-clean won't read global ignore
Date: Thu, 15 Nov 2007 13:21:52 +0900
Message-ID: <buo6404gmu7.fsf@dhapc248.dev.necel.com>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:22:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWFK-0007Cm-JB
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXKOEWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbXKOEWO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:22:14 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:62211 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbXKOEWO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:22:14 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAF4Lq75003375;
	Thu, 15 Nov 2007 13:21:52 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Thu, 15 Nov 2007 13:21:52 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Thu, 15 Nov 2007 13:21:52 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 958BF43B; Thu, 15 Nov 2007 13:21:52 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <7vsl39l0b7.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 14 Nov 2007 00\:05\:00 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65051>

Junio C Hamano <gitster@pobox.com> writes:
> I think the problem is core.excludesfile is too new to be
> noticed by anything other than git-add and git-status.

"git-add -i" _doesn't_ seems to notice it though...

-Miles

-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that
            will  make every christian in the world foamm at the mouth?
[iddt]      nurg, that's the goal
