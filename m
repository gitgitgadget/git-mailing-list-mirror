From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Fri, 26 Apr 2013 14:48:38 -0500
Message-ID: <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	<20130426101946.433f2d12@chalon.bertin.fr>
	<517A3E47.6010606@viscovery.net>
	<7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 21:48:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVodR-00039B-J8
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 21:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757500Ab3DZTsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 15:48:40 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:64849 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419Ab3DZTsk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 15:48:40 -0400
Received: by mail-la0-f48.google.com with SMTP id eo20so3848059lab.7
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=MTjhOcZTMmSS6VP/VnqN/DX52tzkPt7mMbUpVMwTLeo=;
        b=ekZrhtiCB85ta4/wxThjg+ooLLaWSj+/pv6BhylJDG2E5blqn0hjlEzTrryST7Tlb9
         YkNnIYAOyVx8vXa3cBEaMzq5IVu+pU7I+Y/jKFVT5bsrE3gxZWU+bXzBnvahyqboeC+2
         AAIvh5jWJvUn7N+jhWTrq46hvgPWW+f6PzWoQcnQiUhm9JJ+LaD9UfbbXzYgl4HiDTGQ
         wZgrj1p5Ae5FKK/wWwXrib1KTSvAqnGN/Lpry1kObUXez/7X2a2wAnrtAAAOWxop9ulE
         EwFqmSiM7KBuQRInkUZM0Awfo5Gh0tgYWNTkym4HraqikAgZ2kRiCIZWnZIhDB0ai8EL
         +c9w==
X-Received: by 10.152.5.134 with SMTP id s6mr23296123las.24.1367005718362;
 Fri, 26 Apr 2013 12:48:38 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 12:48:38 -0700 (PDT)
In-Reply-To: <7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222566>

On Fri, Apr 26, 2013 at 12:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Allow alternative spelling of
>>
>>    git rebase -i master topic
>>
>> like this:
>>
>>    git rebase -i master..topic
>>
>> (as always, the default for topic is HEAD).
>
> I actually made this typo a few times in the past.
>
> In a single-strand-of-pearls history, what rebase operates on is
> clearly a _range_ with a defined linear order of commits, and
> master..topic is a natural way to express it.

I agree, but I think there are other unexpected things.

I don't know what 'git rebase master' does, but I would expect 'git
rebase --onto=master' to do the same thing. Then, if 'git rebase
--onto=next master..topic' makes sense, so should 'git rebase next
master..topic'.

Moreover, it often annoys me that 'git rebase master' does exactly
what I want, but 'git rebase --onto=master previous' doesn't find the
commits that are already into 'master'. One would expect the more
defined version to work better, but it doesn't =/

Cheers.

-- 
Felipe Contreras
