From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Encoding problem on OSX?
Date: Wed, 11 Aug 2010 04:23:11 -0500
Message-ID: <20100811092311.GA16901@burratino>
References: <AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com>
 <20100809234620.GA6418@burratino>
 <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
 <20100811075503.GD5450@burratino>
 <AANLkTin1bspb+bzt6P1Fz7Q11=F2ZBftC19XQuQqHL+B@mail.gmail.com>
 <20100811082953.GA16456@burratino>
 <AANLkTim5Z7M0CypudaGtb2UuON5ajf3Xn=hz6oAJwv8w@mail.gmail.com>
 <20100811084443.GF16495@burratino>
 <AANLkTinS0BeHWNJ0mCtTbVRz=7FBwE0_OTKDfS2gPXdN@mail.gmail.com>
 <AANLkTi=sBNmMoZmqO_-AFNO6bVqtJmXbdXYUf7-bKars@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
X-From: git-owner@vger.kernel.org Wed Aug 11 11:24:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj7YK-0004yD-DG
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 11:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab0HKJYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 05:24:47 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54269 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546Ab0HKJYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 05:24:47 -0400
Received: by gyg10 with SMTP id 10so4033803gyg.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=PqVDydRLcQ1cYX9R/LxlzX9Pg8lmaKefc4iRBpRoPhY=;
        b=Zth/T26Ng8RktUm5GU/TSd6CgzNniiLNahiXU6Ddc4/zWxRxnvpMgqtQ0wvd5WtncT
         22a5oONXngFZYtbbOd09ZMaW41xorVX5uR8V14HwU1CA9/pVHt/fZgUlCbCoIarJJhii
         y3/X9LhYNKAtRI6GFHRtPwfBg0IMBZwqp5/gQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=lxO3k90R7dPInB/FNn2JdaK259J9iA3Qq5vcd5FlPlX0t0LBwLAHA6F8ZvT03V8zKQ
         AVC3Hmm+Uiymrf3ycY3JYSTqjj1kDYPMr/K2ESBHlxuok3PN0tK3ChkUy6NeFJ0XUjDy
         QV6RLpB6sC+2n20fIUdJWOC73oRoWDWjGWMtc=
Received: by 10.151.21.18 with SMTP id y18mr20925256ybi.296.1281518686157;
        Wed, 11 Aug 2010 02:24:46 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u41sm7150078yba.22.2010.08.11.02.24.45
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 02:24:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=sBNmMoZmqO_-AFNO6bVqtJmXbdXYUf7-bKars@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153219>

=C4=B0smail D=C3=B6nmez wrote:

> Downgrading my sed to v 4.1.5 fixed the issue. Thanks for your help!

I just read BUGS in the sed distribution.  Strangely enough the above s=
eems to
be correct behavior:

  Another common localization-related problem happens if your input str=
eam
  includes invalid multibyte sequences.  POSIX mandates that such
  sequences are _not_ matched by `.', so that `s/.*//' will not clear
  pattern space as you would expect.  In fact, there is no way to clear
  sed's buffers in the middle of the script in most multibyte locales
  (including UTF-8 locales).  For this reason, GNU sed provides a `z'
  command (for `zap') as an extension.

However there is still a sed bug as far as I can tell, since in the
test suite, LC_ALL is set to C, and using the C locale is the
suggested workaround in the GNU sed docs.  This explains where my
first suggested diagnostic messed up: presumably

 printf 'Th\360\235\204\236s\n' | LC_ALL=3DC sed "s/.*//"

would print

 <treble clef>s

and

 printf 'Th\370\235\204\236s\n' | sed "s/.*//"

would print

 ????s

with your copy of sed 4.2.1.

Well, I learned something new today.  Still thinking over how to fix
this in the test suite.  Thanks again.
