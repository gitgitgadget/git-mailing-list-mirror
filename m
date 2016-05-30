From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 2
Date: Mon, 30 May 2016 11:07:58 +0530
Message-ID: <20160530053758.28134-1-pranit.bauva@gmail.com>
References: <1463947103-28464-1-git-send-email-pranit.bauva@gmail.com>
Cc: larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@tuxfamily.org, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 07:43:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Fz3-0002xo-0u
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 07:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbcE3FnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 01:43:21 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36672 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932111AbcE3FnU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 01:43:20 -0400
Received: by mail-pa0-f68.google.com with SMTP id fg1so20289575pad.3
        for <git@vger.kernel.org>; Sun, 29 May 2016 22:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3wxywX+gGn9t4/6HXaFjMFeAH6uqG8+fmGcxpPegFE8=;
        b=fD1Ss5+QYxqqs4Ycp61spNgBelrt+PvHF1hyxTiWq6OZd1n6O8U+TXPHglEQyxpVeu
         py5iIzTi5y+Aja91JgNIMysNrnbLfDG0xh1UPCRVqtaHLCeiCw9nJRPLSwWQ4+jWrXOK
         GpVlMM0tnULRb7O6JBNrG9qCsbc8LlFUsvaXswhBczS8i/wzpeY7RfqLfKg1Ra/cXZ5h
         o3/YToNtZSqZyLm9CiNCpAwYiCF1GJsnOagcz9LWEY5lagbCAar7bbvhBZq68yuDe4uT
         uLtKB96I1DBIP0qlYVdWOlGX9KuP+KZa1bJvpRPLmeaoZemGOgCk1XQjMOwSgHippT16
         kB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3wxywX+gGn9t4/6HXaFjMFeAH6uqG8+fmGcxpPegFE8=;
        b=mqGrBmZZE0/pQ/DDWJo32A/rLnmTg9d5gqKdYos0HB3bk7z87UjDv13o6qibYiAw1n
         Dvr9eZyTVMGLnvp4fiCoUEQmvK/D0TD4NfY8M0HhK27se/P4NMBY9rnNSx38mzes70jE
         iFJqKMJEMh3AAImDLuZVvA9b8jb5rqdI2pigylSvdbQ1tZzgIDWqaQX/75uhIHzRf/wr
         2ve1u/2viSZ5call0ce9xdCWcV1Py67CPSGn4kLkXnM4nXPK5qV1s7lV4rn+SbhDD3X5
         ZUhhQmQAZszfmW2Thy6BiuDijkJwp0bE3LS+PNlVsk30i8K54jFiPYqD3a5TCglZ5OE5
         KbXg==
X-Gm-Message-State: ALyK8tI3IBFEpLRatLUlRq1oh/7SUjRfx3ECGMhE6ui850rzRTohQ/VDUvSH6EqinCfReA==
X-Received: by 10.66.21.102 with SMTP id u6mr43541330pae.118.1464586999339;
        Sun, 29 May 2016 22:43:19 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id tn7sm43990133pac.29.2016.05.29.22.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 29 May 2016 22:43:18 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <1463947103-28464-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295853>

================================= SUMMARY ==================================
My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


=============================== INTRODUCTION  ==============================
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


================================== Updates =================================
Things which were done in this week:

 * bisect_clean_state() function is having a segmentation fault which is yet
   not fixed by me. I will try this for one more day and then send it to the
   list for RFC.

 * I also converted is_expected_rev() and check_expected_revs() which also has
   segmentation fault.

 * I also converted bisect_head() function. I changed the semantics a little
   bit. Previously the shell function used to echo the string, now it returns
   the value to the caller.

 * I investigated why test no. 43 and 44 are failing with t6030 with `|| exit`
   in the previous version of the patch but it didn't in the newer one. This
   is because the location of .git was hardcoded and thus it created problems
   with bare repositories.

 * I also sent a cleanup patch for using the marco GIT_PATH_FUNC to create a
   function instead of using git_path() because of the benefits described
   in the commit message of that change.

================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * Finish bisect_clean_state() conversion.

 * Finish is_expected_rev() and check_expected_revs() conversion.

 * Convert the function bisect_write(). I plan to convert this function and
   add it as a subcommand.

 * Convert bisect_reset() and add it as a subcommand.

 * Convert get_terms() and add the variables TERM_GOOD and TERM_BAD in a struct
   in the global state.


Regards,
Pranit Bauva
