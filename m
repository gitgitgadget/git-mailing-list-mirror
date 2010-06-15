From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [GSoC update] Splitting gitweb & developing write functionalities
Date: Wed, 16 Jun 2010 02:03:50 +0530
Message-ID: <AANLkTinfJOOT8NJ942bB_Sil4sGNthpk9hxvA60Y_iGB@mail.gmail.com>
References: <AANLkTikapZa0N7xroxhdlmm7LUvlNp-7GZy7XeG-zprC@mail.gmail.com>
	<20100615201720.GI3109@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 15 22:33:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOcpb-0006rE-2G
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 22:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758199Ab0FOUdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 16:33:53 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39279 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab0FOUdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 16:33:52 -0400
Received: by gwj15 with SMTP id 15so3557024gwj.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=mao27EnD0KwjviDrNO8kqlajxPEvzHqifKCFVg9iF/o=;
        b=Xv8LNpP1kiFZ/g5TgQpx8zhLxmNF+VuESlS2mymklsOyW/C9Z+FemSDukhBNkqK5xw
         1ynu6Q+NBJMKF4P8e3BSpRGjx+bjlKM1h/wBbMWvNa6FnCvT7vSRXvsSBwP7yChhEqPr
         ePClvF51Ly4UNd2F+j9T2FzWADomHPmnuh8T4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bih18DDibSFZDWBeOfaNWDsy661+j1Nf38STJvOETgvdcYnDMpUoZlbXPXzJ0JCaIE
         xesux9KM5MrACu+cDgLF3T8waJd0FEBYQODrL0Ggw+M3I9z1ePask7/9FCItrOEY4dbM
         E+CFZe8GQd0EwFpdokVhwEhaSCE8XVBc9Pzfs=
Received: by 10.100.16.4 with SMTP id 4mr6609468anp.2.1276634030424; Tue, 15 
	Jun 2010 13:33:50 -0700 (PDT)
Received: by 10.100.126.20 with HTTP; Tue, 15 Jun 2010 13:33:50 -0700 (PDT)
In-Reply-To: <20100615201720.GI3109@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149222>

On Wed, Jun 16, 2010 at 1:47 AM, Petr Baudis <pasky@suse.cz> wrote:
> Hi!
>
> On Wed, Jun 16, 2010 at 01:33:30AM +0530, Pavan Kumar Sunkara wrote:
>> gitweb: Use @diff_opts while using format-patch [master]
>>
>> gitweb: Move static files into seperate subdirectory [next]
>> gitweb: Set default destination directory for installing gitweb [next]
>> git-instaweb: Put httpd logs in a "$httpd_only" subdirectory [next]
>> git-instaweb: Configure it to work with new gitweb structure [next]
>> git-web--browse: Add support for google chrome and chromium [next]
>> Makefile: Use $(sharedir)/gitweb for target 'install-gitweb' [next]
>> git-instaweb: Add option to reuse previous config file [next]
>
> Good job!
>
>> gitweb: Create Gitweb::Git module [Work in Progress]
>> gitweb: Create Gitweb::Config module [Work in Progress]
>> gitweb: Create Gitweb::Request module [Work in Progress]
>> gitweb: Create Gitweb::Escape module [Work in Progress]
>> gitweb: Create Gitweb::View module [Work in Progress]
>
> (Is this the Gitweb::HTML module? Why have you renamed it?)
Yeah I thought it would be better if I have this named as View rather
than HTML :)
>
>> gitweb: Create Gitweb::Util module [Work in Progress]
>> gitweb: Create Gitweb::RepoConfig module [Work in Progress]
>> gitweb: Create Gitweb::Format module [Work in Progress]
>> gitweb: Create Gitweb::Parse module [Work in Progress]
>
> Ok, so we seem to be behind a bit now compared to the timeline? Perhaps
> no big deal but we should be careful; maybe you will have to also start
> brewing some write-support patches while the structure and details of
> the split modules is still undergoing discussion.
>
> Keep up the good work!
>

Thanks,
I would like to start on the writing feature soon enough.

Pavan.
