From: David Kastrup <dak@gnu.org>
Subject: Re: Profiling support?
Date: Tue, 11 Feb 2014 16:19:55 +0100
Message-ID: <874n45brs4.fsf@fencepost.gnu.org>
References: <87d2itc2zv.fsf@fencepost.gnu.org>
	<CACsJy8BAD3cm2BLSapJ2fhkGiYjDKqW1TQ1yu0XPwTyEfL2oLQ@mail.gmail.com>
	<878uthbtjg.fsf@fencepost.gnu.org>
	<20140211151451.GA15032@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 11 16:20:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDF7x-0004GB-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 16:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbaBKPT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Feb 2014 10:19:57 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:52745 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbaBKPT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Feb 2014 10:19:57 -0500
Received: from localhost ([127.0.0.1]:51786 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WDF7r-0003Ry-NV; Tue, 11 Feb 2014 10:19:55 -0500
Received: by lola (Postfix, from userid 1000)
	id 5C17CE0510; Tue, 11 Feb 2014 16:19:55 +0100 (CET)
In-Reply-To: <20140211151451.GA15032@serenity.lan> (John Keeping's message of
	"Tue, 11 Feb 2014 15:14:52 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241948>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Feb 11, 2014 at 03:41:55PM +0100, David Kastrup wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > Would perf help? No changes required, and almost no overhead, I think.
>> 
>> Not useful.  It would be probably nice for nailing down the performance
>> gains when the work is finished so that future regressions will be
>> noticeable.  It's reasonable easy to create a test case that will take
>> hours with the current git-blame and would finish in seconds with the
>> improved one.
>> 
>> But it's not useful at all for figuring out the hotspots within the
>> git-blame binary.
>
> I would have thought the annotation described at [1] is exactly what
> you're looking for, isn't it?
>
> Alternatively, I've had some success with callgrind and kCachegrind in
> the past.
>
> [1]
> https://perf.wiki.kernel.org/index.php/Tutorial#Source_level_analysis_with_perf_annotate

Misunderstanding on my part.  I thought this was about the "make perf"
Makefile target.  I'll have to take a look at what the perf utility
does.

Thanks for the clarification.

-- 
David Kastrup
