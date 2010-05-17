From: Eugene Sajine <euguess@gmail.com>
Subject: Re: stupid error - is there a way to fix?
Date: Mon, 17 May 2010 15:31:01 -0400
Message-ID: <AANLkTinIaInzOLiJcXNPtg4AQ2_TAxjBNzcheNlvSrft@mail.gmail.com>
References: <AANLkTin32LGzfA79XYfivdun0EwWTs8p_yBeR030_2N2@mail.gmail.com>
	 <AANLkTimFZ1GCBIf9y8Gkz-AnG-TmvWU_WXfjgw1olmKi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 17 21:31:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OE61x-0001ME-Bl
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 21:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311Ab0EQTbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 15:31:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63922 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab0EQTbE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 May 2010 15:31:04 -0400
Received: by vws9 with SMTP id 9so2060278vws.19
        for <git@vger.kernel.org>; Mon, 17 May 2010 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=a5VNtFFTc4m8eRXOyPP7NzKxfdX/BzWg5mrmHKSMl28=;
        b=cjT1iw2Dpv8XAWpskKJ2jOL13daXGi68iadF7Imo9xMr9MXCZxJnI8ryNHaU8OqPQW
         60W9DPm2b+g0YYMJ8pk5poOWlz+xtCmkeu5W1Ct43DSPOEBadJFxn1G0qVqqqARkRMhW
         zIRatRSpQTPJkfFKgs4KckJXGUWfwS5RqgwFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fmkF07K0tGbzIURPOvvwfHxhz1daUTZCLoP/hKC6Ok7IKn4tb00mZH926YwWaHZd+/
         lXlaEMZukrI88oTGBSF/TbtWKNlE3dubY2558gpuRwUUYIIQBsHl2DS8/GIYQ8FQ9dy+
         yoAEWxFixhRvuNg4sffrsbWLB7sUWdHPvLFZA=
Received: by 10.229.218.21 with SMTP id ho21mr1230332qcb.102.1274124661877; 
	Mon, 17 May 2010 12:31:01 -0700 (PDT)
Received: by 10.229.242.3 with HTTP; Mon, 17 May 2010 12:31:01 -0700 (PDT)
In-Reply-To: <AANLkTimFZ1GCBIf9y8Gkz-AnG-TmvWU_WXfjgw1olmKi@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147256>

On Mon, May 17, 2010 at 2:57 PM, Chris Packham <judge.packham@gmail.com> wrote:
> On Mon, May 17, 2010 at 11:32 AM, Eugene Sajine <euguess@gmail.com> wrote:
>> Hi,
>>
>> Wanted to share some Admin nightmares;)
>>
>> Is there a way to correct a stupid error when few commits were made
>> under username Your Name and the same kind of stub email address
>> instead of normal name?
>>
>> Thanks,
>> Eugene
>> --
>
> There are a few ways (that I know of) to fix this.
>
> If you haven't pushed yet you can use "git rebase -i" [1] and edit the
> commit with "git commit --amend --reset-author" to fix up your local
> branch. Note that --reset-author is a fairly recent addition to git
> but the --author="name <email>" option is available for older
> versions.
>
> If no-one has cloned/pulled from that repository you can use "git
> filter-branch" [2] with an environment filter to update the name.
> Using filter branch (or anything else that re-writes history) is a
> last resort as it will cause problems for anyone that has cloned your
> repository.
>
> The preferred, non-destructive, method would be to include a .mailmap
> file [3] which can be used to remap authors names and email addresses.
> Some of the git tools can be told to ignore the mailmap so that stub
> email address will still be visible if people know where to look but
> thats usually fine unless you _really_ want to hide an email address
> for some reason.
>

Thanks a lot, Chris - that should help!

Eugene
