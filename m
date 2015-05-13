From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Wed, 13 May 2015 15:24:40 +0200
Message-ID: <CAP8UFD1eA8U8DnjY2qqCxR5HEtd3EzFJ0Ck8CNrWAh_25YyaXQ@mail.gmail.com>
References: <20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
	<xmqqfv73f420.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3LzM3uuUzWYS-o6mhtH-x5+-kyGhDvYnv6ZPRTC18C6w@mail.gmail.com>
	<xmqq7fsd201d.fsf@gitster.dls.corp.google.com>
	<CAP8UFD0k-=ESEu-7jhf8Y5wz+5A=MHsjtMnC7YJv_DRi30TmDw@mail.gmail.com>
	<CAGZ79kZG=9BkEGB_GOsg7F-2mN5iTjmTFK+vUohj_7wJLfPtig@mail.gmail.com>
	<20150512234014.GE31257@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Trevor Saunders <tbsaunde@tbsaunde.org>
X-From: git-owner@vger.kernel.org Wed May 13 15:25:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsWea-0000DH-N4
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 15:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934380AbbEMNYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 09:24:46 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35955 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130AbbEMNYm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 09:24:42 -0400
Received: by wizk4 with SMTP id k4so198571301wiz.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tdvacTcVKr8sJuCMfIeX6pySg2EbexuKb3yhJpDFZRo=;
        b=v0+I5nzLHQpOGIJSQ0lGLKD/NwDKS7Fq9pSw9F9YLQDGoqKOc3kaoGnCdeEv/zTsAE
         I0TJV9BE65gk1brQltFQkGG5S7zimAVJiVuAWZ6jDwbcu8NXr9uFNIoR1iUAyKeL42oO
         biFbn3sx93MqQc8l9k+MN2jMlVqd9HRqebkRqlzReWLD9gqZ80E6Ee3br2q+1VA9/TJ1
         67zFcH9cvtc7qGolZfkbe8MjicLWoDPV7TUv8upy/HKyb95Gqf6iawuMCKOfNBr+FzSD
         gEcWpvIj1P0BAhp2rPV7b9bCP008Fz7J+9btSAYmGiZgbQU9RYANwd3GTQ+hWOt+fgER
         z9vQ==
X-Received: by 10.194.133.71 with SMTP id pa7mr40799726wjb.155.1431523480179;
 Wed, 13 May 2015 06:24:40 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Wed, 13 May 2015 06:24:40 -0700 (PDT)
In-Reply-To: <20150512234014.GE31257@tsaunders-iceball.corp.tor1.mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268982>

On Wed, May 13, 2015 at 1:40 AM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
>
> my sense is that the division between git-bisect.sh and bisect--helper.c
> isn't really great and could already use refactoring so I suspect it'd
> be a fair amount of work.

About the division between git-bisect.sh and bisect--helper.c, yeah I
started converting git-bisect.sh into C code, but haven't finished
that.
