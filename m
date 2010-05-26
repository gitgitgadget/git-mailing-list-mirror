From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Wed, 26 May 2010 13:01:50 -0300
Message-ID: <AANLkTincuWkXqFybDwq2Mh9MI1eC2JjjGwLy17iEP9u5@mail.gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com> 
	<1274488119-6989-4-git-send-email-erick.mattos@gmail.com> 
	<7vzkznqmir.fsf@alter.siamese.dyndns.org> <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com> 
	<AANLkTikKAkwHYj6OvfEJM1YE8w2TZL2oeMBrj28V3CwX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed May 26 18:02:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHJ3i-0002VG-KS
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 18:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755239Ab0EZQCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 12:02:12 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48973 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab0EZQCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 12:02:11 -0400
Received: by gyg13 with SMTP id 13so3020862gyg.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 09:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=qG+GiwULxAJPerK7VGDBW56Nm3qZjpigO5MzXIcc7YM=;
        b=Wqsb9N3CKRydsBCnF1spuZichQnF+WvrSEhSef4+895RSGfVtwWw7CuYRDOKyHjdFU
         uW5j80msfHay2o5vk5nQJU7NTscOs53sKLXl127P9yfE3N8/y5IU365LZaaLGyYUO3JI
         5ZB3FiX3r/rSbrJsXDKqdq8RKM1J+6dzEnO94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TxVQ3IcZXbSqQZqvgQqPuquDix71aCtp2EUT7ZJvKjF2z0ZAUaErdEgf1ngxMeDpm8
         9KJHVwbYgvgCQ64acXvtQxOjvXYYMs7aS4MbO5GIMI765SCfr0eCELoA+yYdqYd5H/4e
         /K5NXjtkLrKnikziUIpNxcv4sd24RVq5S9DaA=
Received: by 10.150.188.10 with SMTP id l10mr9523883ybf.296.1274889730101; 
	Wed, 26 May 2010 09:02:10 -0700 (PDT)
Received: by 10.151.39.17 with HTTP; Wed, 26 May 2010 09:01:50 -0700 (PDT)
In-Reply-To: <AANLkTikKAkwHYj6OvfEJM1YE8w2TZL2oeMBrj28V3CwX@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147808>

Hi,

2010/5/26 Erik Faye-Lund <kusmabite@googlemail.com>:
> I don't think it makes sense to try and be polite when we're actually
> refusing... "should not" implies that it possible but not recommended.
> And in this case it's impossible, because we die()...

Right then!  As I told it was not a fix.  So let's 's/should not/cannot/' then.

Regards
