From: Armin Kunaschik <megabreit@googlemail.com>
Subject: [PATCH] t7800 readlink not found
Date: Tue, 31 May 2016 02:26:12 +0200
Message-ID: <574CDA24.1020906@googlemail.com>
References: <CALR6jEiJwx14zAyond9ggz29Q64Fz84URtjr8zaddjnrdY7TjA@mail.gmail.com>
 <vpqk2ijs8p2.fsf@anie.imag.fr> <xmqq1t4r75sv.fsf@gitster.mtv.corp.google.com>
 <CALR6jEj67MA7CCHQ_jfdtAuGoo9wjPie0+a=e-BqJjoYtJ9oHw@mail.gmail.com>
 <xmqqfut75peg.fsf@gitster.mtv.corp.google.com>
 <CALR6jEixZitA1CTE_kDkDEHv59ALT9zkCOgd28unMhLUZKt48Q@mail.gmail.com>
 <20160527041944.GA17438@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 02:26:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7XVo-00072n-09
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 02:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162145AbcEaA0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 20:26:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33323 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161860AbcEaA0P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 20:26:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id a136so27518563wme.0
        for <git@vger.kernel.org>; Mon, 30 May 2016 17:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=sBRuJDVbWFF5km0P+LqHauQiLaHGhBhVf5BOY/zCnlY=;
        b=U+SvNm/Dn0jw9kpmxoraMOoP0D9MJ2mVLBYADFOA342ZZf8xulm+r5xRlWT4tOjSvp
         Gj95Joyp+ukHcicy8x+4gg63BTEtBgcYXijADbNvx2BHjjBNDI7skpjhEaWYMt99plZL
         kxUuG61tomawkKrZhGXwSga+MvxueG91ttrMu3NAuMC9xiHZokmReTBX5BkgzcuCIarf
         m9h+RQKsnv3wuYiwQzjNmVwL8t/IrBhSBK4/2Hao/UnYXh6mkux4MwOg30uTsXKES0xO
         5Fbg1TgS5m6lHjwjxNteSi+pIAu5vT++4ePLR8pg7yeUdkZznTFZ5uh5A2Ga3PjhKeE3
         qJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sBRuJDVbWFF5km0P+LqHauQiLaHGhBhVf5BOY/zCnlY=;
        b=iuEQviFX3+8bjQpBEe7lVXwPU+HbbnkSENtV69Agx/HPjJ/ZTsEgfp9KwUsbNgggx9
         t6Uzy3Ix9KJ7F4m20nNNlfHaPJt4qIcvyq7/FZb/Xsej7eRXVXekuevtH7V8Q8wYlUqq
         EfQYbOKttf3eEWp/E97DNcuuhqqI1rz3d4sdQKEdOvKmZLDNM/R/vESm7o/2wI2buBLT
         oiScWoF7GgEU4wYkpJTbQbhhje69Rdz846NBSmviCcyTywKzlDZcaHRCzEWLdw5samcz
         ABydzo2k9PVHQBf2lIUKjqcplSKJy/Tcas2uq/wLt+Dv2vdRWP6U5CaEV70J3cHNoR3T
         hOKQ==
X-Gm-Message-State: ALyK8tLfH5Qavnl3aTHXylL1TbsMtMzp2RhrkCuwSsT8xVE+SKlZ4p7xrAQ0AOBJzzxmow==
X-Received: by 10.194.55.10 with SMTP id n10mr28829836wjp.28.1464654374247;
        Mon, 30 May 2016 17:26:14 -0700 (PDT)
Received: from ?IPv6:2001:4dd0:f840:0:225:22ff:fe02:19c9? ([2001:4dd0:f840:0:225:22ff:fe02:19c9])
        by smtp.gmail.com with ESMTPSA id q1sm17536140wjx.18.2016.05.30.17.26.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 May 2016 17:26:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <20160527041944.GA17438@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295943>

On 05/27/2016 06:19 AM, David Aguilar wrote:
> On Wed, May 25, 2016 at 11:33:33AM +0200, Armin Kunaschik wrote:
> 
> Would you mind submitting a patch so that we can support these
> tests when running on AIX/HP-UX?

I don't feel comfortable to submit patches for tests I can't verify. I
don't have valgrind and python/p4 here. Looking to the code I'd say,
patching the p4 tests with "ls -ld | sed" looks quite save.
But I'm not sure about the test-lib.sh. When you are really super
paranoid, as written in the comment, you should probably use perl like

perl -e 'print readlink $ARGV[0]' $name

as a replacement.

So, as suggested by Junio, here the readlink workaround for t7800 only.
(hopefully whitespace clean this time)

--- 8< --- 8< ---
From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t7800: readlink is not portable

The readlink(1) command is not available on all platforms (notably not
on AIX and HP-UX) and can be replaced in this test with the "workaround"

ls -ld <name> | sed -e 's/.* -> //'

This is no universal readlink replacement but works in the controlled
test environment good enough.

Signed-off-by: Armin Kunaschik <megabreit@googlemail.com>
---

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 7ce4cd7..905035c 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -446,7 +446,7 @@ write_script .git/CHECK_SYMLINKS <<\EOF
 for f in file file2 sub/sub
 do
 	echo "$f"
-	readlink "$2/$f"
+	ls -ld "$2/$f" | sed -e 's/.* -> //'
 done >actual
 EOF
