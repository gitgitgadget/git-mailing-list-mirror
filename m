From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-am: don't ignore --keep (-k) option
Date: Fri, 27 Nov 2009 21:17:59 +0100
Message-ID: <87y6lr203s.fsf@meyering.net>
References: <874ookp4u8.fsf@meyering.net>
	<7vmy2b76ji.fsf@alter.siamese.dyndns.org>
	<87638zm38r.fsf_-_@meyering.net>
	<7vy6lrka69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 27 21:18:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE7Gf-0005Mu-MJ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbZK0USB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751928AbZK0USB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:18:01 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:54685 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442AbZK0USA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:18:00 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6570B81808E
	for <git@vger.kernel.org>; Fri, 27 Nov 2009 21:18:01 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8A182818181
	for <git@vger.kernel.org>; Fri, 27 Nov 2009 21:17:59 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 68A8E8EB5; Fri, 27 Nov 2009 21:17:59 +0100 (CET)
In-Reply-To: <7vy6lrka69.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 27 Nov 2009 12:03:10 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133932>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>> I started looking at git-am.sh and spotted what appears to be a typo.
>> There is only that one use of $keep_subject, so its value currently
>> comes from the environment.
>>
>> From 02f7e6433b5db8b18a4cccf58c302159c2f54fa5 Mon Sep 17 00:00:00 2001
>> From: Jim Meyering <meyering@redhat.com>
>> Date: Wed, 25 Nov 2009 09:10:46 +0100
>> Subject: [PATCH] git-am: don't ignore --keep (-k) option
>>
>> Fix typo in variable name: s/keep_subject/keep/.
>>
>> Signed-off-by: Jim Meyering <meyering@redhat.com>
>
> At the level of "what does each line of the code do", this is a fix, but
> as we do a lot more than just stripping "[PATCH] " from the beginning of
> the Subject: line these days, I think we are better off declaring defeat
> in this particular codepath and not doing anything here.

Sounds fine to me.
Glad you're keeping everything in perspective.
