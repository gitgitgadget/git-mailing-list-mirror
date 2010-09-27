From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Sun, 26 Sep 2010 22:34:58 -0700
Message-ID: <F6C23FD9-37C4-4C20-83E7-26A1A2FC2275@sb.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org> <1285202724-52474-1-git-send-email-kevin@sb.org> <7vk4m7n7uo.fsf@alter.siamese.dyndns.org> <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org> <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 07:35:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P06Mn-00026g-4S
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 07:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696Ab0I0FfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 01:35:02 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:53698 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab0I0FfC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 01:35:02 -0400
Received: by pvg2 with SMTP id 2so1129663pvg.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 22:35:00 -0700 (PDT)
Received: by 10.114.131.14 with SMTP id e14mr7752986wad.198.1285565700885;
        Sun, 26 Sep 2010 22:35:00 -0700 (PDT)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id s5sm9782480wak.0.2010.09.26.22.34.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 22:34:59 -0700 (PDT)
In-Reply-To: <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157302>

On Sep 26, 2010, at 10:24 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>>> At the end-user level, this new option to merge-recursive has exactly the
>>> same meaning as existing -M given to "diff" family; people would probably
>>> want to see it made available as a synonym to "diff" family as well, no?
>> 
>> You mean so you can type `git diff --rename-score=50% foo`? A reasonable
>> suggestion, but then what do we do with -B and -C? It doesn't make much
>> sense to give a longer name to only one of the three options. This patch
>> was concerned with simply exposing the functionality to the merge
>> strategy and doesn't attempt to address the problem of providing long
>> names for this trio of options.
> 
> I would call them --break-threshold and --copy-threshold respectively.
> 
> I have been happy without long option names when we originally had only
> short names, but some people seem to be able to be more explicit, so...

Fair enough. Expect that naming in the next iteration of the patch.

> While we are at it, would it make sense to have "merge-recursive -M20" as
> a shorthand as well?

So it would be invoked like `git merge -s recursive -X M20 foo`? Looks a bit odd to me. I can add that if you think it's worthwhile though.

-Kevin Ballard