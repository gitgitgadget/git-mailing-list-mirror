From: Yohei Endo <yoheie@gmail.com>
Subject: Re: Wrong gitignore precedence?
Date: Thu, 23 Apr 2015 21:11:52 +0900
Message-ID: <20150423211152.0fdcbd2cdb48c98d15fe446c@gmail.com>
References: <20150422150558.6326cb6152a306f028fb6ad3@gmail.com>
	<xmqqh9s8dm6f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 14:12:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlFzM-0008HH-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 14:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965538AbbDWMMB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2015 08:12:01 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33470 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965241AbbDWML5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2015 08:11:57 -0400
Received: by pdbnk13 with SMTP id nk13so16958674pdb.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=e9H9WAaivmtG5GTzeZ0HKykX7fwZd8nQhw5jCH6izxI=;
        b=D7SsnvrRO7Zm56POCm3U5B/cY66ZGfr1m3kWy2E2nxqeuomsR8fqq+0hdRD8ICQW8/
         Bj3/ymJvBoYoo1lqm8ChPV/JwhheD83UYsCQfC8v2gUppNpByRNGJLmy9+5hp/oMiAVP
         2sFQqZTfLK+NLushZpL5z3nSXXoc3QWoe4/FvC52HuUcivcq3LR8ckc5aCUxWW1bf02o
         vaCamnOlCkyk+WiEbWXNt+FNrjw2T6Fz80t6Yc9KMaxoYIk8cmKag2ui8qsVvEIVN1SA
         qi52npGDlNjAGIFLNtldbkZMKFU15qg8EhOkcUWLISQLDoa8kodhRdQMA3kcXlVvOZrk
         rQQA==
X-Received: by 10.68.176.3 with SMTP id ce3mr4715004pbc.122.1429791116819;
        Thu, 23 Apr 2015 05:11:56 -0700 (PDT)
Received: from UPLT060 (europa.ul-net.co.jp. [114.179.20.132])
        by mx.google.com with ESMTPSA id pa1sm7987528pdb.73.2015.04.23.05.11.54
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 Apr 2015 05:11:56 -0700 (PDT)
In-Reply-To: <xmqqh9s8dm6f.fsf@gitster.dls.corp.google.com>
X-Mailer: Sylpheed 3.4.2 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267682>

On Wed, 22 Apr 2015 11:59:04 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Swapping the order in the code this late in the game after 8 years
> may affect people who have come to rely on the current behaviour and
> never read the doc, which is somewhat worrying, though.

I agree. I think the change should be well announced before
the fix is applied, like when the implicit value of
push.default was changed.

Thanks.
--=20
  =E9=81=A0=E8=97=A4 =E9=99=BD=E5=B9=B3 (Yohei Endo)
    yoheie@gmail.com
