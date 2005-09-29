From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: First cut at git port to Cygwin
Date: Thu, 29 Sep 2005 16:46:51 +1200
Message-ID: <46a038f905092821462d08f86a@mail.gmail.com>
References: <433B3B10.5050407@zytor.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 06:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKqK3-0004xz-A5
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 06:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbVI2Eqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 00:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVI2Eqw
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 00:46:52 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:64077 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751188AbVI2Eqv convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 00:46:51 -0400
Received: by qproxy.gmail.com with SMTP id c12so449377qbc
        for <git@vger.kernel.org>; Wed, 28 Sep 2005 21:46:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YAIRi75lIJif/WYp39X00+u390v4ZKYcQsmOjK9JqBN/K07lq1oshRKizdrktrx3jB5yENg+ujoG6WiqrkDJO44loKoMS697ZGE/zex5xdAQGnL67xbI9L5R7g3nH84mXZCp+rVLNUvm4E7eUPrtOtS2ECJ+q04CB94VIwyICMw=
Received: by 10.64.180.3 with SMTP id c3mr135145qbf;
        Wed, 28 Sep 2005 21:46:51 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 28 Sep 2005 21:46:51 -0700 (PDT)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <433B3B10.5050407@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9460>

On 9/29/05, H. Peter Anvin <hpa@zytor.com> wrote:
> Another funny which I haven't been able to figure out yet is that 'gitk'
> scrunches all its output up into a few pixels at the top of the window.
>   If I maximize the window, I can manually resize most of the panes and
> the output looks correct

This is visible on OSX too, and someone's mentioned it's a Tk oddity
with rootless X. Does it do the same if you run X with a root window?

> I have set up a git-on-Cygwin temporary tree at:
>
> http://www.kernel.org/pub/scm/git/git-cygwin.git

Getting a 404 on that. Doesn't show up on gitweb either. I guess I
have to wait...

Is there a way to get gitweb to "compare" branches using git-cherry? I
often look at branches via git-web and it's impossible to tell what
makes them unique...

cheers,


martin
