From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: [PATCH] parse-remote: replace unnecessary sed invocation
Date: Wed, 30 Mar 2011 20:31:08 +0200
Message-ID: <AANLkTikBD4T3hdyT2h=2dzw-QO1BnBp3eT=WGj5s5dC3@mail.gmail.com>
References: <1301474920-6718-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 20:31:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q50Aq-0007Gv-Tl
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab1C3SbK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 14:31:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55837 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab1C3SbI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 14:31:08 -0400
Received: by gyd10 with SMTP id 10so637401gyd.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xtx4k+6xlgC8B/IP2i4oprPC/gh+FdyMEj0IeaI/M7I=;
        b=RjsAcRkxLeQoxl9ustWesIXLzbF0rAAKoXp0k1y1rbG/cYYFNseSRrVjyj5qdlm80F
         iQc1Jut+StXXKBn/QFPciXcTZ/LkpJoZsms/gMBymTfvMcFa+2Mypq/7TG7j2zb3OQ6g
         ZullAJx73wSuhGquqphH9bnAjSQsKLNiG8qf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=UQu+urVnclSBOvT23ILn//1VDkAPn+V3WjyMg2RhvvHtwSTjNJoC+JqRqBvkWVxNz4
         tZpwclPdPmF4r0xeXhiCsAC3fqrqfB4vfq10Eif0XqEjIgJ2pvkyBxFhCFHGpOWaswJa
         eytgUoB8NKplGlStR5mBBjeY62enRwKV0zh1A=
Received: by 10.236.200.137 with SMTP id z9mr2332486yhn.100.1301509868155;
 Wed, 30 Mar 2011 11:31:08 -0700 (PDT)
Received: by 10.147.33.7 with HTTP; Wed, 30 Mar 2011 11:31:08 -0700 (PDT)
In-Reply-To: <1301474920-6718-1-git-send-email-bebarino@gmail.com>
X-Google-Sender-Auth: Z1WoPKxSq-wxo_fiGkycyAUQ_E8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170399>

> + =C2=A0 =C2=A0 =C2=A0 curr_branch=3D$(git symbolic-ref -q HEAD)
> + =C2=A0 =C2=A0 =C2=A0 curr_branch=3D"${cur_branch#refs/heads/}"
                                           ^^^



--=20
ms
