From: Ted Pavlic <ted@tedpavlic.com>
Subject: Re: [PATCH (update)] make: By default, remove -pthread on Darwin
 (it is included by cstdlib).
Date: Mon, 26 Jan 2009 13:57:32 -0500
Message-ID: <497E079C.7090303@tedpavlic.com>
References: <1232987160-5635-1-git-send-email-ted@tedpavlic.com> <1232987609-6229-1-git-send-email-ted@tedpavlic.com> <7vr62q6jtp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 19:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRWfs-0002qh-JE
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 19:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbZAZS5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 13:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbZAZS5i
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 13:57:38 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:52799 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648AbZAZS5i (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 13:57:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id B948780D803F;
	Mon, 26 Jan 2009 13:51:32 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nn0Wxuxg0qB7; Mon, 26 Jan 2009 13:51:32 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id A465480D803D;
	Mon, 26 Jan 2009 13:51:32 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
In-Reply-To: <7vr62q6jtp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107246>

...
>> This patch clears PTHREAD_LIBS by default. However, if
>> FORCE_DARWIN_PTHREAD_LIBS is defined, then PTHREAD_LIBS will be set as
>> before.
>
> Why is this even configurable?  You explained pretty clearly that:
...
> But the above leaves the reader wondering in what situation it may be
> useful to use FORCE_* and for what purpose other than to get the nasty
> warning back (which probably is not most users want to).

I was afraid that there would be some strange situation where someone 
would have a configuration where they might want pthreads turned on. I 
suppose that if someone is in that specialized situation, they will be 
able to customize their build environment on their own.

I will submit a new patch without the define.

Thanks --
Ted

-- 
Ted Pavlic <ted@tedpavlic.com>

   Please visit my ALS association page:
         http://web.alsa.org/goto/tedpavlic
   My family appreciates your support in the fight to defeat ALS.
