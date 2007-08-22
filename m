From: Miles Bader <miles.bader@necel.com>
Subject: Re: "git pull REMOTE" question
Date: Wed, 22 Aug 2007 13:44:05 +0900
Message-ID: <buo8x84kwkq.fsf@dhapc248.dev.necel.com>
References: <fc339e4a0708212123p6e922b4cy3f5f19bfafafa395@mail.gmail.com>
	<7vy7g4jids.fsf@gitster.siamese.dyndns.org>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 06:44:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INi5G-0008CB-Ey
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 06:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbXHVEoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 00:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbXHVEoP
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 00:44:15 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:65070 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbXHVEoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 00:44:14 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l7M4i30X023068;
	Wed, 22 Aug 2007 13:44:03 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Wed, 22 Aug 2007 13:44:02 +0900
Received: from dhapc248.dev.necel.com ([10.114.98.116] [10.114.98.116]) by relay11.aps.necel.com with ESMTP; Wed, 22 Aug 2007 13:44:02 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 7065F539; Wed, 22 Aug 2007 13:44:06 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <7vy7g4jids.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 21 Aug 2007 21\:35\:59 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56351>

Junio C Hamano <gitster@pobox.com> writes:
>> Is there a way to set things up so that "git pull REMOTE"
>> automatically merges fetched branches when doing a non-default pull?
>
> The branch to be merged currently is determined per branch.
> You can just say "git pull usb master".

Right, but what I'm asking is whether there is (or should be) a way to
automatically supply the "master", so I can just type "git pull usb" and
have it do the right thing -- as there obviously is for the "origin"
remote for this branch.

This apparent association of each local branch with a single remote
seems slightly odd to me -- isn't it quite common for people to pull
from various different remotes into the same local branch (e.g. for
someone merging from the repositories of various regular contributors)?

Thanks,

-Miles

-- 
Do not taunt Happy Fun Ball.
