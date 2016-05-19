From: Junio C Hamano <gitster@pobox.com>
Subject: Re: since/after not working properly
Date: Thu, 19 May 2016 10:27:17 -0700
Message-ID: <CAPc5daXPWiY8=NtOcsjMcVN2MiwaaQUbVY6GBn2Eu31Q0fZrUQ@mail.gmail.com>
References: <573DDEBF.7000903@here.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff Hawk <jeff.hawk@here.com>
X-From: git-owner@vger.kernel.org Thu May 19 19:29:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Rja-0004Kh-EQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 19:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbcESR1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2016 13:27:37 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34431 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbcESR1h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 13:27:37 -0400
Received: by mail-yw0-f173.google.com with SMTP id j74so85213713ywg.1
        for <git@vger.kernel.org>; Thu, 19 May 2016 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UTZv/7sceBuSKJhjnZMZSsPArGHJ2p1EUVQU5RSnM28=;
        b=E1j1zGGAs+XgpjW+uD4YmV2R7f8f9aAu6Hm9ZZJVjYNS00QQajaU1PiC9/bQfmbug6
         8viol8SGHipzOHJX1n2f4McwJgJ0Xqx42uwxoAJoohQevEliYkP85X8jxeawR90alq0f
         zD6CaY5+zIa0QeePFlIr3lJn52u01uUwcVH5NzFAa1/7mx5TPHXy/pLem53+O0aiFDxm
         q2dUCqAhMQGI6r35UkBahhWJoKajRSyzNXgcG8ocXtDx7dEPsjQjfxBaS6ohBmYut/Wd
         plnhjQokX4g1Vv8WbErCEdkTQF/DZdzc4O/bbPiAwp79an7RrEn6sA88HADl3VsULiU4
         Vc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UTZv/7sceBuSKJhjnZMZSsPArGHJ2p1EUVQU5RSnM28=;
        b=RRVXIvyHuAoXMfa7eFrMCKgW0YE9+GLOZJRcg2GtE4qAyICU7KFzXb8gItVcvf8bkP
         7/wKZgLEWzTGM6vJld7sMgqlkjlZ3p69T7IFvHbgPLK9MjA/yX1Ze10L87SF3/EaTAfd
         C4nPCU8+CY5ugvcRuA5ozGH4Rr1H8zablTIMJydxSWvdUWdgQZ+d4zdZhaPbWLILbYei
         wPRe1esrk5oQRiyRYhAmCu3fOAg7v+NUJoGxjSQfC0jrmKBaJvAbOWldFqv5BcWWV1rg
         xcKvJB626QXGGGZwBufuTbabqzyOb4RfqpTHoQcPFfe6T9qbBzepfjrRQv4m7WxACqox
         UvEA==
X-Gm-Message-State: AOPr4FWdBBLm1bjFyIIqg0o9pROLj2UKJLrZwht9KSNsiZB5ZU0j4did0bQgE6i4CVXtQduU8xU4PrtOILd7Dw==
X-Received: by 10.129.75.83 with SMTP id y80mr8782517ywa.61.1463678856433;
 Thu, 19 May 2016 10:27:36 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Thu, 19 May 2016 10:27:17 -0700 (PDT)
In-Reply-To: <573DDEBF.7000903@here.com>
X-Google-Sender-Auth: zGcEUXktAnZqBvyou0bDbDGXYRs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295078>

On Thu, May 19, 2016 at 8:41 AM, Jeff Hawk <jeff.hawk@here.com> wrote:
> [jeff:~/src/git] master* 2s =C2=B1 git log --pretty=3Dformat:"%ad" --=
date=3Dshort

Perhaps try it with %cd instead of %ad?
