From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [RFC PATCH 00/95] Add missing &&'s in the testsuite
Date: Fri, 24 Sep 2010 16:32:30 -0500
Message-ID: <UA25cdpM3towJy13l2VNc8pgKHGybUWr88Zc0C9kQjUCExhj5gXkCQ@cipher.nrlssc.navy.mil>
References: <1285362413-18265-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 23:32:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzFsx-0000HK-BA
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 23:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757819Ab0IXVcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 17:32:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41341 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294Ab0IXVcp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 17:32:45 -0400
Received: by mail.nrlssc.navy.mil id o8OLWVOY022816; Fri, 24 Sep 2010 16:32:31 -0500
In-Reply-To: <1285362413-18265-1-git-send-email-newren@gmail.com>
X-OriginalArrivalTime: 24 Sep 2010 21:32:31.0236 (UTC) FILETIME=[FE730440:01CB5C2F]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157063>

On 09/24/2010 04:06 PM, Elijah Newren wrote:
> I ran across three testfiles which were missing &&s; one was missing
> several, while another would no longer pass after adding one and had
> no comment to that effect.  So I decided it was time to look through
> the testsuite.  Now I have a 95 patch series, which I'm worried might
> be a bit too much spam for the mailing list.  So the patches are
> available from
>    git://gitorious.org/~newren/git/en.git   add-missing-ands
> Let me know if you're fine with mailing list spam, and I'd be happy
> to flood all your inboxes.
> 
> 80 of the 95 testfiles that needed changes were pretty mechanical --
> just simple additions of '&&' in the appropriate place.  15 needed
> other changes and I'm not entirely sure whether I made the right ones.
> I've moved those 15 to the beginning of the series, so that you won't
> have to hunt for them.  (If it makes sense to send just the first 15
> to the list, let me know, and I'll do that.)

Sounds like it should be about a 16 patch series.

The first 15 patches should rework the tests that will fail when
they are hooked together properly with &&'s.

And then one patch to mechanically add the missing &&'s.

Maybe even some of the first 15 patches could be squashed if any of
them apply the same fix, just to different test files.

-Brandon
