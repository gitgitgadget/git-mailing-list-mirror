From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Thu, 26 Mar 2015 22:41:59 +0100
Message-ID: <55147D27.1060204@kdbg.org>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com> <871tkblapv.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergey Organov <sorganov@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 22:42:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbFXV-0007gh-2i
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 22:42:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbbCZVmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 17:42:05 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:49131 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067AbbCZVmD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 17:42:03 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lCfsh42Hyz5tl9;
	Thu, 26 Mar 2015 22:42:00 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id C376051FD;
	Thu, 26 Mar 2015 22:41:59 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <871tkblapv.fsf@javad.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266353>

Am 26.03.2015 um 22:17 schrieb Sergey Organov:
> Junio C Hamano <gitster@pobox.com> writes:
>> There however were repeated wishes (or wishful misunderstandings ;-)
>> that there were a mode to rebuild the trunk, considering only the
>> commits on the first-parent chain as "commits to be rebased",
>> recreating the history by replaying the merge commits (whose first
>> parent might be rewritten during the rebase, but the tips of side
>> branches these merges bring into the history are kept intact).
>>
>> Surely there is no such mode right now,
>
> Isn't it what Johannes Sixt <j6t@kdbg.org> mentions here?:
>
> [QUOTE]
> If you want a version of --preserve-merges that does what *you* need,
> consider this commit:
>
>    git://repo.or.cz/git/mingw/j6t.git rebase-p-first-parent
>
> Use it like this:
>
>    git rebase -i -p --first-parent ...
>
> Beware, its implementation is incomplete: if the rebase is interrupted,
> then 'git rebase --continue' behaves as if --first-parent were not given.
> [/QUOTE].
>
> ref: http://permalink.gmane.org/gmane.comp.version-control.git/263584
>
> If so, then I'd say such mode almost exists.

The patch was discussed here:
http://thread.gmane.org/gmane.comp.version-control.git/198125

The reason that this has not progressed any further is this response in 
the thread:

http://thread.gmane.org/gmane.comp.version-control.git/198125/focus=198483

where you basically say that a --first-parent mode is good, but it 
should be separate from --preserve-merges. I haven't made up my mind, 
yet, how to proceed from there.

If somebody wants to pick up the baton, I'll happily pass it on.

-- Hannes
