From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 04:47:45 +0530
Message-ID: <CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <7vvc7baahc.fsf@alter.siamese.dyndns.org> <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 01:18:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV8xU-0007vH-Jv
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 01:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758197Ab3DXXS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 19:18:26 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:58475 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757971Ab3DXXS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 19:18:26 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so2842240ieb.17
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=U1T3hv6x8hUyzGQHqzm1pZjTTu3KAJUmJ/UOZ3h4WmQ=;
        b=bJAo03GrtTMO73bQvjniRh3605S98HwM9jz3IroDVtG0x0U9wltExVAs/vzBg2+b6W
         ndh+arJfQKI7Vz+O16iRkSZpNnP6FHS0vFv6aujpzz7eKCS1Y3c3VARFthcRc851RsQF
         Mpe2fUvpAFSLDYCpv8r5qxEt0g1dMDo0UMhVzwr10lWcamKPxM3LUD219LIc/KgE3IzM
         dYIP9yWy+TdsIehT4OABMIVkYqKg5s89WvB+JwVVNJuJnzaVL5NIMWO81J38LpHsCdNZ
         i5jrDZuV+7zpfYwB/QGwDpsxV/No8e8S8d8aZcnxn5vYEllZ64xX4X7nX6LvDuyHGVXk
         GFjQ==
X-Received: by 10.50.57.116 with SMTP id h20mr818308igq.49.1366845505506; Wed,
 24 Apr 2013 16:18:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 16:17:45 -0700 (PDT)
In-Reply-To: <CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222337>

Ramkumar Ramachandra wrote:
> Ofcourse, I now see that this is probably useless, and .. fits my bill.

Would you find it potentially useful?  You do a lot of merging
back-and-fourth juggling feature branches, pu, next, master.

> When packaged with a good default for LHS (which .. currently doesn't
> have), it might be a slightly better candidate.  I was thinking origin
> instead of [nearest-fork-commit].

Er, I meant HEAD@{u}, not origin.  HEAD@{u}~HEAD doesn't sound like a
bad default at all.
