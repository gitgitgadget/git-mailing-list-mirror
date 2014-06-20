From: Nico Williams <nico@cryptonector.com>
Subject: Re: Should branches be objects?
Date: Thu, 19 Jun 2014 19:31:03 -0500
Message-ID: <CAK3OfOhC4krFUDJ9nOzMfhkHjX_76L2k+tdEsbqcAzWDseeNAg@mail.gmail.com>
References: <CAK3OfOiB0YWf25Hvvvqi+YBwu2V-gE-sjm7XrfE0p2zds4CE2Q@mail.gmail.com>
	<20140619234614.GY8557@google.com>
	<CAK3OfOjnYXxhWT7Vp-0Pcb=F8ze6wJnqSm1_LW0Zp1FmYZfUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 20 02:31:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxmje-0000Th-5c
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 02:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbaFTAbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 20:31:07 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:51794 "EHLO
	homiemail-a89.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752265AbaFTAbE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2014 20:31:04 -0400
Received: from homiemail-a89.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a89.g.dreamhost.com (Postfix) with ESMTP id 794A431805C
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 17:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=cryptonector.com; h=
	mime-version:in-reply-to:references:date:message-id:subject:from
	:to:cc:content-type; s=cryptonector.com; bh=L1f933Eu1mMUS5UfCP/G
	sx4ufIM=; b=uKA4vYJsu9plfP+dK4QFgYPR3Hsz5LflVBKLiFx+caOxaajZvCG1
	0CwsdksXRSKiC4Crows1BGIHkv/An9R/abouBbwub8eqfVHixaWweKdF4KYbdPzq
	+ecrzgF3B87MvjzTjxmXeNgl7nENYJl1164YM1hiwXj4i3uQMyHL5d4=
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by homiemail-a89.g.dreamhost.com (Postfix) with ESMTPSA id 2DB6E318059
	for <git@vger.kernel.org>; Thu, 19 Jun 2014 17:31:04 -0700 (PDT)
Received: by mail-wg0-f50.google.com with SMTP id x13so2935520wgg.33
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 17:31:03 -0700 (PDT)
X-Received: by 10.194.243.70 with SMTP id ww6mr8575908wjc.76.1403224263097;
 Thu, 19 Jun 2014 17:31:03 -0700 (PDT)
Received: by 10.216.29.200 with HTTP; Thu, 19 Jun 2014 17:31:03 -0700 (PDT)
In-Reply-To: <CAK3OfOjnYXxhWT7Vp-0Pcb=F8ze6wJnqSm1_LW0Zp1FmYZfUEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252200>

Another thing is that branches as objects could store a lot more
information, like:

 - the merge-base and HEAD for a rebase (and the --onto)

 - the interactive rebase plan!  (and diffs to what would have been
the non-interactive plan)

 - the would-be no-op non-interactive rebase plan post rebase (again,
so elucidate what commit splitting and such things occurred during a
rebase)

Nico
--
