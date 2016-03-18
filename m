From: Elena Petrashen <elena.petrashen@gmail.com>
Subject: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Fri, 18 Mar 2016 15:47:11 +0300
Message-ID: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elena Petrashen <elena.petrashen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 13:47:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agtoK-0003q3-V7
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 13:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098AbcCRMrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 08:47:19 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34905 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638AbcCRMrS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 08:47:18 -0400
Received: by mail-lf0-f46.google.com with SMTP id v130so37115400lfd.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OOSpIYwkL2ENRXZU3YaBPmovImN6XIDs9VPGeURO5MA=;
        b=ajWmMmv8y9FtIqFQigexoEJkZVZ2Dx5bwj62+/dOFk1ZmeKrhfxFP7i3ZBGuxOGOg2
         mwFnyn843J1ELLLKFb/T1ojIrnLIQ2zhrQThKjFFX3GY6dzeZzs9BioHYJWXofMDi4Zr
         A03TBoSuWhz/GLdhHLvHSC92Ljgiu4H912UFekSeU4UofOHLV2eMO1/XHfWw3G2hofje
         ipQ0snncRjPlKwZvuu1DrQwjDbfWRzw9iZzPmqAiunoez0U9feF43YubQNGjXJovlfPM
         fzSAb9pMlLgSoKah5vkByImZi7+DRaRIm5KgRmo3y+FFvUjLxF6dCN6JfvBKmyYFrmO0
         ZZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OOSpIYwkL2ENRXZU3YaBPmovImN6XIDs9VPGeURO5MA=;
        b=cb14Ih/BkXDTS+G/4NAHFWqv9qK5rkkKx0kknQLMrWcfZ55CaramSzHKdNw4WD7Rzk
         36qKqYDB+ZQ1gwKcxRLuD/Nm+O7W8ONGHszcGnMvIfEiir59C+8J1Z/VYXlwtTrkVpWo
         FNJBbQShOPQkKPCdgMHv0IFDOt4MzU970MN/N1ijtDPIZwmIseLvgLOwkE0egRo0MHFl
         MAq1Yjc01J5gQ4hsj+jSQaUaNwgdzwymSbEG1bZd63DhQpYmzfWdzrRIU+QDeSIWwEel
         cAYgPaViTfV2BZntHgA8FuDpUW8OWycxkiWOPaXP53Hok3DLI01uw7f6ac2Ca6zCoMnJ
         m1Eg==
X-Gm-Message-State: AD7BkJI3JJGQJernQkynvrbpRhqMAtFvHk3k2svpV1LuY/jIfJvLqPnYh9Le9YqgAcCj5A==
X-Received: by 10.25.168.67 with SMTP id r64mr4729892lfe.104.1458305236443;
        Fri, 18 Mar 2016 05:47:16 -0700 (PDT)
Received: from localhost.localdomain ([37.153.43.108])
        by smtp.gmail.com with ESMTPSA id td7sm2141790lbb.6.2016.03.18.05.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Mar 2016 05:47:15 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289218>

Signed-off-by: Elena Petrashen <elena.petrashen@gmail.com>
---

Hi everyone,

As my first Outreachy submission micropoject I=E2=80=99ve chosen to try=
 to approach  =E2=80=9CAllow =E2=80=9C-=E2=80=9C as a short-hand for =E2=
=80=9C@{-1}=E2=80=9D in more places.=E2=80=9D (http://git.github.io/SoC=
-2016-Microprojects/ (Cf. $gmane/230828))
My goal was to teach git branch to accept - shortcut and interpret it a=
s =E2=80=9Cprevious working branch=E2=80=9D, i.e $git branch -D -
Really looking forward to hear what do you think, so please let me know=
 if something is done incorrectly, etc.
Thank you,
Elena

 builtin/branch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..9d0f8a7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -675,6 +675,13 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
=20
+	int i;
+	for (i =3D 0; i < argc; i++) {
+		if (!strcmp(argv[i], "-")) {
+			argv[i] =3D "@{-1}";
+		}
+	}
+
 	if (!delete && !rename && !edit_description && !new_upstream && !unse=
t_upstream && argc =3D=3D 0)
 		list =3D 1;
=20
--=20
1.9.1
