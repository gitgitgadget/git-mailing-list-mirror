From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 11:02:04 -0700
Message-ID: <20140424180204.GL15516@google.com>
References: <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
 <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
 <20140424154717.GB7531@thunk.org>
 <CALbm-Ea4oAQ+JsYu6Zo06ONMbtp8AhgFqDC485BRKsM36EVQXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 20:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdNyR-0007iO-C6
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 20:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbaDXSCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 14:02:10 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48018 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757450AbaDXSCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 14:02:08 -0400
Received: by mail-pa0-f50.google.com with SMTP id rd3so2191548pab.37
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 11:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9akk0GbNH5rd1mw4A2/uKXMMWjpSUFv2yz+gt4VWERo=;
        b=XWnQGNZE8sJwUcvitao6dT06H82fdLLEw0QkgHyvIFgrs61Xcaye+R7BW0EztFtWIb
         rHsLE/W2RvdOibTNVtAUpa29KY/BCAl5aLkq7dbcFLyCEWPV08ElAgJM1M/V/PYf/BZl
         D2kb24IJeQlufMFK5SkCkYY+swniI+yOJQPLb4aWfNygKGepkcZRH9t4UHcqL1sQrAgU
         J6w7lKRYXdiFy+ZzonLX+K5/w5ODQgjeJCSB+JGh7Iaxmh+eFIGtz0wqyuaY5OWPHAn0
         Miw8UqJf9jmm0RfSlKHBJe5B4D5opeacZfaWYm5p+ku3rCTae+b6p38ZZYtR+rLCEIqa
         LkhQ==
X-Received: by 10.66.221.99 with SMTP id qd3mr1743965pac.46.1398362527994;
        Thu, 24 Apr 2014 11:02:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vm3sm10459508pbc.45.2014.04.24.11.02.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 11:02:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALbm-Ea4oAQ+JsYu6Zo06ONMbtp8AhgFqDC485BRKsM36EVQXw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246983>

Stefan Beller wrote:

> I may have missunderstood.
>
> So today you cannot commit if you don't provide an email address
> (usually the first time you try to commit, git asks to "git config
> --global author.email=<you@mail.here>"), if I remember correctly, so
> there is definitely a valid (i.e. user approved) email address.

Not true.  But you do get a big wall of text when you make your
first commit without an EMAIL envvar or configured [user] section,
including

| You can suppress this message by setting them explicitly:
|
|     git config --global user.name "Your Name"
|     git config --global user.email you@example.com
|
| After doing this, you may fix the identity used for this commit with:
| 
|     git commit --amend --reset-author

Ciao,
Jonathan
