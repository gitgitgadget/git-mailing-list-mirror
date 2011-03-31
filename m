From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: GSoC questions
Date: Thu, 31 Mar 2011 14:06:05 +0300
Message-ID: <20110331110605.GA14892@jakstys.lt>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
 <20110328001152.GA11294@elie>
 <AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
 <AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
 <AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vicent Marti <vicent@github.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org, Jeff King <peff@peff.net>
To: Alexandru Sutii <sutii.alex@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 13:06:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Fhd-0000ct-37
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 13:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240Ab1CaLGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 07:06:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34326 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab1CaLGG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 07:06:06 -0400
Received: by wwa36 with SMTP id 36so2652902wwa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 04:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FJYCpzjJsGsR9MPpXemP1r7Io7VQDbgP6xfYy4yeZDY=;
        b=gq5OXl17U8nX1yQK1veGGI3Wd47az3CeY7RhxEoNFMM8SulrT+tiBbiGoMXvLeeCJZ
         9SvEExmJZFsO+qQw13ouDRfHhf4IjMcD8XBFHkK1gzlE7AlVdkJtBBuwe0g8hK6QKdC4
         rNrZ5KKfSHPef9UYE2af65hivvJcAdWycIYjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B6nwo0OZSQNEE+80OoTiWCDBfznfWrJQPl/DGbs0u5unzYporAGrHaQZdTuvZ5LFKT
         PfLtFoXK6Ng55AporzLFQPdrny8fwGjQDX8UyLnAH2BWomygmgOFYrGLsdT4XqHs9efe
         hIhC00ciQk6xFPH91eMUX3/CMfKWpgvcqJz8k=
Received: by 10.227.207.21 with SMTP id fw21mr2616419wbb.138.1301569563870;
        Thu, 31 Mar 2011 04:06:03 -0700 (PDT)
Received: from localhost ([78.56.137.167])
        by mx.google.com with ESMTPS id y29sm583949wbd.4.2011.03.31.04.06.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 04:06:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170468>

On Thu, Mar 31, 2011 at 12:36:15PM +0300, Alexandru Sutii wrote:
> I began implementing the minimal git client[1]. I have implemented the
> "git-mktag" command. For this I have modified the "mktag.c" file from
> the "builtin" directory in order to make it run with libgit2. Basically the
> input file verification code is the same with the original one. I have just
> extracted the sha1, the object type, the tag name, the tagger, the
> comment and created a tag with git_tag_create.

Hi there,

I started git2 client a couple of days ago and implemented a rough
version of rev-list.c (which shows rev-list of HEAD. It is here:
https://github.com/Motiejus/git2/

Vincent van Ravesteijn forked and made some modifications:
https://github.com/vfr-nl/git2/
Thanks to him for CMakeLists.txt.

> 
> I have also used the original "usage.c" and "git-compat-util.h" for
> error handling.  Is there a problem if the git2 client will reuse
> non-gitcore code, such as string parsing code, parameter parsing code,
> etc?

I think this is what it has to be like. Provided it adds no
requirements and license issues.

> 
> Can someone look on my code and give me some feedback?

You have done a good job in creating handlers and hooking up the
repository. Thank you.

> 
> Just before ending the implementation of the mktag command I have
> started thinking that maybe there was no need to reimplement this
> command, as it can be considered that libgit2 already has this
> feature.  Even if it is so I am not sorry I did this, because by
> reimplementig it I had the chance to get used with git code and with
> libgit2 API.

Don't know about the actual tag implementation, but in any case, the
wrapper (glue) code around the tag very helpful.

Best,
Motiejus
