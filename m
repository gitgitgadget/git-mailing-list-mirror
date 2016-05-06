From: Thierry Suzanne <thierry@yellownemo.com>
Subject: Re: Found possible branch point, then "Use of uninitialized value $u
 in substitution/concatenation"
Date: Fri, 6 May 2016 16:32:53 +0100
Message-ID: <CALZdSA_Fm0oGDYgBcfH0Ohkjw2Op5czqMgy0C9Kkss6MPck_dw@mail.gmail.com>
References: <CALZdSA_pDy=B-bgB-vjpi1yjgtse_-07ewXSX0_GsYhLfOUbzw@mail.gmail.com>
	<CAP8UFD0k0Kx306S3y-Kd5328j0MDNL+ewCJvXbsJ1nzsJYRdtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 17:33:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayhkR-00087o-My
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 17:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758550AbcEFPcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 11:32:55 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:34768 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758212AbcEFPcz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 11:32:55 -0400
Received: by mail-ig0-f193.google.com with SMTP id kj7so5308235igb.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yellownemo-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rqjvwts8cw7M4bYHSF/WEoJiiCGuhXhJsUOQh+Rkb28=;
        b=fwPaZoJsVec9n/J6CPMugvCCo0yaMPmhHn9/zRVYZ6QxMe9iC+dnRPvyfE3HycJxlM
         AcE0BHmmcTKi4FCUh/9HjQIrmBl7t+hcDsZ/xEQDXRuHPTahi6w+syjwQJ1mwlwRd2VC
         GQHoo9u8Vo26jtXls9ilCrqjBc9BFAR+BhPUyyCyxJI95XWE1IHlCwi90QbSxxqCc+jg
         fw2yZn1M12I9lWtnW1HiU5j9yb7bPgloQV3op46LQXmXm/BwPJcpyGC5RN864EgOc3VQ
         qScoN1wCkaIW34MMXxe6S8kdgaGUozFHnPlhTvFtipcpeunB75RtokGgsfTpivBy0JB1
         Ztng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rqjvwts8cw7M4bYHSF/WEoJiiCGuhXhJsUOQh+Rkb28=;
        b=Th4Nm3Mi28tv/eBEFQluhFmtJFUUcDESFQ4OIj5Gffs9SIlAIvjvaGrrKO6dGfrGLk
         j6I6Z+awNhdsR+j0yewQpSrzjbaAC4ih8Smq2y+7DVfkKzU3bFH1p8/m6JZbi8deWuDW
         H2RuF1QihSKW9uOJslE8uUFFuVYqjE43aYHwCy1rHTW22OLRYXrlu+SzlFks67cZoJFG
         NsPXyAJVeRBmDI3llKrTdEsmBPJQlvaDu/GE5oO9TPL7DADXSLKuVzXPrJsRDxZFPMXP
         X/l6bm3Qj6KT3HQmwzm+BrQEJdGa1hI9QZH8GgSOwKO01imWr1YQ0879FSpHjgta/ZO9
         l7dg==
X-Gm-Message-State: AOPr4FUUx2JUPp8T7qldwQz+XSj77k28RjpLeoZdA9A2W4nWaA42xa9auYryRRcwkuSsOuxua2WJU2oFLz7mMA==
X-Received: by 10.51.14.137 with SMTP id fg9mr11159681igd.29.1462548773573;
 Fri, 06 May 2016 08:32:53 -0700 (PDT)
Received: by 10.36.8.5 with HTTP; Fri, 6 May 2016 08:32:53 -0700 (PDT)
X-Originating-IP: [86.28.149.6]
In-Reply-To: <CAP8UFD0k0Kx306S3y-Kd5328j0MDNL+ewCJvXbsJ1nzsJYRdtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293789>

Sorry, can't help :(

On 6 May 2016 at 09:27, Christian Couder <christian.couder@gmail.com> wrote:
> Hi,
>
> On Thu, May 5, 2016 at 12:43 PM, Thierry Suzanne <thierry@yellownemo.com> wrote:
>>
>> Looking at svn.pm, I can see we're in find_parent_branch() which
>> outputs the message "Found possible branch point". It then calls
>> other_gs($new_url, $url, $branch_from, $r, $self->{ref_id});
>>
>> which itself calls:
>> Git::SVN->find_by_url($new_url, $url, $branch_from);
>>
>> which calls:
>> resolve_local_globs($u, $fetch, $globspec);
>>
>> and resolve_local_globs is where the error is thrown on line 100/101:
>> my $u = (::cmt_metadata("$refname"))[0];
>> $u =~ s!^\Q$url\E(/|$)!! or die
>>
>> I made a mistake in my command line for sure, so this might not be a
>> bug, I'm just emailing all this if someone think it could be handled
>> differently or a better error shown.
>
> Yeah, there is a die() calls above and also one on line 101, so it
> looks like $u could be checked between line 100 and line 101 and die()
> could be called if it is not properly defined.
>
> Could you send a patch to do something like that?
>
> Thanks,
> Christian.
