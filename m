From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: git submodule summary doesn't return an error when passed a wrong commit/rev
Date: Fri, 26 Oct 2012 21:56:02 +0200
Message-ID: <CAC9WiBj8-TmJmOowcA2KK7xYVoGoVZ8NoeTdRP9Qj6_RYr0ChQ@mail.gmail.com>
References: <CAC9WiBgdgy1bwh0c16jd017q2rqQAq-suDADn2-vGw9eubBs_w@mail.gmail.com>
	<508AEA39.2020205@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRq0v-0007oD-Fy
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 21:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966293Ab2JZT4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 15:56:04 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44637 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966287Ab2JZT4C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 15:56:02 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so3010460oag.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K5zydRIA2D7/eav6ARJpwb4ktVCvB+Xd+MtbEgxUJQs=;
        b=HvHQRj8HDti9d0bPxSpBZf2UFqsRPxkZZcboaOoXCDs+KLgbpjoEs6ZEyZCGh80ZzJ
         uv2s/Xd+bqx3brkzE+5vJ5v/6cUYWYn/nWkQo9KfXtkwBO76hrwPTfiqj1sIPRNdtn9u
         Z0ipqsVVmYDjVSUon2B8DkmjlqSbT53Axme7tjp5GaQWdrCMfxGkt27BX8BI9FUpJfaR
         ke31+0e8whgpjkLPfTYjSI2tkeHDCoNEl+SRcYs+cH874jqrwYltkTL3iBkBdUrwmVo+
         md7ar3/1ixX/6F5MNOmvGB6q4HjgfpDO2fzBycN4UwFDXqWn1KMSdbyvvD4p2bJ4a69y
         v4Bg==
Received: by 10.182.38.69 with SMTP id e5mr19572685obk.79.1351281362445; Fri,
 26 Oct 2012 12:56:02 -0700 (PDT)
Received: by 10.60.93.163 with HTTP; Fri, 26 Oct 2012 12:56:02 -0700 (PDT)
In-Reply-To: <508AEA39.2020205@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208489>

On Fri, Oct 26, 2012 at 9:53 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 26.10.2012 16:03, schrieb Francis Moreau:
>> it seems to me that when passed an unknown rev or a wrong commit/sha1,
>> git-submodule-summary should at least exit with an error status. Even better
>> would be a error output.
>>
>> Test was done with git version 1.7.10.4 from debian wheezy.
>
> Thanks for your report, I think you found a real issue. Some quick
> tests showed some problems with other parameter combinations too.
> I'll take a deeper look the next days.

Glad to help :)

-- 
Francis
