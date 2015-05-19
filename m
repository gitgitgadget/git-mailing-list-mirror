From: Stefan Beller <sbeller@google.com>
Subject: Re: test suite failure t5570, 8 with v2.4.1-168-g1ea28e1
Date: Tue, 19 May 2015 10:31:01 -0700
Message-ID: <CAGZ79kaNWDB2qg2-x-+2ccV1hC7Y0K8TQVPQNkjMotggwsRRzw@mail.gmail.com>
References: <CAGZ79kY61ZJHHG4jj2hZSzXZ58fh9R9b8hOijaCTGxTu8dtN=w@mail.gmail.com>
	<20150519172254.GA27174@peff.net>
	<CAGZ79kbV8noD6v8mdc7vM4cONV_cvuLLt_ay14YSoFjQ3v4N0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 19 19:31:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YulMD-0007MA-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 19:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbESRbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 13:31:04 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36817 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbbESRbB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 13:31:01 -0400
Received: by igbpi8 with SMTP id pi8so81697281igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5yWx4NPLjnyyFu1d8BSdqXSOJjd+w6ml3hlh5T2kL/I=;
        b=Hjn6bJHN186dcomskybGlC5awqv83gyCAODviDeLMzVmb3wk+ea4zk6U6Yw1kWKQzZ
         rMhpDYkzW5ozFomG1UkqMnUYvoeKI9ZE7zyk0ooBaKATi0aHSuyKom2nIY2c6Ni2+wlG
         yJhgBxyyxjhr6qrD2kk2jh87GazbhfRvL/zQKNzYI2a2o7T5yCV9OrjeHsiprgKi+cdu
         nhnZTqVMR0B59Q3N3hH7KiwruivrvbqGP4gG72sTQtQilt6eGevvzZgylOvLBnqh9+GJ
         yRWTo+LT6OKcOiKaM+8PgLuEWbjSvuDPunXaX/KvcEjXLCWoW8ViVxXQae0NfuMw/mPL
         yNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5yWx4NPLjnyyFu1d8BSdqXSOJjd+w6ml3hlh5T2kL/I=;
        b=L230FJqwTBv8X0Y9+/CGa5GO5ZLUlbiMRMxMl4lmhiP1uSYCIhpchHT00GPz+EnSCd
         K6gHBUMLFCPQbKqedT0P0uZEMJs8MSSFdyAA3zXM63t5uK9+wSXr5QXmkyzOOaH1KgcD
         zJbCJxGHheABH8NO5XKO95MguUDB+dhaeUku+QbA4iy/niSfEJKxpXmzhbm+MJ+ncp/4
         1Yq0OiqMxcRkpgI5xG9mXATyxM5tsaE8lMhG12hbZyVxBmhTE9HOl9b8bWcJtQzMVYwm
         avG1TAo3qoIF199sUiWJiaP7jyvOYHy/1ikkl8hu3To6J1Sm0mKhayVv/griBdx15WK4
         sZDQ==
X-Gm-Message-State: ALoCoQlFQH9aO6p/ARqrq2wD2v5HcX4gDyU3vM/AiZIoz6BH+oXuL/xsI5RF1DDLtG4j5wv1CQAh
X-Received: by 10.43.148.72 with SMTP id kf8mr6436768icc.76.1432056661077;
 Tue, 19 May 2015 10:31:01 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 19 May 2015 10:31:01 -0700 (PDT)
In-Reply-To: <CAGZ79kbV8noD6v8mdc7vM4cONV_cvuLLt_ay14YSoFjQ3v4N0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269378>

$ git bisect bad
383c3427afa3201eb05e931825c5c2f20616b58b is the first bad commit
commit 383c3427afa3201eb05e931825c5c2f20616b58b
Author: Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon May 4 03:25:14 2015 -0400

    t1007: add hash-object --literally tests

    git-hash-object learned a --literally option in 5ba9a93
    (hash-object: add --literally option, 2014-09-11). Check that
    --literally allows object creation with a bogus type, with two
    type strings whose length is reasonably short and very long.

    Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
