From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward compatibility
Date: Tue, 16 Apr 2013 08:52:01 -0400
Message-ID: <CAM9Z-nm2GM+LoKSK4K_qsvCdL-EfE+-B7meOoS4hVDsVSb9CTg@mail.gmail.com>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
	<85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
	<7v4nfch90r.fsf@alter.siamese.dyndns.org>
	<20130412064837.GA5710@elie.Belkin>
	<20130412064953.GB5710@elie.Belkin>
	<7vy5cnd0m4.fsf@alter.siamese.dyndns.org>
	<516888C0.90501@gmail.com>
	<CAM9Z-nmOzpJdT3ni0rYRkg7Z26N5XSRyqp0TkTY79AAZ85pw2A@mail.gmail.com>
	<7vobdfnlc7.fsf@alter.siamese.dyndns.org>
	<CAM9Z-nm=SUNAHXZtOnz_BSS8VrVYPczicX99FUmDJe6Lj_oKpQ@mail.gmail.com>
	<516D4359.2070501@gmail.com>
	<CAM9Z-nkbBS5qvbkocdGWj7rwtSxB86+R4jdjcBOxCU4YjtgZ1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 14:52:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US5Mo-0003hP-7s
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 14:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354Ab3DPMwF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 08:52:05 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:56949 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754633Ab3DPMwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 08:52:04 -0400
Received: by mail-ia0-f178.google.com with SMTP id w21so363014iac.23
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=ewgU730h6rhpGM49PTQKO4mKJHeLdbch6BNgNP4RdFU=;
        b=oDYrgJCBl4XdnpZNKWBeLZO4C3eMc/9yBvyhHrGtKGqi4JKlqi4Y+7UOIzT0NLpPlu
         ENWZCk/cBx62bLh5DujMbBwoWeApXy0f7oo+oX+ZbfwlheGBnGB5FiZUECMYYKFZG+Yo
         KMZry4e6oVfEPdvlgRHayFruSiZjJZHQT7kSLhcXUPJDbbAE1+SsE/u7OeHdaJP+DoY6
         gfd5hk9Ud7zFngARtBwt8LyHi9QS7/XiLAbMYdyMCysPXM7GyvEVuIky3D3ppj7GoYrv
         dwNew7IVM3KJnwFmmT/N17cQPef52hkY5JDOMQCBanSAKBwpNAUMr35GCv/yPgI34nr2
         vwxw==
X-Received: by 10.50.66.133 with SMTP id f5mr7815502igt.38.1366116722326; Tue,
 16 Apr 2013 05:52:02 -0700 (PDT)
Received: by 10.42.173.70 with HTTP; Tue, 16 Apr 2013 05:52:01 -0700 (PDT)
In-Reply-To: <CAM9Z-nkbBS5qvbkocdGWj7rwtSxB86+R4jdjcBOxCU4YjtgZ1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221412>

=46orgot the S-O-B...

On Tue, Apr 16, 2013 at 8:47 AM, Drew Northup <n1xim.email@gmail.com> w=
rote:
> On Tue, Apr 16, 2013 at 8:26 AM, Jakub Nar=C4=99bski <jnareb@gmail.co=
m> wrote:
>
>> Drew: gitweb(1) or gitweb.conf(5) solution is more involved, so
>> perhaps something like that?
>
>
> That or: (or both I suppose....hopefully not too mangled by Google's
> mail gadget)
>

Subject: [PATCH] [PATCH] Documentation/gitweb.conf.txt: Move note
about config order precedence

To go along with Jakub Narebski's cleanup of gitweb/INSTALL; making
it clear that gitweb's config files work differently than a lot of
other system-wide software. This is unobtrusive yet to the point.

Signed-off-by: Drew Northup <n1xim.email@gmail.com>
---
 Documentation/gitweb.conf.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
index eb63631..05c81e7 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -55,7 +55,8 @@ following order:
    then fallback system-wide configuration file (defaults to
'/etc/gitweb.conf').

 Values obtained in later configuration files override values obtained =
earlier
-in the above sequence.
+in the above sequence. This is different from many system-wide softwar=
e
+installations and will stay this way for historical reasons.

 Locations of the common system-wide configuration file, the fallback
 system-wide configuration file and the per-instance configuration file
--
1.8.0

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
