From: Miles Bader <miles.bader@necel.com>
Subject: Re: git-clean won't read global ignore
Date: Thu, 15 Nov 2007 13:33:32 +0900
Message-ID: <buoy7d0f7qb.fsf@dhapc248.dev.necel.com>
References: <30046e3b0711131349h51d253d5n4e5649bde36dc36f@mail.gmail.com>
	<20071113225057.GB22836@artemis.corp>
	<7vsl39l0b7.fsf@gitster.siamese.dyndns.org>
	<buo6404gmu7.fsf@dhapc248.dev.necel.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	shunichi fuji <palglowr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWR9-00018h-C2
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711AbXKOEeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbXKOEeI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:34:08 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:34980 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbXKOEeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:34:07 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAF4XV62018055;
	Thu, 15 Nov 2007 13:33:32 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Thu, 15 Nov 2007 13:33:32 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay21.aps.necel.com with ESMTP; Thu, 15 Nov 2007 13:33:32 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 0362143B; Thu, 15 Nov 2007 13:33:32 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <buo6404gmu7.fsf@dhapc248.dev.necel.com> (Miles Bader's message of "Thu\, 15 Nov 2007 13\:21\:52 +0900")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65055>

Miles Bader <miles.bader@necel.com> writes:
>> I think the problem is core.excludesfile is too new to be
>> noticed by anything other than git-add and git-status.
>
> "git-add -i" _doesn't_ seems to notice it though...

To clarify:  the "add untracked" sub-menu of "git-add -i"

-Miles
-- 
Do not taunt Happy Fun Ball.
