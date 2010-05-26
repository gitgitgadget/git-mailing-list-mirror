From: Nazri Ramliy <ayiehere@gmail.com>
Subject: Fwd: [PATCH] Man page section reference should be in uppercase
Date: Wed, 26 May 2010 16:33:26 +0800
Message-ID: <AANLkTingglKSMHOcHXTg3hGF_czcFsnWLTd3GuSp-Mm6@mail.gmail.com>
References: <1274756484-27867-1-git-send-email-ayiehere@gmail.com>
	 <1274813122.1178.8.camel@localhost.localdomain>
	 <AANLkTilKSLCGMgHwB4TdojtemnxYLrGsAJGHQcLJNVwL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 26 10:42:01 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHCBc-0005CW-No
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 10:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756099Ab0EZIlq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 04:41:46 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58752 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab0EZIlp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 04:41:45 -0400
Received: by gyg13 with SMTP id 13so2647804gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 01:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/ri76ylmxq4o+SNPK5TNnlKm1DeoeGMMMEyxge8+NZk=;
        b=WZDfWh9qaxBvkz4IH6gmuWAqv3FiVL6+K8T0OSji23f/PMI+fpKbwcZI8/w5PUUMK4
         71nTjoU1jooxIHx+pjdSfJYFFWJN08pd7ZUEZ3HLhfu/2FIpPWcB6Gh/56fBNXLk29xY
         iAQqfD/2jX7Rl+e5eoQGCd6xyGJeLEM3Y3kpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=t4HT64yj5o/uJEbp55+k0KWymGCAJTHQzasbki+3xqF8vcaWY0PephiPBjEzTewbzo
         cDhFEL+DrmJY8pvqCw4FjatPS4R5BMtF8X4DcxVTCQG3Z4WUCzMKeErtB54wQravNggP
         qFOKjQ67apzGREhB7sUvrMUVsl7PYtpZo3GlQ=
Received: by 10.91.173.6 with SMTP id a6mr4175026agp.110.1274862806490; Wed, 
	26 May 2010 01:33:26 -0700 (PDT)
Received: by 10.90.90.2 with HTTP; Wed, 26 May 2010 01:33:26 -0700 (PDT)
In-Reply-To: <AANLkTilKSLCGMgHwB4TdojtemnxYLrGsAJGHQcLJNVwL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147783>

I forgot to reply to the list as well when sending the (now forwarded)
message below.

Apparently only D=E9vai Tam=E1s received it, and replied to me:

D=E9vai Tam=E1s wrote to me:
> I didn't know that. Thanks for pointing out.

Apology for the top-posting-ish nature of this email.

I guess when forwarding an email verbatim, it's ok to top post it with =
a
header of some sort?

nazri.

---------- Forwarded message ----------
=46rom: Nazri Ramliy <ayiehere@gmail.com>
Date: Wed, May 26, 2010 at 9:52 AM
Subject: Re: [PATCH] Man page section reference should be in uppercase
To: D=E9vai Tam=E1s <devait@vnet.hu>


On Wed, May 26, 2010 at 2:45 AM, D=E9vai Tam=E1s <devait@vnet.hu> wrote=
:
> I don't really agree with this, but it might be only my personal
> preference. Reasons:
>
> The section title in the man page is "typeset" in a "different font" =
to
> be easily distinguishable from the surrounding text -- therefore it's
> all capital. On the other hand, changing the reference in the advice
> given by git-push to be all uppercase will give a needless emphasis o=
n
> the referred section title. This is wrong IMHO, because the main poin=
t
> of the advice is not this reference, but the earlier sentences (i.e. =
the
> push was rejected).

Keeping the reference to be in lowercase goes against what is
currently practiced the man pages of git commands. =A0Have a look at th=
e
output of

=A0 =A0 =A0 =A0$ git grep '"[A-z ]\+" section'

See how all of them use all-caps when referring to man page sections.

If the user is already familiar with the non-fast-forward push issue,
they would know how to proceed and ignored the 'needless' emphasis.

But for a user who is clueless about the non-fast-forward push issue th=
e
emphasis is good and even more important than that is that it is
spelled out in the same exact form as how it will be rendered when the
user run 'git push --help', IMHO.

nazri.
