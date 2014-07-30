From: Christoph Bonitz <ml.christophbonitz@gmail.com>
Subject: Re: [PATCH] git p4 test: fix failure in 9814-git-p4-rename.sh Was:
 Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Wed, 30 Jul 2014 09:07:55 +0200
Message-ID: <CABUJjW-tk3u3VjL8SFkN=W_Ynhfhvp0ETq=KtYTBsGA--wPLMQ@mail.gmail.com>
References: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
	<53D1543F.50508@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 09:08:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCNzW-00023p-7T
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 09:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755247AbaG3HH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 03:07:57 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:49129 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbaG3HH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 03:07:56 -0400
Received: by mail-vc0-f172.google.com with SMTP id im17so1161792vcb.3
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P1P9U7TWXNNeINMmnjpEV7wtLJ9rQ2TpTK3r4lwrdqk=;
        b=T3cuo7LPB6f5MdVDoqmtvSaHSvgYe26RfQ+Q1+SVDBwUwN0ZO1NctXf+X49XC1qux5
         BxXTMdcjkd5wVQxo5+STYtvM7Pci0870iZyuaW3f8ar17zDQNOk9F5vsOhI4BQInDa0+
         g0Tpcd6zCiZg7YX+1+ygwTlyBb8A9XTF6s4NhatfUmEf2ZsFrpixKIO1KTfBDxZgy52g
         sWyE5Ee3OWteCTehRPQHd3/3NAfUUyIKZD8TkgCuiAx/dA/w1qRQUfwjv7hGt4D97NoZ
         5kaUuCjnXo/YLxwkdxJyFlYlt6WC9TEGc7e88GRChA05HEvQkaB8X7+Rr9kayo/LzC/T
         nwcg==
X-Received: by 10.52.82.166 with SMTP id j6mr9685vdy.87.1406704075845; Wed, 30
 Jul 2014 00:07:55 -0700 (PDT)
Received: by 10.220.80.132 with HTTP; Wed, 30 Jul 2014 00:07:55 -0700 (PDT)
In-Reply-To: <53D1543F.50508@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254478>

On Thu, Jul 24, 2014 at 8:45 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 23.07.2014 23:28, schrieb Christoph Bonitz:
>> - test "$src" = file10 || test "$src" = file11 &&
>> + test "$src" = file2 || test "$src" = file10 || test "$src" = file11 &&
>
> You can't test for alternatives in this way. It's already wrong in the
> original line, which is from 795fcb0e (avoid "test <cond> -a/-o <cond>"),
> and breaks the && chain.

Thank you, I'm sorry I missed that!
