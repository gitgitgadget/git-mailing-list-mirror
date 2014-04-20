From: Delcypher <delcypher@gmail.com>
Subject: Re: [PATCH] git-remote-hg : Enable use of, $GIT_DIR/hg/origin/clone/.hg/hgrc
Date: Sun, 20 Apr 2014 20:57:12 +0100
Message-ID: <CANNJ_zhpoRRTL1j8XKahrsqEgKfvFck-+aJ20X1OyAg73gGiqQ@mail.gmail.com>
References: <53076DFC.1000602@gmail.com>
	<53499bb02c140_285f9032ec58@nysa.notmuch>
	<CANNJ_zjVaymTUmSSFHfSpmcH7H2v62nsHaUoxRfi098zqLi_Ow@mail.gmail.com>
	<53540df5ad0fb_18fb153d2ec8b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 21:57:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbxra-0007m6-If
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 21:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbaDTT5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 15:57:15 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:57699 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbaDTT5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 15:57:13 -0400
Received: by mail-ve0-f172.google.com with SMTP id jx11so6536080veb.17
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AtGqwEu0POHbtdK05lMrS7kXm7icWKqLsqqSgokPSNo=;
        b=KVYVBEUATVC18NGDQrKtD+WhtHCghlaP0pJLhML+seRPZ5ub0uVHlSq1zJ15U7dwvO
         PYfO5zoibmzmXCKLsPC6lM9McY2lHIHJAyXxrHgg3i8w/Ngi883Sz6n1GVdk0A5M3TvZ
         iTg68LtYiE3Fw8g/m6Yq3Z38LC6ZPDKtkvIjmoOVrd0kRQ6CLKZxNI4HM3DJ6p9NER8N
         sPiErccmwOCsM5z3xa66+mG8N7ccO//PmWzND7Hyep5EuRH4lWbrQh9BcLbZtLjKcz+D
         7/8Nb/yPzhsj/nFGik2MgG/TtiuYiczHggHrTsjYrqIcHu3j3SizDddeRHkVqUeT9NNT
         mE8w==
X-Received: by 10.58.187.78 with SMTP id fq14mr29700351vec.9.1398023832981;
 Sun, 20 Apr 2014 12:57:12 -0700 (PDT)
Received: by 10.220.88.70 with HTTP; Sun, 20 Apr 2014 12:57:12 -0700 (PDT)
In-Reply-To: <53540df5ad0fb_18fb153d2ec8b@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246577>

> What version of Mercurial are you using?

$ hg --version

Mercurial Distributed SCM (version 2.9.2)
(see http://mercurial.selenic.com for more information)

Copyright (C) 2005-2014 Matt Mackall and others
This is free software; see the source for copying conditions. There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
