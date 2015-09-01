From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] t6300: introduce test_date() helper
Date: Tue, 01 Sep 2015 15:19:19 -0700
Message-ID: <xmqqsi6xpyu0.fsf@gitster.mtv.corp.google.com>
References: <20150901083731.GE30659@serenity.lan>
	<cover.1441144343.git.john@keeping.me.uk>
	<8e869f362971a44bb1f40ca5fed98b658efaa0dd.1441144343.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:19:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWttk-00040k-Tz
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbIAWTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:19:21 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35564 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbIAWTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:19:21 -0400
Received: by pacfv12 with SMTP id fv12so9194892pac.2
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=j6oe86Nr9aO5i8fWh5XYgA9AwFCX8SGs1waudASr6Gk=;
        b=uj7c97RjmKV4DmTMXp1wgUCsLL9YufKVQXoE0iTU75Rjba8mqCd2RY80idGhiFyhui
         lD8NlO+jMsIfB6EUJnxrpdGgSiogQmjB55mXzBHNQyksyRkrcGEai1QGXQqynf1aYi9O
         +Af2tkviCu2gCry6l+6B8YO0cUR4EHbGJ9S19h2aXMykY1S5EZapJ1c3MNfKbDPpZnRp
         06oQ4+Ktj5t0k5uI2F9Zvztxlx5aWxBLSeilkE78YEqyAyYplVFLQEj9+IHv6ycxt21v
         6+DBTpqE+LPaTK9oeLEv1U98HjC5eujcDzpa7knOcxoUgj6a/ePbQSVIZ2bcccPx4cu3
         nkXQ==
X-Received: by 10.68.201.105 with SMTP id jz9mr50420336pbc.86.1441145960663;
        Tue, 01 Sep 2015 15:19:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id dh1sm19251522pbd.49.2015.09.01.15.19.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 15:19:20 -0700 (PDT)
In-Reply-To: <8e869f362971a44bb1f40ca5fed98b658efaa0dd.1441144343.git.john@keeping.me.uk>
	(John Keeping's message of "Tue, 1 Sep 2015 22:55:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277055>

Nicely done.
