From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Fri, 19 Sep 2008 09:10:24 +0200
Message-ID: <36ca99e90809190010n40d0a4w26975e87e17a822e@mail.gmail.com>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
	 <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru>
	 <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
	 <alpine.LNX.1.00.0809181526190.19665@iabervon.org>
	 <20080919050612.GA4423@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Daniel Barkalow" <barkalow@iabervon.org>,
	"Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Kirill Smelkov" <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Fri Sep 19 09:11:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kga9O-00038G-U2
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 09:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbYISHK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 03:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbYISHK0
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 03:10:26 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:16821 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYISHK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 03:10:26 -0400
Received: by wx-out-0506.google.com with SMTP id h27so79337wxd.4
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 00:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HqQRA+x2VQcoOE+hQkd1SPmiL4sL9TCGmDB6lcdCJZg=;
        b=IDExwMNefqnA1psGkrdfO20YWTwaotXjQmqsk8vFTuy+fd28bdUpDfTRy/rtpitjPQ
         AAXx2W/IfqlsPZR7MlTuCK+P/RPk2fDjJd9ARocR+TQOzMM+fn/CKIkPXNUKNZZd8wu3
         oFA8U13Q3rbMF59iU6NN9p9QMfk2Z7YcfON7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UMGjzYiW8YPd6UMbovghJ4pn5mDGaDdMSfGn0EQBPDOspqVMnGTqBp+HHap2djT5HM
         gMEOIdv6AO7WrWABUnmDLvQ7vlqmjLTDkLSv7hfbg3fsehQOSiGfhKFGv8qFIiNrjHvi
         Ed2Xubz9kuZWPEOcQ0oAxmx957McxZDQ0Y2P4=
Received: by 10.70.24.4 with SMTP id 4mr5602897wxx.24.1221808224680;
        Fri, 19 Sep 2008 00:10:24 -0700 (PDT)
Received: by 10.70.36.14 with HTTP; Fri, 19 Sep 2008 00:10:24 -0700 (PDT)
In-Reply-To: <20080919050612.GA4423@roro3>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96261>

On Fri, Sep 19, 2008 at 07:06, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
> On Thu, Sep 18, 2008 at 03:30:35PM -0400, Daniel Barkalow wrote:
>> On Thu, 18 Sep 2008, Bert Wesarg wrote:
>>
>> > On Thu, Sep 18, 2008 at 18:29, Kirill Smelkov <kirr@landau.phys.spbu.ru> wrote:
>> > > Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
>> > > ---
>> > >  .gitignore |    2 ++
>> > >  1 files changed, 2 insertions(+), 0 deletions(-)
>> > >
>> > > diff --git a/.gitignore b/.gitignore
>> > > index 8868f2d..aa39db4 100644
>> > > --- a/.gitignore
>> > > +++ b/.gitignore
>> > > @@ -18,3 +18,5 @@ tg-import.txt
>> > >  tg-remote
>> > >  tg-remote.txt
>> > >  tg
>> > > +
>> > > +*.swp
>> > can't you do this in your .git/info/excludes?
>>
>> It's generally better to put a core.excludesfile entry in your
>> ~/.gitconfig pointing to a ignore file with editor temporaries for the
>> editor(s) you personally use. This will then apply to all git projects you
>> work on.
>
> Yes, this makes sense, thanks.
>
> I've had to add the following to my ~/.gitconfig
>
> [core]
>    excludesfile= /home/kirr/.gitignore-kirr
>
>
> because it does not work when '~' is used for $HOME
>
> [core]
>    excludesfile= ~/.gitignore-kirr # does not work
Have you tried:

  [core]
     excludesfile = .gitignore-kirr

There was a discussion about relative files in config. but I didn't tried this.

Anyway, I think this is the best solution. Don't globber the repos with this.

Bert
