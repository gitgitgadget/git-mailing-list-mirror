From: Hannu Koivisto <azure@iki.fi>
Subject: Re: Gitk/Cygwin bug: phony local changes
Date: Tue, 28 Oct 2008 18:04:53 +0200
Organization: NOYB
Message-ID: <831vy03dui.fsf@kalahari.s2.org>
References: <83bpx62hbn.fsf@kalahari.s2.org> <837i7s3ga4.fsf@kalahari.s2.org>
	<81b0412b0810280827o2ccca3bfw127877782f5a0909@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 17:07:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kur5R-0001KM-P7
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 17:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707AbYJ1QFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 12:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753487AbYJ1QFI
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 12:05:08 -0400
Received: from main.gmane.org ([80.91.229.2]:44252 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbYJ1QFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 12:05:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kur42-0001F5-7L
	for git@vger.kernel.org; Tue, 28 Oct 2008 16:05:02 +0000
Received: from s2.org ([195.197.64.39])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 16:05:02 +0000
Received: from azure by s2.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Oct 2008 16:05:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s2.org
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:wuZjEnLsRImD9G1MRNZJdMKHE/4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99301>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> 2008/10/28 Hannu Koivisto <azure@iki.fi>:
>
>> I used bisect to find which commit introduced this bug and the
>> result is:
>>
>> 7faee6b8de836904227ee98dc3d2c4c75b0ef3a1 is first bad commit
>> commit 7faee6b8de836904227ee98dc3d2c4c75b0ef3a1
>> Author: Mark Levedahl <mlevedahl@gmail.com>
>> Date:   Mon Oct 13 00:33:31 2008 -0400
>>
>>    compat/cygwin.c - Use cygwin's stat if core.filemode == true
>>
>
> Could you try the patch from Junio's "Re: [PATCH] Only update the
> cygwin-related configuration during state auto-setup" mail and see
> if it changes anything?

It seems to fix the problem.

Something I forgot to mention in the previous mail: the problem
occurs whether I have core.fileMode set to true or false.

-- 
Hannu
