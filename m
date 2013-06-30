From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/4] completion: add completer for status
Date: Sun, 30 Jun 2013 16:54:38 +0530
Message-ID: <CALkWK0nSM+36SNv7JG6ECK7NcH7WACuu9HNvGiaDe0OrMuvkiQ@mail.gmail.com>
References: <1372429088-385-1-git-send-email-artagnon@gmail.com>
 <1372429088-385-3-git-send-email-artagnon@gmail.com> <20130630111923.GC2294@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jun 30 13:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFky-0000xh-C5
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147Ab3F3LZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 07:25:20 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33360 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3F3LZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jun 2013 07:25:19 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so7492380ied.28
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9wkYQ2Ss/GaCrpWy/v7hWyQebjIr9mKRo4rt+eM8loE=;
        b=VcofOi4I1xqLCPgymrUbwqkuOcqOwmmRK+BaI3xdumUC4/VXXfuTy0V+++iLf4BMDV
         vSCgOHTJa0zhkdvbcEPH6p+I8zKS69KsAFcLgMu7n+cGa7sO8ss6zSgJKpffFKmAzeDq
         R4WQ6SNLqxFObOGJEFSm4vUdnlirp9WOAyyQmkHLmYTWe8lz+vv19h4WWIsYdW78+et9
         SfY0Nha3KSq+vXwMEvFVff4gvGCAawfwhYn61TvUVHb7/53+pvwvhLftEfyU3NqyCkBG
         W4+9UiBPHW/G8w6LawacCR9cRuNdXXXIG6friOhtbr26L2XMsPxgLgdXFkhSV57MBWFJ
         FhQA==
X-Received: by 10.50.66.130 with SMTP id f2mr10879170igt.55.1372591518873;
 Sun, 30 Jun 2013 04:25:18 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sun, 30 Jun 2013 04:24:38 -0700 (PDT)
In-Reply-To: <20130630111923.GC2294@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229275>

SZEDER G=C3=A1bor wrote:
> The code is OK, the rest of the function is pretty straightforward,
> but I think this line would warrant a sentence in the log message,

Okay.

  Complete untracked pathspecs (--others), and overlay HEAD tree on
index (--with-tree=3DHEAD) to complete pathspecs that have been removed
from the filesystem + staged in the index.
