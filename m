From: Stefan Beller <sbeller@google.com>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Mon, 1 Dec 2014 10:53:24 -0800
Message-ID: <CAGZ79kaLaWK57m9_1aFOkSubECUvFcEvGjid8EuUmYNUO5Z5jw@mail.gmail.com>
References: <547C8610.8080301@cs.uni-saarland.de>
	<547C9088.7000800@cs.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Christoph Mallon <mallon@cs.uni-saarland.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 19:53:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvW6E-0005zF-7J
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 19:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbaLASx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 13:53:26 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:48130 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbaLASxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 13:53:25 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so4956875ier.20
        for <git@vger.kernel.org>; Mon, 01 Dec 2014 10:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G39zGqEw9SvKyAHWvSpGDAyirTw/IYLcXKwLWBy6F3A=;
        b=Li8cSrNBtNtOC98MD5HEABRnGCw0NGelXT5GE/y8PF0qZ69XvrQ6mu81OR6aFSuQV8
         ozzp8Bdos6EqET9kRu9wOwngncGfIMpraA3yJus6oHD1FLOq+I9fqjUGn20f9PqG7tTV
         dFz1C611oOByx19TbQavIJ5zl8BjKXa2fouS2Wrt2zu1F2Va6d+bSfYbcM8V0vgx5c7s
         ejexGbf44NWSeloqN3swTdHGUTPVt2r0Z7qUGLnmVcY51RDPxLglf6NRqvm0yhEOfmqo
         YZcLd8+paFVb/xSkkGPPQAujyF3qw156KbgepVlnERGOptnEx/cCIs6N+U30kgSHe0pA
         Ts4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=G39zGqEw9SvKyAHWvSpGDAyirTw/IYLcXKwLWBy6F3A=;
        b=grD9OJZZ9qZ7MMY3J8Wz2vpNGgQv6BJQvhKpinNnyNDyiRhiVzTpZ4jH3ZVpQbYYtF
         uz9Rk8uPpDw4Q/eSAAS/HTRAGIZhiSKKqbUW4q7CoorxSqgP3Smd2EWaZQG2PI2tOGdK
         cirlQUqKmS77UVrrrk0IPEbZQh36QhSF/dk5JI3HL6V2ueG7YCH9MUZPYwgmGAfwNCD2
         wLT9j8DyCGpwMGtPHbHlOfOjT+eKJbqjfMNNDCn+3uIH/WuRn/fxW2/GxmeBnPRCYI6q
         N1Y80MfIo+qvEI4tyktEnf+VwG4w5qPAh+oVT2sMmKjGSyImK6aj8y0KOv/4PJsfgebi
         Xc3g==
X-Gm-Message-State: ALoCoQkaeKDRAWnF7GuymuqJISNMwhQMmWr+mOI5MaXO8YuR/pOsv431kFmJkVDcaib16zgFKYJt
X-Received: by 10.43.82.72 with SMTP id ab8mr34924056icc.76.1417460004416;
 Mon, 01 Dec 2014 10:53:24 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Mon, 1 Dec 2014 10:53:24 -0800 (PST)
In-Reply-To: <547C9088.7000800@cs.uni-saarland.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260504>

So I am running a 3.13.0-40-generic x86_64 linux (so its's amd64) and
git version 2.1.2
and I cannot reproduce the bug you are describing. :(

$ git rev-parse 'master@{52}'
0000000000000000000000000000000000000035

What I noticed though is there are 2 linefeeds at the end of each
line, is that intended or did it break during transmission?

Stefan
