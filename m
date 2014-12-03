From: David Aguilar <davvid@gmail.com>
Subject: Re: Deprecation warnings under XCode
Date: Wed, 3 Dec 2014 02:04:17 -0800
Message-ID: <20141203100415.GA4893@gmail.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
 <547BFD42.3040104@web.de>
 <xmqqoarnp7p2.fsf@gitster.dls.corp.google.com>
 <CAPig+cRvGaFJQZZ8CDeMMB6u1NKtqUrfe1aWC0OUG3xF9Nu34g@mail.gmail.com>
 <CAO2U3QiwJ=EZBModED6jR2YuF5NMVvrUkzj1iOGMLAqwKNbw3A@mail.gmail.com>
 <CAPig+cRj5bLrkperGiDHG78KghiGgkMAT=Qihia2FR8psEQxvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Bernhard Reiter <ockham@raz.or.at>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 11:04:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw6nN-0000ca-K4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 11:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbaLCKEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 05:04:24 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49151 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbaLCKEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 05:04:21 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so15458209pab.7
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 02:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6+zwV38TbQ8SYIJMMzlDowZ9wnfhOb77UvNlLYaIUx0=;
        b=p0QjEZkBTp2EXnPkE6mvEiMFecBnMbpU/oHRhIriUP4CblIsEmUWmCcuHOL8rmU+Oi
         wTrjOnlvpbit0I1yAnFwcdyZJn+d3WhQ2e6lYMUjTjz5mn0TOvOOA09RrZ1w43XxxlHA
         gK8iXAomRB9QBiwtudOngVppptj++diuT2FX8wMFC/bq6kbJG7zQ/BCM6wcboqRmlU4G
         7ycVo18k0ZHPJ7hsJPHW8FrofD0J2veyN3HQWRuFEyx2o0nzEPbTSmVzCg91SMLml80L
         hzR4ZlfpAzfUw06CyF4bbVUaRtiSCQw/PaOZkVainGX8pMHg3iFeHADICcJmqtdy/vl1
         b5hw==
X-Received: by 10.68.218.7 with SMTP id pc7mr14317273pbc.80.1417601060515;
        Wed, 03 Dec 2014 02:04:20 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id ej12sm5882851pac.28.2014.12.03.02.04.16
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 02:04:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAPig+cRj5bLrkperGiDHG78KghiGgkMAT=Qihia2FR8psEQxvQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260641>

On Tue, Dec 02, 2014 at 10:09:35PM -0500, Eric Sunshine wrote:
> On Tue, Dec 2, 2014 at 8:12 PM, Michael Blume <blume.mike@gmail.com> wrote:
> > On Tue, Dec 2, 2014 at 4:37 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> On Mon, Dec 1, 2014 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>> I am not a Mac person, but is this about APPLE_COMMON_CRYPTO support
> >>> added in 4dcd7732 (Makefile: add support for Apple CommonCrypto
> >>> facility, 2013-05-19) and be4c828b (imap-send: eliminate HMAC
> >>> deprecation warnings on Mac OS X, 2013-05-19)? [...]
> >>> In the Makefile we seem to have this:
> >>>
> >>>     # Define NO_APPLE_COMMON_CRYPTO if you are building on Darwin/Mac OS X
> >>>     # and do not want to use Apple's CommonCrypto library.  This allows you
> >>>     # to provide your own OpenSSL library, for example from MacPorts.
> >>>
> >>> which makes it sound like using APPLE_COMMON_CRYPTO is the default
> >>> for Mac.  Perhaps those who do want to use CommonCrypto to avoid
> >>> warnings should not define that macro?
> >>
> >> It's been a long time [1] since I looked at it, but I believe that
> >> David's CommonCrypto patch series only replaced OpenSSL calls for
> >> which Apple had provided CommonCrypto replacements. If my memory is
> >> correct, there were still plenty of OpenSSL deprecations warnings
> >> remaining after his patches (the warnings which started this thread)
> >> even without defining NO_APPLE_COMMON_CRYPTO. Thus, David's patches
> >> reduced the number of warnings but did not fully eliminate them.
> >>
> >> Checking again, it still seems to be the case that Apple neglects to
> >> provide CommonCrypto replacements for these OpenSSL functions which
> >> Apple itself deprecated.
> >>
> >> [1]: http://thread.gmane.org/gmane.comp.version-control.git/224833
> >
> > If there's actually no way to address this, is there a simple way to
> > silence deprecation warnings only in this file? I only ask because
> > overall the git build seems to be extremely quiet, and it seems
> > valuable to preserve that, so that warnings we want to act on stick
> > out.
> 
> An individual developer can add '-Wno-deprecated-declarations' to
> CFLAGS to suppress these warnings, however, that's pretty much a
> sledge hammer which would impact deprecations from all included
> headers, not just Apple's. For this reason, we probably wouldn't want
> to make this the default.
> 
> The potentially lesser evil would be this small patch (minus Gmail
> whitespace damage) which disables the deprecation warnings only for
> Apple's headers:
> 
> ----- >8 -----
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 400e921..709e84f 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -211,6 +211,8 @@ extern char *gitbasename(char *);
>  #endif
> 
>  #ifndef NO_OPENSSL
> +#define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
> +#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
>  #include <openssl/ssl.h>
>  #include <openssl/err.h>
>  #endif
> ----- >8 -----
> 
> It's still mildly heavy-handed, in that it could silence legitimate
> Apple deprecations, but it does give us a clean build with little
> fuss. An alternative would be to relegate these #defines to the Darwin
> section of the Makefile if placing them in git-compat-util.h seems too
> invasive.
> 
> Considering that Mac OS X is now at 10.10 and these deprecations
> commenced with Mac OS X 10.7 in July 2011 (3.5 years ago), and Apple
> still has not provided drop-in CommonCrypto equivalents, it seems
> unlikely that they will do so any time soon. Consequently, suppressing
> these otherwise unavoidable warnings may be the best we can do.
> 
> I'm willing to formalize and submit this as a proper patch if it's not
> considered too disgusting by the powers-that-be.


Tweaking those internal #defines can only come back to bite us
in the future when the functions are finally ripped out.

CommonCrypto seemed like a viable option at the time, but the
remaining deprecated functions don't have any replacements and
I wouldn't hold my breath waiting for CC to provide them.

It seems like a better approach might be something like [1].
I'd even suggest ripping out all of the commoncrypto stuff if it
makes the final curl-ified code easier to read.

libcurl 7.30.0 ships with OS X 10.9 (maybe even father back?)
so making imap-send default to using openssl for <= 10.8 and
curl for newer OS X seems like a good long-term solution.

[1] http://thread.gmane.org/gmane.comp.version-control.git/255171
-- 
David
