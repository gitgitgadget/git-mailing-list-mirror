From: Miles Bader <miles@gnu.org>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 06 Dec 2010 17:13:46 +0900
Message-ID: <buopqtfmi85.fsf@dhlpc061.dev.necel.com>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
	<20101206082948.1403cc5a@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Dec 06 09:14:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPWD9-00020I-4X
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 09:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276Ab0LFIOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 03:14:09 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:44838 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836Ab0LFIOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 03:14:08 -0500
Received: from mailgate3.nec.co.jp ([10.7.69.192])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id oB68DnKV005974;
	Mon, 6 Dec 2010 17:13:49 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id oB68Dlq25891; Mon, 6 Dec 2010 17:13:47 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.54])
	by vgate02.nec.co.jp (8.14.4/8.14.4) with ESMTP id oB67vMbC013827;
	Mon, 6 Dec 2010 17:13:47 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.103] [10.29.19.103]) by relay31.aps.necel.com with ESMTP; Mon, 6 Dec 2010 17:13:47 +0900
Received: from dhlpc061 ([10.114.98.29] [10.114.98.29]) by relay41.aps.necel.com with ESMTP; Mon, 6 Dec 2010 17:13:47 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id B5F9252E224; Mon,  6 Dec 2010 17:13:46 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <20101206082948.1403cc5a@chalon.bertin.fr> (Yann Dirson's message
	of "Mon, 06 Dec 2010 08:29:48 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162982>

Yann Dirson <dirson@bertin.fr> writes:
> But then, why not simply use --find-renames (since --detect-renames has
> luckily not been released ontl the masses yet), and avoid making similar-usage
> opts dissimilar and then adding a synonym just to make them similar the other
> way ?

"Find" and "detect" have different nuances.

"Detect" sounds somewhat passive/minor, so "detect renames" makes it
more clear that renames are detected _in addition_ to normal processing.

"Find," by contrast, is active/major, so "find renames" makes it sounds
like an action to be performed _instead_ of some normal processing.

-Miles

-- 
97% of everything is grunge
