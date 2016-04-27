From: Elijah Newren <newren@gmail.com>
Subject: Re: make test Unexpected passes
Date: Wed, 27 Apr 2016 15:39:42 -0700
Message-ID: <CABPp-BHFQCmu_xGNXaKAC=PjQ5+QCS9etbNSoQ3PCDHptzRWQA@mail.gmail.com>
References: <571A8404.5030200@ramsayjones.plus.com>
	<CABPp-BFdzu4stEfbGAiqDwRAXt7EcvYBEVz1kChJaR4udC5SXA@mail.gmail.com>
	<xmqqoa8u7lmi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Ben Woosley <ben.woosley@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 00:39:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avY7Z-0006QV-9W
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 00:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbcD0Wjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 18:39:45 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36617 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbcD0Wjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 18:39:43 -0400
Received: by mail-io0-f195.google.com with SMTP id k129so8659944iof.3
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tlZtQQC1N5Ck8x3ksQzMRquYjeEQpzim9/bDoWVoF28=;
        b=w0/gT5XSTqDcq6vGh5TjX+GX5acg6Ve3QZmLO/W22yWDMhNRk2pyMF0DE35ecUbpAi
         1bvDZwYnBb5LkJGo8UupmJRgklEOoFWtSMDfDIc9PUQMUGxZXuNGQb8jNoMpYg+jUX6Y
         kWbCOrZ+7TLgPMZyNU/HrPXaYD0lqyhj9+AaSLET7O5tnRmhEGc2YfXf7WFQp0fRUeWK
         1djawsn6ggsM9bY23vPs/hWQeGz6/GQ4SQpjuWA8Ae8KqzETqtWVdXFYCLeJSdtIRuQU
         mexepyzi7NtFQJjwyN51vP6PU32UfbiyjTxJ3ZfDHmnqQ0ohv6xcCcVRKmQxoEPZzlYi
         rmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tlZtQQC1N5Ck8x3ksQzMRquYjeEQpzim9/bDoWVoF28=;
        b=T3dhUUvnDOZtYCjl7ooDMbD86Tft3YuVsFWFrRsS5kAlS5L00ZPm/zVfC2HjB+oTHU
         7FFU7YHjKLz2c3BcbCihFsQBXJn7tXAWB8cCky86Vn5IceFg4lJDFN3YxiT84vMhpCAr
         cnp5cqHucSGw2ONc4KJJ4xNB1QED2AN4oOCy/jUXdmLnFmwM0nQATIvvZx0X4TuL6BBz
         nl5MDLukQl7NgQGk2aBftlU+oE0R5O+7QiCkR28S54kwph6t4nbMGCygZyhheD5N0dMR
         yrDYtWgjYm0ik9UwSxJfrmV50y2UwLxJneGhff55Ywnte1qJLp5U8NCgv1hKHuNSOfuf
         GytQ==
X-Gm-Message-State: AOPr4FWSxyQf3O72DcdUuXkn9kigyAkHKcBR5Zo8WkDTAozqSLi2vQZzgj4H52OR63rGPRQZu9jiiTEYUil03w==
X-Received: by 10.107.2.70 with SMTP id 67mr14091405ioc.70.1461796782726; Wed,
 27 Apr 2016 15:39:42 -0700 (PDT)
Received: by 10.64.0.173 with HTTP; Wed, 27 Apr 2016 15:39:42 -0700 (PDT)
In-Reply-To: <xmqqoa8u7lmi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292836>

On Wed, Apr 27, 2016 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Isn't what the test expects bogus in the first place?  I'd suggest
> removing the test as "pointless waste of resource".
>
> Comments?
>
> -- >8 --

Yes, toss it; I find your arguments below compelling.

> Manual merge resolution by users fundamentally depends on being able
> to tell what is the tracked contents and what is the separator lines
> added by "git merge" to tell users which block of lines came from
> where.  You can deliberately craft a file with lines that resemble
> conflict marker lines to make it impossible for the user (here, the
> outer merge of merge-recursive also counts as a user of the internal
> merge) to tell which part is which, and write a test to demonstrate
> that with such a file that "git merge" fundamentally cannot work
> with and has to fail on.  It however is pointless and waste of time
> and resource to run such a test that asserts the obvious.
>
> In real life, people who do need to track files with such lines that
> have <<<< ==== >>>> as their prefixes set the conflict-marker-size
> attribute to make sure they will be able to tell between the tracked
> lines that happen to begin with these (confusing) prefixes and the
> marker lines that are added by "git merge".
