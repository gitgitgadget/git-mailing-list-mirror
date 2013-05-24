From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 24 May 2013 21:31:09 +0530
Message-ID: <CALkWK0kVYCsLg3R9H1OVr2R9k_cBQCghG+gTdrD8UKXEhgeYpg@mail.gmail.com>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
 <1368793403-4642-3-git-send-email-artagnon@gmail.com> <7vfvxlw055.fsf@alter.siamese.dyndns.org>
 <7vsj1jzao7.fsf@alter.siamese.dyndns.org> <CALkWK0n+NTnO0_4jNuR3Z5qmA_=-Dux+gq8kNzAT4YLC12Z8uQ@mail.gmail.com>
 <CABURp0qCOMJnQ=+p81eXLtj6+zujO=MsYODx8zR_cXjVXwV=HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:01:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfuRG-0003ZV-SS
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644Ab3EXQBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:01:51 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:48795 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab3EXQBu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:01:50 -0400
Received: by mail-ie0-f178.google.com with SMTP id f4so5471567iea.9
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=iBHEw+BG4vBa9F7UXspv4do884iAnZtj83EK9i6DY2s=;
        b=JAJTIXa7maZ3AsgcfDgylY9WtMqs7lFvMQXQmEVA71WNecTxLe0pTAEwAkd7BSjuWs
         D5erEeJGgFFhbDG7kO8qTr3egTrvLIHp3M+MzSEBJdRyfZKWWOrq37tEDeCrkUabao7R
         cNoH5YyEi6wQVDjXPo5X9jX8MbKNnz6TBXY1zo9jAPLl2K1hixgH/tU0BMzs4Uu3xDVN
         Sso/L+1AJ1lQOhrncxotqw4ppGApv0cdh3qhQz/aCrCinNVAJdupkMxk3mJVOcijOOZm
         IHOAY2DYn8U78712mY0PWKv2f7ID5gMSYDRXP/bu6P4OwaK7aYO7QL6PbZO7gR/OeQpV
         JWOA==
X-Received: by 10.42.47.77 with SMTP id n13mr12933820icf.12.1369411310211;
 Fri, 24 May 2013 09:01:50 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 24 May 2013 09:01:09 -0700 (PDT)
In-Reply-To: <CABURp0qCOMJnQ=+p81eXLtj6+zujO=MsYODx8zR_cXjVXwV=HA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225368>

Phil Hord wrote:
> It fits the beginning of the
> document where it says this:

Ah, I missed that.  Either way, I'm quite happy with v3: we can change
the first paragraph to use the word "transformation" if we really
want.
