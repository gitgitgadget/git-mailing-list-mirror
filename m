From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Apr 2014, #02; Mon, 7)
Date: Tue, 08 Apr 2014 21:20:59 +0200
Message-ID: <53444C1B.2070603@web.de>
References: <xmqqmwfwlr4f.fsf@gitster.dls.corp.google.com>	<53444156.8020800@web.de> <xmqq38hn4q39.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ronald Weiss <weiss.ronald@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 21:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXbaJ-0003FN-Tq
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 21:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757473AbaDHTVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 15:21:23 -0400
Received: from mout.web.de ([212.227.15.4]:58029 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756222AbaDHTVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 15:21:22 -0400
Received: from [192.168.178.41] ([79.193.64.34]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LlnMG-1X6wOZ30Iy-00ZN7f; Tue, 08 Apr 2014 21:20:59
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq38hn4q39.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ndF0kI8JvrImZv2O/Vw+40/E6KvwjACD3bXhLC+uYU8YTEa7Evh
 ZQP4V/ynLalUFYK2gdWqP8ICExODMdyCPJa+jBkYXwu7YtVvXsYrRD4u1aiL8jbU/YDDzdZ
 nuJk8+MDboytTvy2ymXWnJlWDyb7WGLZdK2yXohYbrcTse2AEM7CC+lpT2i5E9UPJgHrQ1a
 HLbZBNQqKTZepyY75eG3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245951>

Am 08.04.2014 20:46, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 08.04.2014 00:19, schrieb Junio C Hamano:
>>> * jl/status-added-submodule-is-never-ignored (2014-04-07) 2 commits
>>>  - commit -m: commit staged submodules regardless of ignore config
>>>  - status/commit: show staged submodules regardless of ignore config
>>
>> I have two more patches for gitk and git-gui doing the same there,
>> me thinks it would make a lot of sense all four make it into the
>> same version. Should I wait until this topic hits next (or master)
>> or does it make sense to send them to Pat and Paul right away?
> 
> Either would be fine, but I suspect they would appreciate it sooner
> rather than later, if only as an advance notice.

Thanks, will do.

> How do these two relate to and/or interact with what Ronald and you
> have been discussing, by the way?

Only as a prerequisite, as the latter is about making the handling
and overriding of the submodule ignore options consistent for add
and commit. The goal there is to enable users to stage and commit
ignored submodules pretty much like they can do that with ignored
files. And the prerequisite for that is that you'll be able to see
what you staged afterwards.
