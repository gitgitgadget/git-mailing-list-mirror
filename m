From: Scott Chacon <schacon@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 14:58:47 -0700
Message-ID: <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net> <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino> <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org> <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
 <20120426201921.GA15026@burratino> <20120426210251.GA31589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"David E. Wheeler" <david@justatheory.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 23:59:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNWia-00043f-NK
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 23:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755801Ab2DZV7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 17:59:10 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34332 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032Ab2DZV7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 17:59:09 -0400
Received: by qatm19 with SMTP id m19so4487681qat.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 14:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZKRjhGLEsRer6ghyr9NVMn6Pn5U65fnl+19zxQRAQFc=;
        b=RPvqlhOUFElJ8EBd/9kHFdg+8bq3JT+CK7K2uINYp5atnnKUvtyeVSaRpSA5OeV+xA
         aqmFXT32UDMHFit4zplRVTOGr7ukjuzttXoW7fmR9OSicPG8dtf5FqAKdUb0Lv7sJ+sV
         tWI2+V8D5O1bfQ0whMSHCXSmxhpNtmDhTFUf3BsIWdYY7j1mrTl4lpih21nj1bd7eQlj
         RvwypJXxndHgSMg3R19F+esSlYkHYxhS8XsQ/rLufxI76gQT4xFTwe/FBVTOsppFc9Vj
         kqNsrAT6uLYdakz5a7sFjH2mbFlh0GSzKzhC80DnQ9cop40i05nf77vkHdDHi5kXR/Z/
         5g2g==
Received: by 10.229.136.203 with SMTP id s11mr1944302qct.38.1335477548492;
 Thu, 26 Apr 2012 14:59:08 -0700 (PDT)
Received: by 10.229.163.210 with HTTP; Thu, 26 Apr 2012 14:58:47 -0700 (PDT)
In-Reply-To: <20120426210251.GA31589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196418>

Hey,

On Thu, Apr 26, 2012 at 2:02 PM, Jeff King <peff@peff.net> wrote:
>>
>> Do you know of a public webpage we can count on to continue to serve
>> the docs? =C2=A0I agree that that would be even better.
>
> I think http://git-scm.com/ would be the ideal place. My understandin=
g
> is that the re-work of the site is nearing completion. Scott, ETA?

Yes, we are very close to launching a big redesign of git-scm.com.
The manpages will be automatically updated on that site, you can
certainly link to them there.

If you want to preview what it's going to look like and the URL
structure, you can check out the current working version here:

http://git-scm.herokuapp.com/docs/git-fetch

There are a number of known bugs and I want to make it much faster
before I officially launch it and redirect DNS, but you can get an
idea of how it will be structured and what it will look like.  If you
want to start generating docs with static urls for man pages, they can
be of the form: http://git-scm.com/docs/git-command

You can also put a version number after them to permalink them at a
certain version:

http://git-scm.herokuapp.com/docs/git-fetch/1.7.3.2

When it's close to what I think is ready, I'll do a post to this list
looking for feedback and bugs, etc.

Scott

>
> -Peff
