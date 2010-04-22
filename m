From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Fri, 23 Apr 2010 03:23:42 +0530
Message-ID: <x2xe72faaa81004221453t373c1d2atcea9e0119302b2f6@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004191243.24209.jnareb@gmail.com>
	 <20100419115113.GC3563@machine.or.cz>
	 <201004202014.19477.jnareb@gmail.com>
	 <k2le72faaa81004211349o1628ed42s4fa0aa412006128@mail.gmail.com>
	 <20100422202501.GJ10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Apr 22 23:53:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O54LH-0007Wo-Vd
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 23:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967Ab0DVVxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 17:53:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51016 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671Ab0DVVxn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 17:53:43 -0400
Received: by gyg13 with SMTP id 13so4712084gyg.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 14:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=SFrzOp+UFR3acY4XXfX43291elYXxO2UkGqISio/w5M=;
        b=Cba8JdtlKOzkV9h5zx3piGEgiqec8mmoaehpn6HzPZmH2xNve7r4F6DKsBXPxcZX6k
         RyVsJG7UHTXZV2a5do5eHXCdJIjs1lwG1RbAyxr02fGL4zam1bvLa4UAWOOFzQA3FCB0
         RNcmLyXdfSFuDi+1gItpLVSskd6ycZOrO/3Jw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=xBR4Yrcx6IIVfVEvPouj/4fKJ9TMCjwOQePuErIqNW28umqnbUKWk/ZSdK6S1VxfaC
         2ODEFf6YK06miDicI0k9ELrp2lT+WILm3nucQpQhmz5xMgo6gm/aXchvr2kOoYn2xgAa
         oQC7KptIdVAJHqUvddaVm2xFUEkwnetB8zDp8=
Received: by 10.90.51.18 with HTTP; Thu, 22 Apr 2010 14:53:42 -0700 (PDT)
In-Reply-To: <20100422202501.GJ10939@machine.or.cz>
Received: by 10.91.95.15 with SMTP id x15mr5406233agl.104.1271973222639; Thu, 
	22 Apr 2010 14:53:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145569>

>> The lib directory will also contain
>> some basic modules like Gitweb::Repo, Gitweb::Commit which will make
>> developing further functionalities easier.
>
> Beware, this might be an awful can of worms. The previous gitweb SoC
> project failed to get merged in part due to trying to do something like
> this.
>
> I recommend to avoid any large architectural changes and just shuffle
> around all the utility routines to lib/Gitweb.pm or so.

Yeah sure.

>> d) Usage of the client:
>>
>> This client can be used in 2 ways.
>>
>> * Install a local version using instaweb - The gitweb will be only
>> accessible by you. You can browse through the git repository using
>> read modules and simultaneously work on them using write modules.
>> * Install on intranet - A company when installs this gitweb along with
>> some other login and account managing scripts will be able to order
>> their employees to login and ask them to work on the code with out the
>> security risk of providing ssh access to the git repository host. The
>> authentication support can be implemented as an optional part of my
>> proposal.
>> * Install on web - Just like normal gitweb, or enable write modules to
>> look like gist.github.com
>
> Note that for the latter two, operation mode without working copy is
> essential; I have not seen you address it anywhere.

I am not planning to write the "operation mode without working copy"
during GSoC due to reasons I mentioned earlier. But I would like to
add it as an optional part for GSoC along with the authentication
wrapper.

So, When I complete the main parts of my GSoC proposal, you will be
able to use it in your localhost working on your local repos. If I
have time during GSoC I will complete the auth wrapper and "without
working copy" mode. Otherwise I will develop them after GSoC. Then you
can use the write functionalities in repo.or.cz without actual working
copies. :-)

Thanks
-pavan
