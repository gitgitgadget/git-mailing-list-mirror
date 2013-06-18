From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] sequencer: write useful reflog message for fast-forward
Date: Wed, 19 Jun 2013 00:32:56 +0530
Message-ID: <CALkWK0kU01zfvyietjuTFk01UteT+uuKXfjrfSirn=i8FHCxCw@mail.gmail.com>
References: <1371580518-32455-1-git-send-email-artagnon@gmail.com> <7vzjun45dr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 21:03:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up1Bt-0003jE-OS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 21:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700Ab3FRTDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 15:03:37 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:48537 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab3FRTDg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 15:03:36 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so11168867ieb.30
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ifioc7bq9yK+0Q91W/aIxtw2wV9h03ovz2+1GvyeHVU=;
        b=MjwDunGqpF7N+fjqGXweRLwS2IaNOG7GpcgEt3RAwizFtxxB3KMHbp3zvveqC4iYpV
         PGY7w57z5bd7SCmA1SDoemrD+zebcpra7cVcwBZfH13TrUEXfRK2VBQzA/T/hzFHPpPD
         w6FGh6hdInMM6p5DWQrcrysvGDZdlJ6/Y5cC27tytTqei/Ky0wtYlM3HvDGB1YU9bT1e
         0I/z904G27GJJ+F6n+p+skfldC/TPtjIJ178Usw/JQ0NE+brjIahte4E8ESGZ6C/gbQK
         zXfjv+KbRnOtSGInX5coEoFWk+RD9FV6o5SkRuiY05/VjJBgjXxCJcSTnc9oy9DkSsbH
         gF0g==
X-Received: by 10.50.154.106 with SMTP id vn10mr8215110igb.0.1371582216566;
 Tue, 18 Jun 2013 12:03:36 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Tue, 18 Jun 2013 12:02:56 -0700 (PDT)
In-Reply-To: <7vzjun45dr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228304>

Junio C Hamano wrote:
>         strbuf_addf(&sb, "%s: fast-forward", action_name(opts))

Agreed.  Can you just fix it up locally?

Thanks.
