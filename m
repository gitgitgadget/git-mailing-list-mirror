From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 05/13] ref-filter: implement an `align` atom
Date: Sun, 16 Aug 2015 17:16:38 +0530
Message-ID: <CAOLa=ZS1gQuKYqYGjXx3M_XLFsc5uAxYcD6c-d-WJG7S_spYag@mail.gmail.com>
References: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <Karthik.188@gmail.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 16 13:47:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQwPF-0004sc-I7
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 13:47:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbbHPLrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 07:47:11 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33409 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbHPLrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 07:47:11 -0400
Received: by obbhe7 with SMTP id he7so92416630obb.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=s+TV+hS/6KQNkM/JyqXYyqJxlul/KJfq9/WrM5Y7YM4=;
        b=o/onXuzcOwJTxDB4VaFxxY9fWrddJDLec9syeDG8YqtfK4NYqoQIqNHmh4pfFhd2vt
         7xz+kFF/nJ07GkC8BlFYNdBVSeMNuCoBubc+ZOisC3ufFa2BZWSRNzsukNSNcqGyIetV
         UGC2/h8YU7OFkwv5RPhpjPUbiFV1ioImVnuxiUXTv+BpFTku4FFqgFD/czs2z5UkY+BS
         0bhMTQhBzEV6+t5rV5hoOMVKQ8pIqiRMN0V4z4BNzIYYp+vLugf16js3DzbOco8Anqvh
         eEUJrUoh/XUMQ5tsnqTfI+8LUaGnKpdc5Vz+lLlasDwKss+OM9BgXig2GIMhO7ZMvI5T
         c4eQ==
X-Received: by 10.182.153.161 with SMTP id vh1mr46537571obb.34.1439725630047;
 Sun, 16 Aug 2015 04:47:10 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 16 Aug 2015 04:46:38 -0700 (PDT)
In-Reply-To: <1439661643-16094-6-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276017>

I think we need to squash this in

diff --git a/Documentation/git-for-each-ref.txt
b/Documentation/git-for-each-ref.txt
index 3099631..17bd15e 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -129,7 +129,7 @@ color::

 align::
        left-, middle-, or right-align the content between %(align:..)
-       and %(end). Followed by `:<position>,<width>`, where the
+       and %(end). Followed by `:<width>>,<position>`, where the
        `<position>` is either left, right or middle and `<width>` is
        the total length of the content with alignment. If the
        contents length is more than the width then no alignment is
