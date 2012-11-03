From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Wrap commit messages on `git commit -m`
Date: Fri, 2 Nov 2012 23:38:56 -0700
Message-ID: <20121103063855.GA8326@elie.Belkin>
References: <CALkWK0kQ+qCsOa87yY4wma279mp+9h+LFv3qCP_qrNdDyGNcsQ@mail.gmail.com>
 <m3a9v170ca.fsf@black.gullik.net>
 <CAO54GHDRBDyQYvo-g_xEvsQJRgtfbbT-4-kop8hoSK1D37G44w@mail.gmail.com>
 <20121101221203.GE6213@elie.Belkin>
 <CALkWK0n3nvu4neica==bXaGCtDish8cfUhcsmJT0w3ihrq6coA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin <ikke@ikke.info>,
	Lars Gullik =?utf-8?Q?Bj=C3=B8nnes?= <larsbj@gullik.org>,
	git <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 07:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUXUY-0002OU-AU
	for gcvg-git-2@plane.gmane.org; Sat, 03 Nov 2012 07:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab2KCGjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 02:39:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63987 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab2KCGjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 02:39:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2882134pbb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jHO9iBou9yNVFwWvfOyZORBCYs/nDIQVAYlSMx+6n5A=;
        b=X8l7c9nFpxhwcIKOdPPWtTkYE7nBp1+QsTCBXuVci6DcSc/HD3hzolDasUkAqJK1NZ
         QGKzFKf9AdUQ4wsB5jlUi6mfmEfEZjigwj+wX/xH5RVkQ/ksJbfjE7RlpWTFBPcu+mBR
         IKiKOMXqFFv0TNemWirCl1+0DhMDqpu3ZedDV+JXvgUlXQyo068zr1mKAtkVpfGyBPGm
         N0LNRRHZGsqTOn8B86V0b53m1JtF+CvQFiuR8FfwbufQySloJtKSDyovhvubdKVZjStf
         apaVlVK623doEdDkTKhE/ImcHUpJFv8FsPtTpTmCCGHbk0yvOGzrwsE4j8bz9HXOVAVl
         nE+A==
Received: by 10.68.201.6 with SMTP id jw6mr12697283pbc.149.1351924742952;
        Fri, 02 Nov 2012 23:39:02 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id j4sm6941660pax.31.2012.11.02.23.39.01
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Nov 2012 23:39:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0n3nvu4neica==bXaGCtDish8cfUhcsmJT0w3ihrq6coA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208977>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> Ram, what platform do your colleagues use?
>
> Red Hat Enterprise Linux 5.

Oh, ok.  In that case I blame habit.

I think the best option you have is to just complain to your
colleagues about the long lines.  Then they would get a chance to
explore what the UI currently offers and to complain to this list
(perhaps via you :)) about missing features that would make their work
easier.

To put it another way: I don't see yet how a hypothetical "git commit
--wrap-lines -m 'long message'" would make life easier than just
running "git commit" and entering the message using $EDITOR.  There's
probably a UI or documentation bug lurking somewhere, so thanks for
thinking about these things.

Regards,
Jonathan
