From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/6] Fix path bugs in submodule commands executed from
 sub dir
Date: Tue, 29 Mar 2016 15:29:11 -0700
Message-ID: <CAGZ79kYivg3VvS6zavzjhP3wu3oaTYdEGWPYKvHrrs77yF8big@mail.gmail.com>
References: <1459290228-9069-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 00:29:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al28T-0004BB-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758022AbcC2W3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:29:13 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:33890 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbcC2W3M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:29:12 -0400
Received: by mail-io0-f180.google.com with SMTP id e3so43958635ioa.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=L+yhrRZj8oFSlARkQ+aBlXD/C6y+jqEkUl4nGeTYQw8=;
        b=DlMCfbpKBb8FtHgKx8D3FvmrMX3mUdFPvujIBP+AroGkq8QggAkTrwMb0wH7vPfPFv
         tvtFvSMvWENuTEmlfOBjyaYiLffwjH6qHfh9BMJ8/xw3LgumIEBfF37TTnNGwnRM3DXq
         10FXjKLLKlt+V+spdZr1u+XPxX9p2t2sH46eajLkac98IqM/kvKvoRsPaUNTgvKaxUTd
         6EVJErR/tNKpT0kdz2cJKRxkMOQDMuzjvRqHRi/zExKDAczPHNMILDJ1eu8bs6W9B2IH
         QT4w7JOUUjSjMzP/76k7/NXr2r3BER07MfIg2mnOaKGRRBTkIYxVGCOkEnNveULIsptv
         5WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=L+yhrRZj8oFSlARkQ+aBlXD/C6y+jqEkUl4nGeTYQw8=;
        b=ZPK1UeBxP89z63xJu/jZy0NArDhU/HIsKdjEqSYRcu497P7D4a3Yx34f9M27Ri4Dep
         vBK6O61VmPFREZexROMGUW/7wyYMhlzEOS8pn0ptoa4npiTzNFQJrxqvm9KW73kbiWKG
         Rkjaf3AG5QR1/p3Pc48PK8cnqXD19QcCWCuMFU5zGcsJJCpEI6el7xlkRlQA0/46xEnW
         9UBsXqhacqvMuGzjLgoA/P467NxQQusbkUgPRPoNUnDvHhrkH97GFf7GgG9B4cpiFtzZ
         CEUYSLdwaNuycvF+bvNl9viw+8AWDvHcabrvjDK7M+1Z5ctqOdBugBo76dKroYRPuigV
         0ejw==
X-Gm-Message-State: AD7BkJKg82RUGCTCw2qVE1mU+ll/lJSsffmsh0aXvzJVK7r+T+GbfrFAJSUPEwM33SDKLg87J5cRh0tS/SIJwHIm
X-Received: by 10.107.184.8 with SMTP id i8mr5553879iof.96.1459290551805; Tue,
 29 Mar 2016 15:29:11 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 29 Mar 2016 15:29:11 -0700 (PDT)
In-Reply-To: <1459290228-9069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290211>

Please ignore this series; it was sent out prematurely. :(
