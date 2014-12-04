From: David Aguilar <davvid@gmail.com>
Subject: Re: Deprecation warnings under XCode
Date: Wed, 3 Dec 2014 19:44:08 -0800
Message-ID: <20141204034406.GA5600@gmail.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
 <547BFD42.3040104@web.de>
 <xmqqoarnp7p2.fsf@gitster.dls.corp.google.com>
 <CAPig+cRvGaFJQZZ8CDeMMB6u1NKtqUrfe1aWC0OUG3xF9Nu34g@mail.gmail.com>
 <CAO2U3QiwJ=EZBModED6jR2YuF5NMVvrUkzj1iOGMLAqwKNbw3A@mail.gmail.com>
 <CAPig+cRj5bLrkperGiDHG78KghiGgkMAT=Qihia2FR8psEQxvQ@mail.gmail.com>
 <20141203100415.GA4893@gmail.com>
 <547F081B.6030400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Bernhard Reiter <ockham@raz.or.at>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 04 04:44:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwNKq-0004PL-G8
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 04:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbaLDDoE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Dec 2014 22:44:04 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60901 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbaLDDoC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 22:44:02 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so16876773pde.38
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 19:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KHoVF9jhcMZMZ1sKseoui1ierezv6XcHKj4g4Iu1fK4=;
        b=CydwSCA/ytZMjdJznwpAb43xghUBKPgtL8Kh8BNLbQQ+dkNntDINyaWMRoKDA6xZhg
         jTJrux4jyfSYLpEgWiXLX0+9rkLBqxM/rzpst5uSECBb6kv+CM7WTMUwJdQK9z4gBbtC
         RvCv1vKzzB4ToHFlbFEAmzsIWogb9NfjN/C0biH50U5gKRl3ef2IPhc+NCwltw93/Lkw
         CwU8WUw9l8yI8iakCLcxEWz+kGfYpoSU1zfcPqpwHEKU3h1uljFkyeN7jvBBqTttn3TE
         5CwIvm5yn7HXgeLr0l9vLmLvQFa3dGDLUP26xjchPQl6rWKJsYlsAoKAinK0gc3Dj9mZ
         8s0w==
X-Received: by 10.70.48.166 with SMTP id m6mr15307205pdn.22.1417664641776;
        Wed, 03 Dec 2014 19:44:01 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id e2sm14911066pdo.11.2014.12.03.19.43.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 19:44:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <547F081B.6030400@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260724>

On Wed, Dec 03, 2014 at 01:54:51PM +0100, Torsten B=C3=B6gershausen wro=
te:
> On 12/03/2014 11:04 AM, David Aguilar wrote:
> >On Tue, Dec 02, 2014 at 10:09:35PM -0500, Eric Sunshine wrote:
> >>On Tue, Dec 2, 2014 at 8:12 PM, Michael Blume <blume.mike@gmail.com=
> wrote:
> >>>On Tue, Dec 2, 2014 at 4:37 PM, Eric Sunshine <sunshine@sunshineco=
=2Ecom> wrote:
> >>>>On Mon, Dec 1, 2014 at 1:04 PM, Junio C Hamano <gitster@pobox.com=
> wrote:
> >>>>>I am not a Mac person, but is this about APPLE_COMMON_CRYPTO sup=
port
> >>>>>added in 4dcd7732 (Makefile: add support for Apple CommonCrypto
> >>>>>facility, 2013-05-19) and be4c828b (imap-send: eliminate HMAC
> >>>>>deprecation warnings on Mac OS X, 2013-05-19)? [...]
> >>>>>In the Makefile we seem to have this:
> >>>>>
> >>>>>     # Define NO_APPLE_COMMON_CRYPTO if you are building on Darw=
in/Mac OS X
> >>>>>     # and do not want to use Apple's CommonCrypto library.  Thi=
s allows you
> >>>>>     # to provide your own OpenSSL library, for example from Mac=
Ports.
> >>>>>
> >>>>>which makes it sound like using APPLE_COMMON_CRYPTO is the defau=
lt
> >>>>>for Mac.  Perhaps those who do want to use CommonCrypto to avoid
> >>>>>warnings should not define that macro?
> >>>>It's been a long time [1] since I looked at it, but I believe tha=
t
> >>>>David's CommonCrypto patch series only replaced OpenSSL calls for
> >>>>which Apple had provided CommonCrypto replacements. If my memory =
is
> >>>>correct, there were still plenty of OpenSSL deprecations warnings
> >>>>remaining after his patches (the warnings which started this thre=
ad)
> >>>>even without defining NO_APPLE_COMMON_CRYPTO. Thus, David's patch=
es
> >>>>reduced the number of warnings but did not fully eliminate them.
> >>>>
> >>>>Checking again, it still seems to be the case that Apple neglects=
 to
> >>>>provide CommonCrypto replacements for these OpenSSL functions whi=
ch
> >>>>Apple itself deprecated.
> >>>>
> >>>>[1]: http://thread.gmane.org/gmane.comp.version-control.git/22483=
3
> >>>If there's actually no way to address this, is there a simple way =
to
> >>>silence deprecation warnings only in this file? I only ask because
> >>>overall the git build seems to be extremely quiet, and it seems
> >>>valuable to preserve that, so that warnings we want to act on stic=
k
> >>>out.
> >>An individual developer can add '-Wno-deprecated-declarations' to
> >>CFLAGS to suppress these warnings, however, that's pretty much a
> >>sledge hammer which would impact deprecations from all included
> >>headers, not just Apple's. For this reason, we probably wouldn't wa=
nt
> >>to make this the default.
> >>
> >>The potentially lesser evil would be this small patch (minus Gmail
> >>whitespace damage) which disables the deprecation warnings only for
> >>Apple's headers:
> >>
> >>----- >8 -----
> >>diff --git a/git-compat-util.h b/git-compat-util.h
> >>index 400e921..709e84f 100644
> >>--- a/git-compat-util.h
> >>+++ b/git-compat-util.h
> >>@@ -211,6 +211,8 @@ extern char *gitbasename(char *);
> >>  #endif
> >>
> >>  #ifndef NO_OPENSSL
> >>+#define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
> >>+#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
> >>  #include <openssl/ssl.h>
> >>  #include <openssl/err.h>
> >>  #endif
> >>----- >8 -----
> >>
> >>It's still mildly heavy-handed, in that it could silence legitimate
> >>Apple deprecations, but it does give us a clean build with little
> >>fuss. An alternative would be to relegate these #defines to the Dar=
win
> >>section of the Makefile if placing them in git-compat-util.h seems =
too
> >>invasive.
> >>
> >>Considering that Mac OS X is now at 10.10 and these deprecations
> >>commenced with Mac OS X 10.7 in July 2011 (3.5 years ago), and Appl=
e
> >>still has not provided drop-in CommonCrypto equivalents, it seems
> >>unlikely that they will do so any time soon. Consequently, suppress=
ing
> >>these otherwise unavoidable warnings may be the best we can do.
> >>
> >>I'm willing to formalize and submit this as a proper patch if it's =
not
> >>considered too disgusting by the powers-that-be.
> >
> >Tweaking those internal #defines can only come back to bite us
> >in the future when the functions are finally ripped out.
> >
> >[1] http://thread.gmane.org/gmane.comp.version-control.git/255171
> Yes, but this patch needs 7.34 :-(
> 7.30 (as shipped with Mac OS X 10.9) is missing the CURLOPT_LOGIN_OPT=
IONS
>=20
> Try
> rm imap-send.o
> NO_GETTEXT=3Dyes NO_DARWIN_PORTS=3DYes USE_CURL_FOR_IMAP_SEND=3Dyes m=
ake
> imap-send.o


It looks like 10.10 Yosemite has curl 7.37.1 [1], so maybe it's
better there (I can't verify myself).

Silencing the warnings is a sensible thing to do for older
versions since it looks like there's a smooth upgrade path
via the curl patches.

My original caution was that not having the warnings would make
us forget that the issue existed, but (warning) silence is golden.

[1] http://curl.haxx.se/mail/archive-2014-10/0053.html
--=20
David
