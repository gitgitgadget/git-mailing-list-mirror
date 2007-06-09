From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Port git-tag.sh to C.
Date: Sat, 9 Jun 2007 03:58:32 +0200
Message-ID: <1b46aba20706081858u7f18d9b2o5602db43d396c19@mail.gmail.com>
References: <11813427591137-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Kristian_H=F8gsberg?=" <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 03:58:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwqDu-0000NY-Lx
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 03:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756222AbXFIB6e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Jun 2007 21:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbXFIB6e
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 21:58:34 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:19991 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbXFIB6e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 21:58:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1284084wah
        for <git@vger.kernel.org>; Fri, 08 Jun 2007 18:58:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVnSBjCiSOL5sS7pzm4sW9jevOyGEGQDeaQxeyfRllaWoBCIaWnUqsQOpmcNvnq+BS9JvniZObdw99OwDL3UjaogbCrVe2sfw+fSbKpfzkgIn9IqtpXN6gpUSklgrO2ormD1WEKJtou259mqLrNkNwDeO8FbaI0Tvl8SWb26YfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gyIzGRkP6YYirzJBw/s2DNi3T1MiZ2BVfCpacJbsKqO7+YOa4U/+gITq3VCuEs8l+yTn6kqqbGqA230GYtfRlpsoku/0lkjm3yQq2icBIaC9G9cL75b9Lbv1NoMLbSxlAwJwe04/Yy/qLGAKHHlS1BfJWsZEFbStX7gKZ+0Og3s=
Received: by 10.114.136.1 with SMTP id j1mr3120412wad.1181354313002;
        Fri, 08 Jun 2007 18:58:33 -0700 (PDT)
Received: by 10.114.57.10 with HTTP; Fri, 8 Jun 2007 18:58:32 -0700 (PDT)
In-Reply-To: <11813427591137-git-send-email-krh@redhat.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49550>

2007/6/9, Kristian H=F8gsberg <krh@redhat.com>:
> Ok, here's an updated version that passes the test suite.  Johannes, =
I
> leave it to you and jasam to merge the bits you find useful, but as
> far as I see it, this conversion is complete, and there's enough othe=
r
> shell scripts to port.  My port doesn't pass jasam's test suite, it
> looks like he is expecting the -l glob to be a regexp, but the
> git-tag.sh I started from used shell globs.

That's a good proposal! I agree with your version for matching tag name=
s,
apart from the fact that the code is more compact and readable that way=
=2E

I will review your code comparing it with mine and I will report
everything I feel. However, my desire is to get builtin-tag.c and its
tests t7400-tag.sh complete
in a few days or less, so I would appreciate every other correction
from you in order to get it ready faster.

> Anyways, it'd be nice if you or jasam could keep the list a little
> more in the loop with the SoC changes, it is where most of the
> development happens, after all.  What's next on your list?

You're right, the development will be more open than now was, I
usually ask questions in the IRC channel and obviously that's not the
best way to report my work to everybody.

=46eel free to choose the script which you need to get replaced first,
or, depending on your urgency, you could ask me for one of them and I
would try to concentrate my efforts on it. Why do you started with
git-tag? For me, it was enough easy to begin with, perhaps you could
have other reasons.

Looking forward to work with you on that,

Carlos
