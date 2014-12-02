From: Derek Moore <derek.p.moore@gmail.com>
Subject: Re: RCS Keywords in Git done right
Date: Tue, 2 Dec 2014 11:36:08 -0600
Message-ID: <CAMsgyKasQ=DZ77e6HJW6u03g9RHsJedG_SQDW0X=-V_9bAYA0w@mail.gmail.com>
References: <CAMsgyKbTRY5=cHj8Ar8zHDd5WdbcNwZC5caGV-snvZU4aek=YQ@mail.gmail.com>
	<CAGZ79kZz4_q+p91e7fn8uS--DRqEUPj_eeQPf2WPOWEk=R8fkw@mail.gmail.com>
	<CAMsgyKZywnac_b2RV0dGs9zOdemJDUQ8oR=bSydBuSxp1VDixQ@mail.gmail.com>
	<CAGZ79kZLAHDG8h5DMQdOH2cQtaMs_iCtC-xsoKst966a+jaBNA@mail.gmail.com>
	<CAMsgyKZWr-1isLvRXMFdzOYu0Yfm3vN_bdk4oRg6UhzSOMq_yQ@mail.gmail.com>
	<CAMsgyKbd8Eq07LUktaVy7zyFQwOJ3KOrkJCipp6P9F1_W=OYCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:36:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrN8-0003zV-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbaLBRgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:36:12 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:60306 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbaLBRgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:36:09 -0500
Received: by mail-oi0-f45.google.com with SMTP id a141so9416260oig.4
        for <git@vger.kernel.org>; Tue, 02 Dec 2014 09:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UrmD/Fc5DpoPpUNnEyh0fNkigwt5XdIpZASlFWxDKbI=;
        b=XwQ95XwbfVCABO/rrItHgB8TwWJ/8eKti8Eb1hcUt4wzC9m0ZuTGQwXNF5lgxsXKpr
         +WVbgFVr7UN6PjPZA3YocUs8DghvdOrdgz5zPrBmzeekCry72yQqdwlPnjaQz2pZKcLF
         uiOnb4ebejIiBS6Wibx7fY32ti+1RdtbTnyysj0B2he9Wk/qdqiJdUuUgRWjMxm/Bqp4
         mZiqmPLQK892hsTTJnP4xxe4T+EOXa0Vi3XSOuSMxPQMRfvctso4J+UydXlMoJ8FGXbU
         OH9ql72x8WkE0NSwJg8+Y4i4uFWAOlxqWEA2i7lH2Cf0IRsIE8QuMJIw72fJCg1UERVv
         qjVw==
X-Received: by 10.60.68.108 with SMTP id v12mr252896oet.69.1417541768700; Tue,
 02 Dec 2014 09:36:08 -0800 (PST)
Received: by 10.76.33.68 with HTTP; Tue, 2 Dec 2014 09:36:08 -0800 (PST)
In-Reply-To: <CAMsgyKbd8Eq07LUktaVy7zyFQwOJ3KOrkJCipp6P9F1_W=OYCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260584>

PPS: Sounds like I need Peff's git-blame-tree from here:
https://github.com/peff/git/compare/jk/faster-blame-tree
