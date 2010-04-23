From: Miles Bader <miles@gnu.org>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 18:31:17 +0900
Message-ID: <buosk6m347u.fsf@dhlpc061.dev.necel.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221651590.7232@xanadu.home>
	<87vdbitu9v.fsf@frosties.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Goswin von Brederlow <goswin-v-b@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:31:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5FEb-0001V8-Lv
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab0DWJbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:31:36 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:34958 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756812Ab0DWJbe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:31:34 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o3N9VJOj027599;
	Fri, 23 Apr 2010 18:31:19 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o3N9VJk21906; Fri, 23 Apr 2010 18:31:19 +0900 (JST)
Received: from relay41.aps.necel.com ([10.29.19.9]) by vgate01.nec.co.jp (8.11.7/3.7W-MAILSV-NEC) with ESMTP
	id o3N9VIB08768; Fri, 23 Apr 2010 18:31:18 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay41.aps.necel.com with ESMTP; Fri, 23 Apr 2010 18:31:18 +0900
Received: from dhlpc061 ([10.114.112.64] [10.114.112.64]) by relay31.aps.necel.com with ESMTP; Fri, 23 Apr 2010 18:31:18 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id D87EC124006; Fri, 23 Apr 2010 18:31:17 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <87vdbitu9v.fsf@frosties.localdomain> (Goswin von Brederlow's
	message of "Fri, 23 Apr 2010 11:03:56 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145604>

Goswin von Brederlow <goswin-v-b@web.de> writes:
> You all say the index is such a great thing. So I might use it
> eventually. Other people might use it 1 out of 10 times. Yet other
> people use it 9 out of 10 times. Can you at least accept that the use of
> the index feature is different for each person?

In my case, I use the index extremely often, for complex commits that I
want to split up -- but I _also_ use "-a" maybe 30-40% of the time, for
simple commits that don't need splitting.

I think the "default to -a if index is empty and there are no args"
behavior sounds perfect.  It would have no real adverse effects as far
as I can see, and would make git a little more convenient for everybody.

-miles

-- 
I'm beginning to think that life is just one long Yoko Ono album; no rhyme
or reason, just a lot of incoherent shrieks and then it's over.  --Ian Wolff
