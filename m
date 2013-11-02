From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git reintegrate 0.1; manager of integration branches
Date: Sat, 2 Nov 2013 05:18:35 -0600
Message-ID: <CAMP44s2pydOZOdHEzDOm+57LbiFr-QgAE_3Xk6QfpDULMAs9xQ@mail.gmail.com>
References: <CAMP44s2cuHnW0cGEBRt2EmG8Wmav4athMLXRCh2cJ2KymeHmmg@mail.gmail.com>
	<20131102110028.GD24023@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Nov 02 12:18:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcZEG-0006CF-G2
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 12:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab3KBLSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Nov 2013 07:18:39 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:46663 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab3KBLSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Nov 2013 07:18:38 -0400
Received: by mail-lb0-f179.google.com with SMTP id w6so4121989lbh.24
        for <git@vger.kernel.org>; Sat, 02 Nov 2013 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zZpmhVVcz67fS+VisRDBkxOio/QOCXzNDJB4yppVeZA=;
        b=0EaXM80Ijburd+c2xckk7WzucKB/ILReVmwWBGa8JfjE+7ZMAk5x9eA8Sqc2UShLaP
         kmIgC9mA4sokbhZYdxYOqUYD4j0Xwf4xTQ3G0Ara8lQZzEKli/BDD1NKmSTfztMHyB70
         utYSLGXCDJoqOv1pyrblt5XeJQmMbWD7oj0XCExilQkSl96UmUy+wJNf8j9SbGu62Jnx
         /5M1mAaL9gTkrtGkXuLlU00hiddASRHQzV44GgPo+XjWliRqAzHL+OKe4mzViA+pLxi4
         KjpP3ZezGLORoK43IcYnN91vnSwMCLl21f0fAI9cXQF1jfxBtEsZKjv/nYUHmBb9ufFJ
         UCCQ==
X-Received: by 10.152.10.99 with SMTP id h3mr4634164lab.13.1383391115904; Sat,
 02 Nov 2013 04:18:35 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Sat, 2 Nov 2013 04:18:35 -0700 (PDT)
In-Reply-To: <20131102110028.GD24023@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237241>

On Sat, Nov 2, 2013 at 5:00 AM, John Keeping <john@keeping.me.uk> wrote:
> On Fri, Nov 01, 2013 at 06:35:39AM -0600, Felipe Contreras wrote:
>> One feature that is missing from git-integration is the ability to
>> parse existing integration branches.
>
> Nice - I'd never thought of doing this.

I tried to provide all the functionality of todo:Reintegrate, or at
least the important one.

>> It also has support for "evil merges", so it should be perfectly
>> usable for git.git maintenance.
>
> By this, do you mean that you have an ability to squash a fixup into the
> merge?  If so, how do you handle this in the status display - I've had a
> WIP branch for a while but haven't come up with a satisfactory way of
> displaying the status of a fixup.

Yes, I did basically what you did, however, I skipped the status part.
I think it's more important to be able to do these fixups, even if
they don't show on the status.

And to be honest I don't care much about the status feature in general.

Cheers.

-- 
Felipe Contreras
