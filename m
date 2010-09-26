From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] Documentation: Refer to git-commit-tree in
 git-filter-branch help
Date: Sat, 25 Sep 2010 20:04:59 -0600
Message-ID: <AANLkTin+CiNBqn-Zbz4h6M9P7fhYRd3mvwYJ9tzXL-2r@mail.gmail.com>
References: <1284389994-16892-1-git-send-email-wjl@icecavern.net>
	<201009241012.44861.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Sun Sep 26 04:05:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ozgc2-0003vU-Gx
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 04:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265Ab0IZCFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 22:05:02 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61876 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116Ab0IZCFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 22:05:00 -0400
Received: by fxm3 with SMTP id 3so1303994fxm.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 19:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=oOIFS2DIb0O/YmWYV6Wwx/b1MoTAvgSW+8nTjg0OHJ4=;
        b=rngykjc8OttW4WI8YpsboZIkt3HKCIqyH+Py+y88AeKRED/XglQrEGFXRhOKaMhdvf
         kZTq/TZ7KsaNs5wfibXOwuj3YgPTHRladM9Q4DZNF5XWVyhzt97dWPFzME3s+O/p07zL
         QjFIUuYMWob2OVllBuLjI7KobuX0Ev0ZAnaP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gCIYNQw2Zr/6uDIMwXljXkPAJhdbpHymLehQjPMTZxozVe223CDvjkNSTC/Hu8k+0i
         F06epDxwzYIkM1KRc5/z7YAFCxwdrvseDn1v84icsEQcDTsfwbkNOBy71n6DCN/yVckk
         tQ9ZGFldZoXldIndChknpCi93bchn8dAa+gmI=
Received: by 10.223.115.19 with SMTP id g19mr5458102faq.70.1285466699589; Sat,
 25 Sep 2010 19:04:59 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Sat, 25 Sep 2010 19:04:59 -0700 (PDT)
In-Reply-To: <201009241012.44861.wjl@icecavern.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157208>

On Fri, Sep 24, 2010 at 10:12 AM, Wesley J. Landaker <wjl@icecavern.net> wrote:
> On Monday, September 13, 2010 08:59:54 Wesley J. Landaker wrote:
>> Currently, the help for git filter-branch refers users of --env-filter
>> to git-commit for information about environment variables affecting
>> commits. However, this information is not contained in the git-commit
>> help, but is very explicitly detailed in git-commit-tree.
>
> Was there something disagreeable about this patch, or did it just get lost?
>
> I'd like to help make it easier for others who might find themselves on a
> hunt for the right environment variables for --env-filter like I was.

I'm guessing it just got lost; the patch looks good to me, and I think
it makes for a nice improvement for folks trying to find the
information they need.
