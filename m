From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: perl/Git.pm: Writing a test suite
Date: Fri, 30 May 2008 10:03:54 +0200
Message-ID: <b77c1dce0805300103ke5f0259m336ace5f6f7e2e30@mail.gmail.com>
References: <483FB034.3050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Lea Wiemann" <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 10:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1zcE-0006dh-F9
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 10:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbYE3ID6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 04:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbYE3ID5
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 04:03:57 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:65130 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYE3IDz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 04:03:55 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3248040wfd.4
        for <git@vger.kernel.org>; Fri, 30 May 2008 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rWNBVFpeVgd46dKxZ5fB3SKE+L/TjKXlQmjp+P8riM0=;
        b=dorG78JjtIcqZuMIjyuDs37cMD01D4QrKI+NEpghO0oithUvvtVbu8OHdhFB6B/E6dZqBrpQ2sDkCImCccEQYmqrxFvzzERsNXK5WoDcth4TNmH7Pu6Xr/zDcPUwhLijRogpZFCvr3Cg/TQLdi5m/tbn5qpwhNYQ7Id2aNVoeQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jL6ergT5V9Q2Vuv4WPphtNhar/BoAcoIGifPDYIg/MM5irZ1HAF1PEkvMEuomeNSF5sFgATTNyBXJZVMmcS/LhiqMrkaJYrSmOmFq5kDztGXXz6ZrZ9lDJ9W7QbuHSZUUuBl5vBx51OSf9bpH9YTMzr2ee2brGG2lFgcp9LWxG4=
Received: by 10.142.229.4 with SMTP id b4mr2017093wfh.158.1212134634574;
        Fri, 30 May 2008 01:03:54 -0700 (PDT)
Received: by 10.142.212.20 with HTTP; Fri, 30 May 2008 01:03:54 -0700 (PDT)
In-Reply-To: <483FB034.3050507@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83273>

2008/5/30 Lea Wiemann <lewiemann@gmail.com>:
> Git.pm doesn't currently have a test suite, and I think it should get one.
>
> Since Git.pm makes calls to the git binary, it would seem sensible to me to
> create mock output for the external calls, like Grit (a Ruby API) does it,
> here: http://github.com/mojombo/grit/tree/master/test/fixtures  (Having a
> complete test repository to test against like Ruby/Git (another API) at
> http://repo.or.cz/w/rubygit.git?a=tree;f=tests/files;hb=HEAD is probably too
> brittle and makes it hard to test edge cases.)
>
> I haven't done testing in perl before, so if someone wants to exchange ideas
> and/or help me get this set up, please post here or message me on IRC
> (lea_w/lea_1 on #git at Freenode).

Testing is big in the perl world. I suggest to start with reading :
http://www.perlfoundation.org/perl5/index.cgi?testing
I'm not overloaded with tuits at the moment, but I'll try to review a
bit your testing patches when you post them here.
