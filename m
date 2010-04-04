From: Miles Bader <miles@gnu.org>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sun, 04 Apr 2010 09:14:07 +0900
Message-ID: <87oci0m5v4.fsf@catnip.gol.com>
References: <201004030005.35737.elendil@planet.nl>
	<p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
	<201004040123.06877.elendil@planet.nl>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sun Apr 04 02:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyDTx-0007lX-0b
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 02:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab0DDAON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 20:14:13 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:39559 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab0DDAOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 20:14:11 -0400
Received: from 218.231.154.39.eo.eaccess.ne.jp ([218.231.154.39] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	id 1NyDTb-00015w-OG; Sun, 04 Apr 2010 09:14:07 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 44F6ADF6E; Sun,  4 Apr 2010 09:14:07 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <201004040123.06877.elendil@planet.nl> (Frans Pop's message of
	"Sun, 4 Apr 2010 01:23:04 +0200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143910>

Frans Pop <elendil@planet.nl> writes:
>> > I haven't had the patience to let it finish
>>
>> There's your problem.
>
> Yes, I had seen that. But there's a difference between taking much more 
> time and slowing down to such an extend that it never finishes.
>
> I've tried it today on my linux-2.6 repo as well and the same thing 
> happened. At first the progress is not fast but reasonable. When it gets 
> to about 45% percent it starts slowing down a lot: from ~1500 objects per 
> update of the counters to ~300 objects per update. And who knows what the 
> progress is going to be when it reaches 70% or 90%: 10 per update?

Are you sure it doesn't subsequently speed up again?

-Miles

-- 
Idiot, n. A member of a large and powerful tribe whose influence in human
affairs has always been dominant and controlling.
