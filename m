From: Andrey Novoseltsev <novoselt@gmail.com>
Subject: meld output check is broken
Date: Tue, 14 Oct 2014 18:58:36 -0600
Message-ID: <CAD0_dC4Kv_Dyqm3TW8LsETcVowYV1mKf16qFGToCUouaJ97fLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 15 02:59:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCve-0006g0-HT
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594AbaJOA67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:58:59 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:65472 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbaJOA66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:58:58 -0400
Received: by mail-la0-f45.google.com with SMTP id q1so164712lam.32
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=TvOPV0igOHhV42saaq5A0B+YjwHmgPiEA6d5RcY5m2U=;
        b=LZzsLSm84YEIdmjGy6NsLsf1cnOnXT10aVHZH/eUhQl50+I4naPnO7Y4wkVr/EZvqU
         QLazryplL7StNXTEfplqrGvMv1RhP+Vj1Ma3siYtVOj5FqPFGDPtrIEWhHXvzMTJvgkh
         xSLt+3HmJsh2yMMOJthAlQrbaDfeblwtgbPgEQD5khYU6OPIQSQ0mgdKHWX905W9WJnL
         O64BcuTOrnL2WE8FprtFQiEMh4G264fHEP94xzJ8otVl4K95u7RrxrZUexct0J9avFlX
         +J4ddWybtb+jrYVWEBd6GeGMNbmi6JMi0W6TZjmLGO11UY3rElNLb5zPmXOeLdJC+SSj
         QmtQ==
X-Received: by 10.153.5.33 with SMTP id cj1mr8999725lad.36.1413334736993; Tue,
 14 Oct 2014 17:58:56 -0700 (PDT)
Received: by 10.25.126.211 with HTTP; Tue, 14 Oct 2014 17:58:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

It seems that support of "--output" by meld is performed by grepping
its help output. However with meld 3.12 I get

$ meld --help
Usage:
  meld [OPTION...]

Help Options:
  -h, --help                 Show help options
  --help-all                 Show all help options
  --help-gtk                 Show GTK+ Options
  --help-gapplication        Show GApplication options

Application Options:
  --display=DISPLAY          X display to use

Yet it still supports --output and can show nice middle instead of
<<<<<< HEAD etc. markers.

Thank you,
Andrey
