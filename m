X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: git and bzr
Date: Thu, 30 Nov 2006 19:14:30 +0700
Message-ID: <fcaeb9bf0611300414p357e2e90sc6cbd877df0f20e9@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>
	 <456DD76C.4010902@gmx.net>
	 <Pine.LNX.4.64.0611291235590.3513@woody.osdl.org>
	 <87bqmpvlxf.wl%cworth@cworth.org> <456E8147.9070304@gmx.net>
	 <Pine.LNX.4.63.0611301111310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0611300325r3a3fa8av141359c69d2377b5@mail.gmail.com>
	 <ekmgud$oss$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 12:42:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mIzBPdoZJ7KTKupBm5MAaV7e3mFI6U4kkDZSnC3Z83JiAtnOzyOlJm9gOio/0MyE3s2YifD9Ad9wIuaoKemzIAxLWWIEvhgtvXG63eEusbHQHwF9UmYFFuw3UlI9NcPHfR/XR5bwjFVeY42s5vdrGG1yM48iHwr186K4iCtELao=
In-Reply-To: <ekmgud$oss$1@sea.gmane.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32734>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GplEZ-0007TW-I2 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 13:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936278AbWK3Mi3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 07:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936294AbWK3MiK
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 07:38:10 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:52879 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S936270AbWK3MOc
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 07:14:32 -0500
Received: by wr-out-0506.google.com with SMTP id i7so961814wra for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 04:14:31 -0800 (PST)
Received: by 10.78.164.13 with SMTP id m13mr3425089hue.1164888870729; Thu, 30
 Nov 2006 04:14:30 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Thu, 30 Nov 2006 04:14:30 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 11/30/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Nguyen Thai Ngoc Duy wrote:
>
> > On 11/30/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> But here's an idea: tell the user that she has to tell git-commit which
> >> files she wants committed. Yes! That's it. Just tell it the friggin'
> >> files. And if you are a lazy bum, and want to commit _all_ modified
> >> files, git has a nice shortcut for ya: "-a".
> >
> > It reminds me Microsoft Office Assistant :-) Let's make "git assistant
> > mode" that tries hard to guess user's desires and give them guidance.
> > Once they get used to git, they can disable that mode and back to
> > "plain git".
>
> The 'givor' (pun on Vi 'vigor') or 'gitor', or 'gator'.
>
> $ git commit
> [...]
> nothing to commit
> $ givor
> $ git commit
> Givor: You haven't marked any file for commit using "git-update-index <file>"
> Givor: and you didn't provide files to commit with "git commit <file>"
> Givor: so I assume that you wanted to commit all changed files
> Givor: You can use "git commit -a" for that (-a is for --all)

I am serious about that. I haven't thought of it as an independent
command/program though. Can you implement givor exactly like the above
example?

> ;-)
Okay now joke part. This command name is better :-D

$ git commit
[...]
nothing to commit
$ dammit
$ git commit
Givor: You haven't marked any file for commit using "git-update-index <file>"
Givor: and you didn't provide files to commit with "git commit <file>"
Givor: so I assume that you wanted to commit all changed files
Givor: You can use "git commit -a" for that (-a is for --all)

-- 
