From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Jul 2012, #01; Tue, 3)
Date: Tue, 10 Jul 2012 18:29:45 +0100
Message-ID: <4FFC6689.5050404@ramsay1.demon.co.uk>
References: <7vd34ctoub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:31:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoeHU-0005yJ-CP
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 19:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348Ab2GJRbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 13:31:18 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:37011 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755982Ab2GJRbR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2012 13:31:17 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SoeHM-0007Hk-Xx; Tue, 10 Jul 2012 17:31:17 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vd34ctoub.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201267>

Junio C Hamano wrote:
[...]
> 
> * rj/platform-pread-may-be-thread-unsafe (2012-06-26) 1 commit
>   (merged to 'next' on 2012-06-28 at ce5f79f)
>  + index-pack: Disable threading on cygwin
> 
> On Cygwin, the platform pread(3) is not thread safe, just like our
> own compat/ emulation, and cannot be used in the index-pack program.
> 

I've been using this patch (applied directly on top of v1.7.11) for the
last two weeks without problem. (So I guess you could declare it tested!)

Are you planning on an v1.7.11.2 anytime soon? If so, could I request that
you include this patch in the release. (I am mildly surprised at the lack
of complaints from cygwin users, but it would be nice to be able to point
them to a release if they start flooding in :-P ).

ATB,
Ramsay Jones
