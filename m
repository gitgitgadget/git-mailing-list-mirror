From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] mergetool: use tabs consistently
Date: Wed, 01 Apr 2009 10:56:32 -0700
Message-ID: <7vab70z29b.fsf@gitster.siamese.dyndns.org>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
 <7vzlf3flim.fsf@gitster.siamese.dyndns.org>
 <20090330213530.GA7091@hashpling.org> <20090331063613.GA20690@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 19:58:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp4hw-0002GM-Lv
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 19:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757731AbZDAR4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764529AbZDAR4m
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 13:56:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764462AbZDAR4l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 13:56:41 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F6FFA6E38;
	Wed,  1 Apr 2009 13:56:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D329EA6E32; Wed,
  1 Apr 2009 13:56:33 -0400 (EDT)
In-Reply-To: <20090331063613.GA20690@gmail.com> (David Aguilar's message of
 "Mon, 30 Mar 2009 23:36:14 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 72901260-1EE6-11DE-BF67-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115407>

David Aguilar <davvid@gmail.com> writes:

> On  0, Charles Bailey <charles@hashpling.org> wrote:
>> On Mon, Mar 30, 2009 at 01:44:01AM -0700, Junio C Hamano wrote:
>> 
>> I don't much like [1/8] though. I'm all in favour of consistency, but
>> this patch touches most of the lines in git-mergetool and tries to go
>> the opposite way to the consistency drive that we were trying to
>> introduce gradually (i.e. only through lines materially affected by
>> subsequent patches) in:
>
> Sounds good.  I'll re-roll and give the refactoring another go.
>
> I think we can definitely do better, and more importantly, I
> think we can decouple things by using less globals.
>
> Junio, did you have any comments about patch v2
> "difftool: add support for difftool.prompt config variable"?

I only took a cursory look but it; you did seem to have based it on the
one I queued in 'pu' with a typo-fixup and it looked fine.

Thanks.
