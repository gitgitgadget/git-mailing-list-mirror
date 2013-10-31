From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Thu, 31 Oct 2013 12:41:31 -0600
Message-ID: <CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
	<xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxBZ-000173-AQ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755380Ab3JaSld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:41:33 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:53420 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621Ab3JaSlc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:41:32 -0400
Received: by mail-lb0-f170.google.com with SMTP id u14so2759134lbd.29
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 11:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4fDHtYK5iOsl3sQqruduYN+1otwR//k/d/67Emo1U+0=;
        b=nuHFNdtyYTi73fE2wdhTJzsMZymiDTFWvUzvxlpBmJMN3hyECyjPMlY1O+F2DqPfaU
         hhSD0u2bGYI32srXxBx+5wlI1DwdnSd27bglHJC/qRdYC2KoGfifBWeOSTcG8LA6c0C9
         y8Wol0/r+80Da6LOHZAwbfawUjU47ARWvNPWieqAhQnYn3EMHvZ4j/VjVVc2gRaTbQ/7
         Q6UA3N9hUxmHJtmlnvSKpp2rF3kFBygPvi5edMZZtjL9DSaeHF+YompQeZGBplSPlI8i
         VWZWrbg7FMhG5qCX92OEd85qsEDG5LR2pG/JCOKZaxvcT7OO7CSk9mbqUbZdkoK+8ZW9
         5H9w==
X-Received: by 10.152.3.226 with SMTP id f2mr147485laf.62.1383244891258; Thu,
 31 Oct 2013 11:41:31 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 11:41:31 -0700 (PDT)
In-Reply-To: <xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237153>

On Thu, Oct 31, 2013 at 12:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +test_expect_success 'use refspec' '
>> +     git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
>> +             grep "^commit " | sort | uniq > actual &&
>
> It feels somewhat redundant that you have to twice say that you are
> pushing your "master", once with --refspec and then the branch
> name.  Is this the best we can do?

As this has been discussed before and no other solution came forward, yes.

-- 
Felipe Contreras
