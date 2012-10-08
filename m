From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: In search of a version control system
Date: Mon, 8 Oct 2012 23:54:04 +0530
Message-ID: <CALkWK0kCbLxPMbxh=CLAE8UkkNFNqDa1QbtdM_-Q+Qr3SRh46Q@mail.gmail.com>
References: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Maurice Francois <francoismaurice2001@yahoo.ca>
X-From: git-owner@vger.kernel.org Mon Oct 08 20:24:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLI0J-0007DH-JS
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 20:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494Ab2JHSY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 14:24:26 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55064 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461Ab2JHSYZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2012 14:24:25 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so2434612qad.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6gzsfb9R87o9/7Ji9mu0alyWuzfD532cX56yG49xpIA=;
        b=Rk1sgROhN0pmVE4DLKrT/sMMeaebg49faLIe/i4aY1UAToKfp/wH8y9aGiEkWfF5qQ
         dc6LYG7enEaxWy24Y5KbPmG4SHIqWZWKeXgcVaYlrYh8AxiBbddUjZRNET5HNh7powE5
         0FQTjoZ0WMs+UCCAt0xNWxEB70ZQ3U8X2XVrP+3xMo4bns0G6ophhCI69WZPjzXKTA3a
         5c7f7FGOsUlV49hkH1Tf+6/Ja5W1I98EN466LvD+ZQlN21m6LTwk3hOw2bHWJJdrtkGk
         aXCfYoWPFONqAMY1BfezKZa5iQA9cW27nbBvxyihXfVxiLoz0P5nwaAKbE2C3imq2Eno
         gHDQ==
Received: by 10.49.85.202 with SMTP id j10mr44432364qez.59.1349720664830; Mon,
 08 Oct 2012 11:24:24 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Mon, 8 Oct 2012 11:24:04 -0700 (PDT)
In-Reply-To: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207256>

Hi Maurice,

Maurice Francois wrote:
> The needs are not that big, that is to say it is academic and research projects. A project can have dozens of
> Word, PDF and program files (Stata do-files, SAS programs, SPPS syntaxe
> files and R scripts) and their corresponding log files.

Note that Git wasn't designed for big binary files, and doesn't
perform well between them.

> Like many people, I hesitate between Git and Subversion.

I honestly cannot comprehend why someone would choose Subversion over
Git for a fresh repository today.

> I like the idea of distributed version control system. But is that such a system eliminates the need for a real server ? Can we just set up a repository on one of the computers in our workplace and give access to that repository via a local connection or via a remote VPN connection ?

Yes, you can have a "blessed" server, just like in Subversion.  And
yes, you can access it over git://, http://, https://, or ssh://.

> So, is it possible to lock a file while someone work on it ?

No, and I honestly think it's a bad idea.  Read up more about Git, and
try to understand how people work with it.

Ram
