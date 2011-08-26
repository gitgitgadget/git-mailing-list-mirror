From: Miles Bader <miles@gnu.org>
Subject: Re: git diff annoyance / feature request
Date: Fri, 26 Aug 2011 18:08:46 +0900
Message-ID: <buo4o148rq9.fsf@dhlpc061.dev.necel.com>
References: <4E569F10.8060808@panasas.com>
 <7vippljkxs.fsf@alter.siamese.dyndns.org> <4E56C58E.4080905@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Boaz Harrosh <bharrosh@panasas.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 11:08:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwsPI-0000OB-Ma
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 11:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab1HZJIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 05:08:51 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:52089 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab1HZJIu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 05:08:50 -0400
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LQJ00CAM2QOH430@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Fri, 26 Aug 2011 18:08:48 +0900 (JST)
Received: from relmlac1.idc.renesas.com ([10.200.69.21])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LQJ00I9R2QO64E0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Fri, 26 Aug 2011 18:08:48 +0900 (JST)
Received: by relmlac1.idc.renesas.com (Postfix, from userid 0)
	id 6120E800A2; Fri, 26 Aug 2011 18:08:48 +0900 (JST)
Received: from relmlac1.idc.renesas.com (localhost [127.0.0.1])
	by relmlac1.idc.renesas.com (Postfix) with ESMTP id 5C3C0800A4; Fri,
 26 Aug 2011 18:08:48 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac1.idc.renesas.com with ESMTP id UAG03908; Fri,
 26 Aug 2011 18:08:48 +0900
X-IronPort-AV: E=Sophos;i="4.68,284,1312124400";   d="scan'208";a="42785334"
Received: from unknown (HELO relay21.aps.necel.com) ([10.29.19.50])
 by relmlii2.idc.renesas.com with ESMTP; Fri, 26 Aug 2011 18:08:47 +0900
Received: from relay21.aps.necel.com ([10.29.19.50] [10.29.19.50])
 by relay21.aps.necel.com with ESMTP; Fri, 26 Aug 2011 18:08:47 +0900
Received: from dhlpc061 ([10.114.97.215] [10.114.97.215])
 by relay21.aps.necel.com with ESMTP; Fri, 26 Aug 2011 18:08:47 +0900
Received: by dhlpc061 (Postfix, from userid 31295)	id 538D552E2D0; Fri,
 26 Aug 2011 18:08:47 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <4E56C58E.4080905@panasas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180158>

Boaz Harrosh <bharrosh@panasas.com> writes:
>> Personally, I would have to say that the source wouldn't be using too many
>> labels with the same name for this behaviour to be problematic, especially
>> if it is not freaking BASIC ;-), so...
>
> The Linux Kernel is full of "goto out" or "goto err" its a common error handling
> practice. I actually like it because it taps onto a known pattern.
>
> Now the patch tell me @@@ lable out: !! that's not very useful I would say
>
> Thanks I'm sure I can shape it up the way I like it

Incidentally, if these annoyances were inherited from GNU diff, it would
be good to send a bug report there too,... I doubt anybody likes the
behavior any better with diff!

[I know I've been annoyed by such things before...]

Thanks,

-Miles

-- 
Innards, n. pl. The stomach, heart, soul, and other bowels.
