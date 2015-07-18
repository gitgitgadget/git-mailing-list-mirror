From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation/git: fix stale "MULTIPLE CHECKOUT MODE" reference
Date: Sat, 18 Jul 2015 13:56:43 -0700
Message-ID: <xmqqy4idyyk4.fsf@gitster.dls.corp.google.com>
References: <1437092222-11131-1-git-send-email-sunshine@sunshineco.com>
	<xmqqa8uu3edr.fsf@gitster.dls.corp.google.com>
	<CACsJy8B5d250xdofWkj0+TXaye=h2fDoyEobA7ktBtw-0sJTwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 23:00:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGZDO-0001qB-1K
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 23:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbbGRU4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 16:56:47 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34489 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbbGRU4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 16:56:46 -0400
Received: by pdbbh15 with SMTP id bh15so34626792pdb.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oWcIC6iEqiIiahFN7a4/RgIH9+0Gf4fu9zGUygczZYw=;
        b=EEKCoo1NgO0SMNujooNU4JKJ5WyMJtq/J8asNepQG4VPBhR8N4DXKapIkQkX5fcqAQ
         8+rKvKmYbQHKNtjzMS0ObeENH7xaI/x9IJltGkUvI3SLrcUZss19dgLuPLoQ+4CcwN4s
         SFIspo5xdXiOS5h16YWWsNxlNK4qdpIohgKvkYge5chKdO6L2NTulCgPQaFVRT+tL7tA
         YmsotXh5sIJ2GfPJsGbzIy27unfbAUuipmqymf1QcPDHROU4ugJOifSP3WMHrcN3/8ys
         /O57WOd6cOYVpYMuZW8YX6zgFDqCDWVm4rM3Sz9Bk7xEk12zQwChBgRp8RqDNIidR6JT
         bDOA==
X-Received: by 10.68.65.74 with SMTP id v10mr42951568pbs.9.1437253005257;
        Sat, 18 Jul 2015 13:56:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c060:7851:3fd2:bcfb])
        by smtp.gmail.com with ESMTPSA id f4sm15158714pdc.95.2015.07.18.13.56.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 18 Jul 2015 13:56:44 -0700 (PDT)
In-Reply-To: <CACsJy8B5d250xdofWkj0+TXaye=h2fDoyEobA7ktBtw-0sJTwA@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 18 Jul 2015 14:57:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274177>

Duy Nguyen <pclouds@gmail.com> writes:

> The flexibility here is not about extending this feature per se but
> maybe trying out an entirely different setup. Yes a bunch of safety
> nets are thrown out of the window if you try it. I guess I still had
> the 2005 mindset when I designed this. If there is no strong objection
> to $GIT_COMMON_DIR, I suggest we keep it until we sort out the
> submodule problem.

OK, let's revisit this after we finish futzing with the submodule part.
