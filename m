From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git-send-mail in sh
Date: Sun, 27 Nov 2005 19:49:05 -0500
Message-ID: <438A5401.3070008@michonline.com>
References: <4386DD45.6030308@op5.se> <20051125163358.GF16995@mythryan2.michonline.com> <43874415.8040302@op5.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB10F355AE5EEA7745CA48BD8"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 28 01:50:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgXCr-0001fd-MF
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 01:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVK1AtM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 19:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVK1AtM
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 19:49:12 -0500
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:62628
	"EHLO h4x0r5.com") by vger.kernel.org with ESMTP id S1751164AbVK1AtL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 19:49:11 -0500
Received: from [10.254.251.12] (helo=mythryan)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.54)
	id 1EgXCf-0000uj-Os; Sun, 27 Nov 2005 19:49:10 -0500
Received: from localhost ([127.0.0.1])
	by mythryan with esmtp (Exim 4.54)
	id 1EgXCf-0000eP-9s; Sun, 27 Nov 2005 19:49:09 -0500
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43874415.8040302@op5.se>
X-Enigmail-Version: 0.93.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12841>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB10F355AE5EEA7745CA48BD8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andreas Ericsson wrote:
> Ryan Anderson wrote:
> 
>> On Fri, Nov 25, 2005 at 10:45:41AM +0100, Andreas Ericsson wrote:
>>
>>> Finally giving up on git-send-email (I won't install the 6
>>> perl-modules it requires and I don't know perl enough to remove the
>>> need for them), I hacked up a replacement in sh. It's more aptly
>>> named as well. ;)
>>
>> Scanning the list, 2 are related to option handling (one of which is
>> builtin), one isn't used (Data::Dumper), and two are related to sending
>> valid emails.
> 
> When I try to install Email::Valid (using apt) it wants an additional
> two modules. Mail::Sendmail wants one other, so that's Data::Dumper, the
> two actually used and the three those two use. Six, for short.

Can I ask why you aren't willing to install packages, such as those?  I
can understand a reluctance to install modules directly from CPAN, on an
otherwise package-managed system, but I'm afraid I must confess to
puzzlement over a reluctance to use pre-packaged modules.

The major flaw in git-send-email, from my perspective, was a lack of
support for SMTP AUTH, for situations like Junio's, where the local MTA
(and thus "mail" as well) are not configured to handle SMTP AUTH. Moving
to a purely shell based replacement seems to make this an even harder
feature to support.  (Though, admittedly, I haven't even made an attempt
to add it to the Perl version yet.)

>> The email address verification is ridiculously hard to get
>> correct, so using pre-written code for that seemed justified.
>>
> 
> But it isn't necessary to validate it to such exactness. Nothing worse
> will happen than the user chiding himself for his butterfingers if
> he/she makes a mistake.
> 
> Besides, I think typos are by far the most common error. Those are
> usually valid email addresses while still not being correct.

Fair enough.

--------------enigB10F355AE5EEA7745CA48BD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDilQEfhVDhkBuUKURApBxAKClDcbVPE1tuxPB3EUGjlNqxtMF/ACffju/
LppxobieQyJFioLTTGrL/R0=
=1+iE
-----END PGP SIGNATURE-----

--------------enigB10F355AE5EEA7745CA48BD8--
