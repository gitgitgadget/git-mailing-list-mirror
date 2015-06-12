From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Fri, 12 Jun 2015 11:04:37 -0700
Message-ID: <xmqqpp50dcqy.fsf@gitster.dls.corp.google.com>
References: <5579B253.4020804@gmail.com>
	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>
	<1434039003-10928-3-git-send-email-karthik.188@gmail.com>
	<xmqqy4joddul.fsf@gitster.dls.corp.google.com>
	<557B1B60.9020002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:04:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3TJs-00005V-OV
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 20:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbbFLSEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 14:04:41 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36455 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbbFLSEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 14:04:39 -0400
Received: by igbpi8 with SMTP id pi8so16865551igb.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 11:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1oKGHp97q9OZiJ/GXFhy7r3eRdJ7Zquk3R1cfItmYxs=;
        b=qbYQKkn4/3wzgRcX8xBnv/XspD4XKkd/ab/F87FK86BzUT4t5ZhLvG5Yu6oC2xYHXu
         f5pSiUxbiaAHtET2Sm0W5OqThZ9tTecxcYnN3ewrFEqEU7TBMaOXSyVUKRd+0friPL/k
         O/Cl4MvKIRO11DNnXyLd49Zqv0zh6iU8+nfZNr+azgJ0d7Eg8bKRu/GDt3XgAzdSZC9p
         TT+wPYBf7+sMIgXpV97ienHxbDoQ0481T8sqVcs5ik1O0FV2uDoDXZQPYngxV0gWlcBo
         L1qgNOr71ytxczNSSG06KKQxlwm1nqwc/hioWQyDsmmUvy6omZ4eGCwnbY+kJkoYK7V9
         JCsA==
X-Received: by 10.43.1.193 with SMTP id nr1mr17866248icb.67.1434132278975;
        Fri, 12 Jun 2015 11:04:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id b73sm2555928iob.25.2015.06.12.11.04.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 11:04:38 -0700 (PDT)
In-Reply-To: <557B1B60.9020002@gmail.com> (Karthik Nayak's message of "Fri, 12
	Jun 2015 23:18:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271507>

Karthik Nayak <karthik.188@gmail.com> writes:

>> What change since 9f613dd do you have in mind, exactly, though?
>
> Well initially the atoms were indexed into used_atom array, which
> later was removed. Hence the comment becomes obsolete.

Later in which commit?  In builtin/for-each-ref.c in the version
after applying patches 1-3 of this series on top of master, I still
see used_atom[] array there, so...?
