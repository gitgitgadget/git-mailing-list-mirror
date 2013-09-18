From: David Aguilar <davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] build: add default configuration
Date: Wed, 18 Sep 2013 13:13:54 -0500
Message-ID: <e8ccfba3-5198-4986-9b9d-1d69b965386f.maildroid@localhost>
References: <1379423650-1311-1-git-send-email-felipe.contreras@gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,=?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncBD6J3AEPVABRBB6346IQKGQEUHJ6UNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Wed Sep 18 20:14:34 2013
Return-path: <git-users+bncBD6J3AEPVABRBB6346IQKGQEUHJ6UNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncBD6J3AEPVABRBB6346IQKGQEUHJ6UNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1VMMGo-0005yd-7F
	for gcggu-git-users@m.gmane.org; Wed, 18 Sep 2013 20:14:34 +0200
Received: by mail-qc0-f186.google.com with SMTP id v1sf2194340qcw.13
        for <gcggu-git-users@m.gmane.org>; Wed, 18 Sep 2013 11:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:x-original-sender:x-original-authentication-results
         :reply-to:precedence:mailing-list:list-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=qBGHpxtN/07tMEWZptc8HgVcaEXWzcs/e4nKpVX3fdQ=;
        b=DJG5wehWBELGzNx6Vo5rIdUhkIr9CSQqa/pDnT2QlmD6Ouo8zLL3cF5VLsbDXKg/0I
         857BSVFyYC7ay49g4xshb6AsdAydbHLucFeTqhxNR3pK0btGnY3gE2nU5p1Yz/6EqBMg
         S4bbYb/T5vD7pyQY+lw1Cp3jmAqGDu6tbA6Zv8DCheObsRTZph5wYpW1YrfoYUd/BYf3
         mCM1A3Yo1PTppiU5DdEFRYoF6le6du3o+n+2rhofkQFNR6O7iZfALmpMkXmdRFUe7yJ7
         F3WP8mYQ3HNqryCoxluTWW2vSsbsuEweGd8zQclSYIAaTSS9t1omGqutEyZzxdleJh1D
         9T8Q==
X-Received: by 10.49.127.177 with SMTP id nh17mr106977qeb.30.1379528073448;
        Wed, 18 Sep 2013 11:14:33 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.49.86.161 with SMTP id q1ls3492092qez.13.gmail; Wed, 18 Sep
 2013 11:14:31 -0700 (PDT)
X-Received: by 10.236.186.101 with SMTP id v65mr14293263yhm.12.1379528071119;
        Wed, 18 Sep 2013 11:14:31 -0700 (PDT)
Received: from mail-yh0-x235.google.com (mail-yh0-x235.google.com [2607:f8b0:4002:c01::235])
        by gmr-mx.google.com with ESMTPS id z45si504407yha.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 11:14:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::235 as permitted sender) client-ip=2607:f8b0:4002:c01::235;
Received: by mail-yh0-f53.google.com with SMTP id b20so3602668yha.26
        for <git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>; Wed, 18 Sep 2013 11:14:31 -0700 (PDT)
X-Received: by 10.236.173.136 with SMTP id v8mr14544235yhl.33.1379528070948;
        Wed, 18 Sep 2013 11:14:30 -0700 (PDT)
Received: from com.flipdogsolutions ([200.10.66.132])
        by mx.google.com with ESMTPSA id r1sm4555318yhf.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Sep 2013 11:14:30 -0700 (PDT)
In-Reply-To: <1379423650-1311-1-git-send-email-felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-Original-Sender: davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates 2607:f8b0:4002:c01::235 as
 permitted sender) smtp.mail=davvid-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe>, <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234976>

Apologies for top post -- anybody have a recommendation for a better app th=
en maildroid?

Will this not conflict with folks that supply their own gitconfig?

I like the idea. Docs?  Also, should this not be done in the C side so that=
 we don't waste time reading the config, and also prevent users from overri=
ding these?

=20

-----Original Message-----
From: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "Br=E1ulio Bhavamitra" <brauliobo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
>, Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tue, 17 Sep 2013 8:23 AM
Subject: [PATCH] build: add default configuration

For now simply add a few common aliases.

  co =3D checkout
  ci =3D commit
  rb =3D rebase
  st =3D status

Signed-off-by: Felipe Contreras <felipe.contreras-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Makefile  | 5 ++++-
 gitconfig | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 gitconfig

diff --git a/Makefile b/Makefile
index 3588ca1..18081bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1010,7 +1010,7 @@ ifndef sysconfdir
 ifeq ($(prefix),/usr)
 sysconfdir =3D /etc
 else
-sysconfdir =3D etc
+sysconfdir =3D $(prefix)/etc
 endif
 endif
=20
@@ -1586,6 +1586,7 @@ template_dir_SQ =3D $(subst ','\'',$(template_dir))
 htmldir_relative_SQ =3D $(subst ','\'',$(htmldir_relative))
 prefix_SQ =3D $(subst ','\'',$(prefix))
 gitwebdir_SQ =3D $(subst ','\'',$(gitwebdir))
+sysconfdir_SQ =3D $(subst ','\'',$(sysconfdir))
=20
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ =3D $(subst ','\'',$(PERL_PATH))
@@ -2340,6 +2341,8 @@ install: all
 	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
 	$(INSTALL) -m 644 mergetools/* '$(DESTDIR_SQ)$(mergetools_instdir_SQ)'
+	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(sysconfdir_SQ)'
+	$(INSTALL) -m 644 gitconfig '$(DESTDIR_SQ)$(ETC_GITCONFIG_SQ)'
 ifndef NO_GETTEXT
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(localedir_SQ)'
 	(cd po/build/locale && $(TAR) cf - .) | \
diff --git a/gitconfig b/gitconfig
new file mode 100644
index 0000000..c45d300
--- /dev/null
+++ b/gitconfig
@@ -0,0 +1,5 @@
+[alias]
+	co =3D checkout
+	ci =3D commit
+	rb =3D rebase
+	st =3D status
--=20
1.8.4-fc

--
To unsubscribe from this list: send the line "unsubscribe git" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
You received this message because you are subscribed to the Google Groups "=
Git for human beings" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
