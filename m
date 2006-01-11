From: Beber <beber.lkml@gmail.com>
Subject: Re: Proxy and authentication
Date: Thu, 12 Jan 2006 00:08:49 +0100
Message-ID: <4615f4910601111508x3c31fbddmd4caa140f2602991@mail.gmail.com>
References: <4615f4910601110653k5e2e8ffapb962a8b0829eeb11@mail.gmail.com>
	 <46a038f90601111026j1fd6f8e2pcafb4437c4b458fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 00:09:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewp5R-0003Cs-6F
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 00:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbWAKXIx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 18:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWAKXIw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 18:08:52 -0500
Received: from uproxy.gmail.com ([66.249.92.198]:35302 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932502AbWAKXIv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 18:08:51 -0500
Received: by uproxy.gmail.com with SMTP id s2so77110uge
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 15:08:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L+ip6wDrVfCBeiQXzOW2I8MK+Jx26dX9DbD6Z13FrSfQtY+WniJnGxt6ZO4YwvfpSr+7g4vboDZi3yCvFXJw0pjLkDEkaIhKTsoK09WI8qthi/R1It7BqJbevtsU9VSn5Cls8Po3QPDWtdRRqf8nGQYret5e5aVjurXLuGi7vk0=
Received: by 10.66.254.12 with SMTP id b12mr480508ugi;
        Wed, 11 Jan 2006 15:08:49 -0800 (PST)
Received: by 10.66.242.15 with HTTP; Wed, 11 Jan 2006 15:08:49 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601111026j1fd6f8e2pcafb4437c4b458fe@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14523>

On 1/11/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 1/12/06, Beber <beber.lkml@gmail.com> wrote:
> > Is there plan to allow proxy authentication and http/webdav remote
> > repository authentication ?
> > It seem that's it's quiet non-working for now.
>
> search the list archives for more detail, but
>
>   export http_proxy=http://my.proxy.tld:8080/
>   git foo
>
> should work. Have you tried embedding auth details in the url? Try
> http://user:pass@my.proxy.tld:8080/

Yes it works if you have a password without any strange characters
like @ : and so

>
> cheers,
>
>
> martin
>
