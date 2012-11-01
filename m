From: Thomas Adam <thomas@xteddy.org>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Thu, 1 Nov 2012 18:12:22 +0000
Message-ID: <CA+39Oz7iuSPh2DqQFoO9o+V3TouMUy8T00KgXEP0vY758=S5gA@mail.gmail.com>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 19:12:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTzG8-00054P-EP
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 19:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761934Ab2KASMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 14:12:39 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59223 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754097Ab2KASMj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 14:12:39 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2832862obb.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=ROkSGktnc9iZA4vk8xF5On7SmT4k21lQUhPDVuyhx9o=;
        b=wJZliwvEHbSqA0b9iW9nrN3WESpkBLFlN4WwgCnrgfnA/Xr76kr8vZQKQwESFJDUl5
         GcQdyyiJ9zKyUFNTw4xJBV2t28Lissz2JV3YYn0BqeZktnWnZI0ZP22CWYDrsSreG9Od
         3eD88cZUrK66Em6dUnFxkp8BBUZMFQFlYyl2bC5x3m/bvFedOSAQaWQ96cf8aO3Qqkgp
         OWjK42YGRBS6p9zAK4zpP0KgsF3BbKUCJPIZPmNGxDEKXV1seVlQNlTdc+mDUgw6AVSH
         8TuUtUk9jW6Xsa6BO1a7VNMmTDVCVdqzNYpiGUbNQ2VTmlP6+pqHOQmzodyu7/g/rxQ+
         oj0Q==
Received: by 10.60.7.225 with SMTP id m1mr35940689oea.122.1351793558492; Thu,
 01 Nov 2012 11:12:38 -0700 (PDT)
Received: by 10.182.109.35 with HTTP; Thu, 1 Nov 2012 11:12:22 -0700 (PDT)
In-Reply-To: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
X-Google-Sender-Auth: UmX4fPGWxpV7ENIAn5EEgFFKk7o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208883>

Hi,

On 1 November 2012 16:07, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
>
> Hi,
>
> Some of my colleagues are lazy to fire up an editor and write proper
> commit messages- they often write one-liners using `git commit -m`.
> However, that line turns out to be longer than 72 characters, and the
> resulting `git log` output is ugly.  So, I was wondering if it would
> be a good idea to wrap these one-liners to 72 characters
> automatically.

Can't you do this already?  From "git-log(1)":

 %w([<w>[,<i1>[,<i2>]]]): switch line wrapping, like the -w
option of git-shortlog(1).

-- Thomas Adam
