From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 0/11] port tag.c to use ref-filter APIs
Date: Thu, 30 Jul 2015 21:19:57 +0530
Message-ID: <CAOLa=ZRTtGejUDfnG+9TLzqW1BumrRUHR1ydo74nw54VtW971Q@mail.gmail.com>
References: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 17:50:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKq6J-0004Oq-BN
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 17:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbbG3Pu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 11:50:27 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34371 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbG3Pu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 11:50:27 -0400
Received: by obre1 with SMTP id e1so33898361obr.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2015 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=BaxDLRYwJLuKONQJRrp+UestNeyvKpR13jb5C7qgJcY=;
        b=tTJ0tgBHFadEsn64qVweEoUB7LRn9Y9BIyzQSZW2+H5Gktwns82UiVd5PtTUj0q8O+
         iEU9k9mTVfAeVEVjAMtWVN79nv871u8kEtMddtwlAnVI7cq0jXj7wmRRxHVzqIX3MOzR
         33z2xzHrI/NmOmsgBw4HXGfoKtXSSDQdMte24hBi4rB6LOQhp0g+CoZtZ/V9oov17WZJ
         fPT4W6vYSUoqyoJIwddxpa6oaIoiWX9U8FInfTvXTHMs9Qc9rVhwfRLsstYeopNnwE9R
         gGliWOqkx33L8zI/Og0mzbnsQpI71OkOXXpQCerPCzvwMHDqGgx7n4drKCjKsbwictg3
         EJdw==
X-Received: by 10.60.62.105 with SMTP id x9mr45810551oer.1.1438271426569; Thu,
 30 Jul 2015 08:50:26 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Thu, 30 Jul 2015 08:49:57 -0700 (PDT)
In-Reply-To: <CAOLa=ZQG4Oz4aSGLNQxcRB4vNo3DQn_V96H-aCD=krSSoA9JGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275013>

Hello,

I send my v7 patch series as a reply to the v6 series by mistake, Have
sent it again as reply to [Patch v7 00/11]. Please ignore the v6
series.

Thanks.
