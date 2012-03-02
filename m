From: David Barr <davidbarr@google.com>
Subject: Re: Google Summer of Code 2012... and git wiki
Date: Fri, 2 Mar 2012 15:06:25 +1100
Message-ID: <CAFfmPPMPi0W=26FGrJ5Qw512CmfHS3sg7mnouU9oQtNj9SxfZw@mail.gmail.com>
References: <201203020027.41016.jnareb@gmail.com>
	<20120302005638.GC21835@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 05:06:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3JlH-0002hL-G5
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 05:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757548Ab2CBEG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 23:06:27 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64202 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026Ab2CBEG0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 23:06:26 -0500
Received: by yenl12 with SMTP id l12so634983yen.19
        for <git@vger.kernel.org>; Thu, 01 Mar 2012 20:06:25 -0800 (PST)
Received-SPF: pass (google.com: domain of davidbarr@google.com designates 10.236.191.100 as permitted sender) client-ip=10.236.191.100;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davidbarr@google.com designates 10.236.191.100 as permitted sender) smtp.mail=davidbarr@google.com; dkim=pass header.i=davidbarr@google.com
Received: from mr.google.com ([10.236.191.100])
        by 10.236.191.100 with SMTP id f64mr11066188yhn.57.1330661185969 (num_hops = 1);
        Thu, 01 Mar 2012 20:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=HXsscM/RdZ/2C01lW+OcxKGsHDajNMKtHZA+XXc8Me8=;
        b=GplKl/8KEB0j3PvWu5wFdAMe/wsP54BAGIn7p0uENK5C3USjXmwO78DiAsw2wKp4ob
         YJGea1GxaGr1RQzZDANdmUQNqvnk7QsTC8OowZa34Awpmn9W86/iuKQhjRoFqS0Ol94d
         WUefAlOB/3LZTX+JVuWgzYgaTHOAXVBjBkTPG50CDheH7lu2DhpkBbF9fyFfLXHAuEG8
         ccm9G/NqqJiBTnIsvAWD5I+OtPgUTTamqI5dxWDDLJgs1yyCmi2QauPJtQexQ5y4bD4P
         f3iQf1xA4bFXHxS7+yf0LK/RPYBna6im+RsyrCQQg2dsYhDY/MgO5MFXMrUmYxnzSdZg
         +26A==
Received: by 10.236.191.100 with SMTP id f64mr8774763yhn.57.1330661185918;
        Thu, 01 Mar 2012 20:06:25 -0800 (PST)
Received: by 10.236.191.100 with SMTP id f64mr8774756yhn.57.1330661185839;
 Thu, 01 Mar 2012 20:06:25 -0800 (PST)
Received: by 10.101.154.34 with HTTP; Thu, 1 Mar 2012 20:06:25 -0800 (PST)
In-Reply-To: <20120302005638.GC21835@sigill.intra.peff.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQlK4puRqOkD1I2Q5mDToGkzq3lm6dSDE92yxtLK4T9UYNh9GcoWql2cSaCmVuRb1SmBFpnc/oy3PAsVQhgzUZzxJIO5/Z90nM3COda4O9o8LDl/XPv9Mac4wGTsenP9cSsB5DVCT1AHr+I/egGfAfz9pX13Pw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191997>

On Fri, Mar 2, 2012 at 11:56 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 02, 2012 at 12:27:40AM +0100, Jakub Narebski wrote:
>
>> Google Summer of Code 2012 has started. =A0The Git Development Commu=
nity
>> has time till March 9 to submit organization application.

>> I don't know what are ETA on bringing Git Wiki fully up, but I doubt=
 it
>> would be possible at http://git.wiki.kernel.org -- it is more than t=
wo
>> months since the event and wiki is not functional yet. =A0Perhaps it
>> could be hosted at git-scm.com somewhere - =A0but it really should b=
e
>> true wiki, editable without need to use git.
>
> FWIW, I really like the GitHub wikis, because they are backed by git.=
 So
> you can choose whether to use the web interface or not. And you can
> write in a variety of markup languages, including mediawiki, though w=
hen
> I tried importing the old git wiki many moons ago, I noticed that the
> formatting of many of the pages was not quite right.

Since we are enumerating the options, I'll mention that
code.google.com also has wiki support and that the wiki content is
exposed as a git remote.

  git clone https://code.google.com/p/git-mirror.wiki/

I'm not sure how the syntax compares to mediawiki and friends.

  http://code.google.com/p/support/wiki/WikiSyntax

--
David Barr.
