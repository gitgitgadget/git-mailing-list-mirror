From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH 1/2] completion: add option '--guides' to 'git help'
Date: Thu, 24 Mar 2016 19:27:13 +0100
Message-ID: <1458844034-12855-2-git-send-email-ralf.thielow@gmail.com>
References: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 19:27:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj9yg-0001wF-PI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbcCXS1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:27:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35262 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcCXS1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:27:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id s187so5229823wme.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4hX4qQbW2IuaRhdy2GTp1zntw5+VjE6YYIBQB99Czxg=;
        b=hWPAYej10/bir/41gkPOf1/I/lzGfiF1eP/bfdIzzveMcTq337ZFDXKOkahOCBCOEd
         Khkk1mtRIIsAmer9LYxZlGRvxOROjX85JpM1bB6E7zSwLXv0CqLZ8T0iTNzh3bvK8IJP
         pQ8J6yvRwP8n/MoNlf+o1IJYUC5sBYC2XWsSbPVURTYSHXsieiVqFWxsStVdAh075R9v
         fTBOvc5flmH/tiDDkccMTk7nHhz97XaIPUm8QF0utEWPTfqwKPqPrnZo7wrcqvCT/oo6
         SfAxwSSwWgzyTzT8ERELmKtRxSjMSsheOcQnApS13gaKkaaS7hg+w6Os0CZ1Ns7MINkG
         csGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4hX4qQbW2IuaRhdy2GTp1zntw5+VjE6YYIBQB99Czxg=;
        b=Kws3mSyW+BknwLHsQhwTnjuJtfwqSsPa8viw64JD8mPY7tPRfea1y2O/plKNI7Vdaq
         zfJasi0Z3iFI/U7oBBzohEeGZuQobNWwq4v34G6r7UV64V9Z9aZ11JZ5x/0bwLytL+xj
         w71eUTdWZQ8L/tlnDLvf7sO5e3PwadtogUfg/rRg3cHvgORKTINogozgDQVT6UZHCcLl
         5eKTomS95BM6dUVsJUsTx/pbbG9oJEFeca9Cwz8eiVwtMrxnv1ekKzv/2EeUaslZMTTf
         d/G99yJmU8UKjmE1KT3Hd6+6Fi/1FrgOjWro/IJYQ3oRYJAnbstrfO1lLPvtprQ1NKjD
         Uisw==
X-Gm-Message-State: AD7BkJJKv6XOuFXPPnuWFQmXloUSK8tOUu+0T+IbWGtJJfoWI0cCBtKJaQ/oqTOcweZtAg==
X-Received: by 10.194.58.234 with SMTP id u10mr11474015wjq.174.1458844039717;
        Thu, 24 Mar 2016 11:27:19 -0700 (PDT)
Received: from localhost (cable-82-119-18-125.cust.telecolumbus.net. [82.119.18.125])
        by smtp.gmail.com with ESMTPSA id 198sm8899682wml.22.2016.03.24.11.27.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 11:27:19 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.7.g35d7ca9.dirty
In-Reply-To: <1458844034-12855-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289780>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3918c8..70f4171 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1339,7 +1339,7 @@ _git_help ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp "--all --info --man --web"
+		__gitcomp "--all --guides --info --man --web"
 		return
 		;;
 	esac
-- 
2.8.0.rc4.7.g35d7ca9.dirty
