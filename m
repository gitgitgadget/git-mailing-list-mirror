From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 0/2] git-p4: Small updates to test cases
Date: Fri, 27 Mar 2015 01:54:00 +0000
Message-ID: <CAOpHH-WZXFodc3UAhdwJ6Rj1LiS-Duq2MEoN4iEtadNCT9mq5A@mail.gmail.com>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com> <xmqqwq23w7qx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 02:56:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbJVE-0003fJ-WB
	for gcvg-git-2@plane.gmane.org; Fri, 27 Mar 2015 02:56:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbbC0Byd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 21:54:33 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33251 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292AbbC0Byd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2015 21:54:33 -0400
Received: by lbcmq2 with SMTP id mq2so53967776lbc.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2015 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cAesKiVOLog2fVK0SyN5QxnS3fjt0WzYN+YtE1rHXMA=;
        b=DnoEwdfPGyAdcNxPlYQorMKefRyzZ8/bWjmqG4rXgyaXO3n6eMUDoC88IbsfRCR3a+
         nL2VwXXX+FBnow/T9DBrmKuuyWmM3fFRHiruVq2PASjKIZxS5uvQrChmeKA/nazfjyZ4
         3kYgmYXWJc+hugTyWnnCJ1UOb9WFg8+t04K8b5EHdkw4D/zFDeN4n7fwK5pWvYWfqfqI
         NSnl6T0K5zRlBHufpBhyrb6PpK9prQB5KnbrwHPNAxc6yPga+uEzez4/vVwOrNgSWqmr
         elXTs1PfFy78GnfNk7Avwu01uDP0Ib0ZAqu8DiLdgIN6E/ugv8/6f1DnXHfKevPz33ZZ
         vOrA==
X-Received: by 10.152.6.136 with SMTP id b8mr15552156laa.93.1427421271111;
 Thu, 26 Mar 2015 18:54:31 -0700 (PDT)
Received: by 10.112.5.68 with HTTP; Thu, 26 Mar 2015 18:54:00 -0700 (PDT)
In-Reply-To: <xmqqwq23w7qx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266363>

On Fri, 27 Mar 2015 at 01:26 Junio C Hamano <gitster@pobox.com> wrote:

>As to 1/2 the lack of esac is clearly a bug---any self respecting
>POSIX shell should have executed it without complaining. But
>changing from ':' to true should not be necessary---after all, the
>colon is a more traditional way to spell true to Bourne shells, and
>we use it in many places already. Can you try reverting all the
>"colon to true" bits, keeping only the "add missing esac" part, and
>run your tests again?

I confirm that it still works with ':' instead of true; could swear I tested
that at the time... Anyway, I'll re-submit this patch with this fixed
tomorrow.

Thanks for taking the time to review the patch.

One more thing: was there any change in way diff-tree detects copies?
