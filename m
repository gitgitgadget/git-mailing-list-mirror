From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Only update the cygwin-related configuration during
 state auto-setup
Date: Mon, 27 Oct 2008 20:27:23 -0700
Message-ID: <7vhc6xh010.fsf@gitster.siamese.dyndns.org>
References: <7viqri35dq.fsf@gitster.siamese.dyndns.org>
 <20081027192018.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Mark Levedahl" <mlevedahl@gmail.com>, spearce@spearce.org,
	dpotapov@gmail.com, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 04:29:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KufGJ-00050L-1t
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 04:28:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYJ1D1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 23:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYJ1D1l
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 23:27:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbYJ1D1l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 23:27:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D5B8375F82;
	Mon, 27 Oct 2008 23:27:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 082C175F7E; Mon, 27 Oct 2008 23:27:30 -0400 (EDT)
In-Reply-To: <20081027192018.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon, 27 Oct 2008 19:20:18 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60506F34-A4A0-11DD-9CDB-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99273>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> This is the answer to the question I asked in:
>> 
>>  http://thread.gmane.org/gmane.comp.version-control.git/97986/focus=98066
>> 
>> Perhaps we should use a separate variable as the original patch did, in:
>> 
>>   http://article.gmane.org/gmane.comp.version-control.git/97987
>> 
>> How about doing it like this instead?
>
> Junio, may I ask what the status of this patch is? I see you did not write tests nor commit message --- are you waiting for others to write them?

Heh, Alex's ack is good enough for me as far as the code itself is
concerned, but I do want these "fixes" accompanied by additional tests to
reproduce to avoid future regressions, and this being a Cygwin fix, I am
not really the right person to write tests nor run them.
