From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 02:40:56 +0530
Message-ID: <CALkWK0k9prS2AgqOHwkh71v9uS2varVKrU_FCx1KgnGEMdqfjw@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org> <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
 <7v38ufer2x.fsf@alter.siamese.dyndns.org> <CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
 <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
 <877gjrpsk4.fsf@hexa.v.cablecom.net> <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
 <20130424210227.GL29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 23:11:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6yd-0001og-Ll
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 23:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab3DXVLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 17:11:39 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:58306 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757858Ab3DXVLi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 17:11:38 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so2090078iay.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=l6dMR8lX4i47FUUp+XooUsRGBkd0dkpiMUfxGJr5WDM=;
        b=kDlXfZS/krCLHOYMMvDxWEsTLOed9RVpNd+HT7r+87bpxr+Ys5GqaHIgPFJtqumEXO
         SPvA26oV37uTr/JE2StRmgc0gkUFS4ftC+DZtQLgBpp8y/OS+kJvkKAN0JW7MBwVwMWr
         LO3ShNvf8M97O7fOIdbiLYwHsSceiEIlesZoe9AFGiJOBSc4bVIPrRnVANoslTY3Uy83
         sdJxaIYat/gV9jNOEtG/nhJVkg8RYvfrmmgD45ZsbIDb2wM17ubtqar4FHkky+PRo/DZ
         Z5aQnqdmTxZA+PvqWRNXwmorPYW+/5/wTIEuyZFoou5pw6UbPQJgnUrvX8lyT96v3Vz/
         6EbA==
X-Received: by 10.50.55.73 with SMTP id q9mr23608560igp.44.1366837897676; Wed,
 24 Apr 2013 14:11:37 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 14:10:56 -0700 (PDT)
In-Reply-To: <20130424210227.GL29963@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222324>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> Isn't it obviously incredibly useful?  I'm working on a topic branch I
>> need to send out to git.git, and I want see how my WIP looks: should I
>> have to rebase on master just to see this?
>
> Nope.  I just do "git log master..topic".

Why do you restate something so obvious?  Yes Jonathan, this is
currently what I do:
https://github.com/artagnon/dotfiles/blob/master/.gitconfig#L43

I'm proposing an asymmetric difference, which is B ^$(git merge-base A
B).  What does it have to do with A..B (aka. B ^A)?
