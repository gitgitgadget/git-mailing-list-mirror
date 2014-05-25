From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] commit: support commit.verbose and --no-verbose
Date: Sun, 25 May 2014 15:44:16 +0700
Message-ID: <CACsJy8DHqFQU5qZCBUXh3VibpL7Rrq_V9i5ZeddKv+VfyrP86g@mail.gmail.com>
References: <20140525062427.GA94219@sirius.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	James P Howard II <jh@jameshoward.us>,
	Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>
To: Caleb Thompson <cjaysson@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 25 10:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoU34-00006M-Vg
	for gcvg-git-2@plane.gmane.org; Sun, 25 May 2014 10:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaEYIos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2014 04:44:48 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:62665 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaEYIor (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2014 04:44:47 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so10397803qgd.41
        for <git@vger.kernel.org>; Sun, 25 May 2014 01:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=stUaUqMF/rxOknVgXaECfaWi5qti6E4OUQfNSuW9HBE=;
        b=m5dcH/IlgJBrDxPOpMoo73dVNl9uxxLkOlFScSSoINF0hqVpZPBzwgDXe9bMoyMa6C
         4ZxPnj8E8disTVLqBIytx+XRt30wvVxpEJblbMZLOsKaHKSuRY2UDghQA8tLzPZ3VfwO
         zIF0/HHzU8GJmfSo2hMHteF7X9Ty/L90uCnoX7Dova9g7zFbipYHAetfiYG6boDnwIEz
         xGkDUt4HdurvQgKhWfXISKtBDuOJOwtiK6kkCRqimfUWRfrruSNZd/Ks+/Hh9q0/hMIA
         Bgs6DgJZegQqYvCXXa2J+bK0gKHmA073LYZ7+sTznbrnW37dieey1+nXNUWeT++wEy8i
         3lkA==
X-Received: by 10.140.107.137 with SMTP id h9mr20846039qgf.30.1401007486684;
 Sun, 25 May 2014 01:44:46 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sun, 25 May 2014 01:44:16 -0700 (PDT)
In-Reply-To: <20140525062427.GA94219@sirius.att.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250085>

On Sun, May 25, 2014 at 1:24 PM, Caleb Thompson <cjaysson@gmail.com> wrote:
> Duy, you were right about `-V`. Do you know of a simple way to add that
> shortened flag? `OPT_BOOL('v', "verbose", ...)` gives me `-v`, `--verbose`, and
> `--no-verbose`, but no `-V` as a shortened form of `--no-verbose`.

No, I don't think parse_options() allows something like that. And we
probably don't want -V for --no-verbose unless it's very often used.
-- 
Duy
