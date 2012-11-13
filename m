From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] diff: introduce diff.submodule configuration variable
Date: Tue, 13 Nov 2012 21:15:30 +0530
Message-ID: <CALkWK0nJwznx36yoAUKXRnyA+32143tBVJHnnrosz-Ht7VhwHw@mail.gmail.com>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352653146-3932-3-git-send-email-artagnon@gmail.com> <20121113053336.GA10995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:46:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIgi-0002VJ-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab2KMPpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:45:54 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62304 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754530Ab2KMPpu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:45:50 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so7520780oag.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k/QDEh//QiJIClMOzAQLN2k1b+cvCt4GZQZDDgDVJ4M=;
        b=NbJesodp5z3rAwP6Gmi2X0/eMiwkbNUMD0FFzi4JQqYQnLGHNcB7CG5xSMbwNxlj9X
         L6nfZyVJ7M7nJqqq9CWPSBDR+J+21TBd1HLJcfUvBq36qbxYLNW7ULgEfANCmPkeMEs5
         JjiqjfbMvxgkf8/5nnnHsN9RjUxZ/6Yu0X/SYQKiU/9pyiV4m2vrrFibfzWZVfeEvx+5
         jxJfvNmGJNB+t7Hkc+QpnkPHuN/asCBGD2LAa8as5DvGqNh0EDSjagdeiE6gK/3sHTS9
         gR5X1DwduR5eSb2FmsGo7ypD5tFAmQvMOzgZqHbcnOZWoI/fyMLb9l8tX8rmAqOkPHth
         EqAQ==
Received: by 10.60.28.36 with SMTP id y4mr17356293oeg.13.1352821550254; Tue,
 13 Nov 2012 07:45:50 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Tue, 13 Nov 2012 07:45:30 -0800 (PST)
In-Reply-To: <20121113053336.GA10995@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209624>

Jeff King wrote:
> On Sun, Nov 11, 2012 at 10:29:05PM +0530, Ramkumar Ramachandra wrote:
>> @@ -223,6 +238,15 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>>               return 0;
>>       }
>>
>> +     if (!strcmp(var, "diff.submodule")) {
>
> Shouldn't this be in git_diff_ui_config so it does not affect scripts
> calling plumbing?

I honestly didn't understand the difference between
git_diff_basic_config and git_diff_ui_config.  The latter function
calls the former function at the end of its body.  Why are they two
separate functions in the first place?

Btw, I just posted a follow-up.

Ram
