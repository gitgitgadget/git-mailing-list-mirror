From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] gitweb/INSTALL: GITWEB_CONFIG_SYSTEM is for backward compatibility
Date: Tue, 16 Apr 2013 08:47:09 -0400
Message-ID: <CAM9Z-nkbBS5qvbkocdGWj7rwtSxB86+R4jdjcBOxCU4YjtgZ1A@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 14:47:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US5I3-0005Zn-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 14:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab3DPMrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 08:47:11 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36238 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab3DPMrK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Apr 2013 08:47:10 -0400
Received: by mail-ie0-f181.google.com with SMTP id as1so423440iec.12
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 05:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=kmkXp+ToWFCNO9O6W+6qRb5NdZ9cHYaf5LjhVtUp2gk=;
        b=glIaMBw61sopr5IKN9V4IzZmRilLhjb3ax8i8Un6iSyEeJ/IMn+KcVZCQhj0PDxHq2
         fDhP8z4HVAn6/tfdQuOGr4qvRhg9adUqT9uU6chiBvHZsEkJsDBSkhbzrTGQcsiOeZ0o
         Km7jrS59F5c3tRncxi664Q1h0q9HGdQl7G25hR7vc3yYkfIClXfeIt2lyuWYP1nrh4eQ
         MlT+j0uNojOqQOxZ84fdhfgc6JVOJgRdaV6kOnMVI3cQ3ubOH8KlV+JmhSqrSn51+N96
         JuELymsm5ve3qSKjxWZDD2kBbvF+AJH0i2iJlOVXAlD6WK2VY/e9eMxjSYuvWirDw0k9
         pRtg==
X-Received: by 10.43.8.200 with SMTP id ot8mr1008930icb.11.1366116429415; Tue,
 16 Apr 2013 05:47:09 -0700 (PDT)
Received: by 10.42.173.70 with HTTP; Tue, 16 Apr 2013 05:47:09 -0700 (PDT)
In-Reply-To: <516D4359.2070501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221411>

On Tue, Apr 16, 2013 at 8:26 AM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:

> Drew: gitweb(1) or gitweb.conf(5) solution is more involved, so
> perhaps something like that?


That or: (or both I suppose....hopefully not too mangled by Google's
mail gadget)

-- >8 --
Subject: [PATCH] Documentation/gitweb.conf.txt: Move note about config
order precedence

To go along with Jakub Narebski's cleanup of gitweb/INSTALL; making
it clear that gitweb's config files work differently than a lot of
other system-wide software. This is unobtrusive yet to the point.
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
