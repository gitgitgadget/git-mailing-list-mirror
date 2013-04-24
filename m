From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Thu, 25 Apr 2013 02:25:35 +0530
Message-ID: <CALkWK0nhtoY+FWWybqLvtOHmDMSFLbM_4sozqeYf7tS5yY_XdQ@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com> <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com> <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
 <20130424191453.GG29963@google.com> <CALkWK0=KWu3=j5sLK3hr=Gx5xLnLaPAY+E=J0_izRCj9YcBTEg@mail.gmail.com>
 <20130424203732.GJ29963@google.com> <CALkWK0=-Bu-x=zg2f-uY7qUkwCp_8AdDAVv6=k0oyV4xYvBuWQ@mail.gmail.com>
 <20130424205046.GK29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6jn-0002Ph-0q
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758115Ab3DXU4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:56:18 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36665 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757880Ab3DXU4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:56:16 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so2686078iee.20
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hDK+ClFhGgK1yZBdw1qL3T/BbiUsQpWO6KlPj0Nf/GA=;
        b=EWiuOjuvn4det5vXGd5hSQpQ5Xy0lsNiU2HFlTNVHW6tQVLkYS6pUlafy0GNDZUC44
         rU2TcmJ45Azg12io9PUNv7mqZ/dKqmfHbtRCakHsC0KekQSGX/VG1axDgjz0mWfqRoNC
         AKvrpDxuey3Y1qshuuEw7g9rITlXwV6Wu78U95R/hokiGFXWJ2dtH6Jjl/u2fz/PcWXr
         Pd3Ox4ZPIce8wt55k0sw6U5kGd96Bq7NtJcR59ySNQqf5MNeqbXMaylwzM1JIQ137p4G
         V5AEWmNl7oCvNsBY5HqdsWqU8gfljYOlgDaV1HS5dJpzv2EslFeccn+J+T9lmxDLzz6y
         cbSA==
X-Received: by 10.50.66.197 with SMTP id h5mr6303047igt.63.1366836976057; Wed,
 24 Apr 2013 13:56:16 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 13:55:35 -0700 (PDT)
In-Reply-To: <20130424205046.GK29963@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222322>

Jonathan Nieder wrote:
> What would that configuration variable even mean?  "Set this to make
> other people's scripts work when they assume --no-index won't be
> triggered automatically"?

No.  "Set this for interactive use".
