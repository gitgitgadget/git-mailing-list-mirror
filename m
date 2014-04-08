From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10 12/12] trailer: add blank line before the trailers if needed
Date: Tue, 8 Apr 2014 14:48:02 +0200
Message-ID: <CAP8UFD3sgUQk3dtpRaqkut0biQuV8AMPNQXCybg7p4cgrW-D0A@mail.gmail.com>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15100.chriscool@tuxfamily.org>
	<xmqqvbuklt0q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 14:48:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXVRn-0005BX-I7
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 14:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756864AbaDHMsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 08:48:08 -0400
Received: from mail-we0-f176.google.com ([74.125.82.176]:52740 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756677AbaDHMsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 08:48:04 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so878960wes.21
        for <git@vger.kernel.org>; Tue, 08 Apr 2014 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Y+t0pLmNJiiOnfel6KfxH6+MsGyHztCPoe7BhOktuik=;
        b=Vfr5j8dczJyfxT68UcNGzZZYZdSwd/uO1FZ+uVo8kRldtO89L8JaOk8umblN4tFoWd
         7infyL9+5P8BuOHW5Qbac7jp1m+tvx0rai4QPtzjcP62n97tJByfh0llO/pourQwYR41
         cEY7Lp15Kgg33OM47c2nmAlpdbAMwhKwOHXzEKoyjz03tGDAvV6Ptm/M8O5XCkX8mHSz
         gDyC7an2ZLQqErDkQMB60AbD4vhOOwdLtCmktwoLVKA44cNiaiI2cDrvOLqClcP/4TBW
         bZIBtbniicL1BskrU/m88PHf17PBaf5xAYv8se+U2P4nhWFohOePycrQYc1irzpjduvm
         eV3g==
X-Received: by 10.180.184.167 with SMTP id ev7mr31641725wic.55.1396961282920;
 Tue, 08 Apr 2014 05:48:02 -0700 (PDT)
Received: by 10.216.174.68 with HTTP; Tue, 8 Apr 2014 05:48:02 -0700 (PDT)
In-Reply-To: <xmqqvbuklt0q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245923>

On Mon, Apr 7, 2014 at 11:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Hmph, this is more fixing a mistake made earlier in the series at
> the end than adding a new feature or something.  Can you start from
> a version that does not have the mistake from the beginning?

Ok, I will squash this patch in other previous patches.

Thanks,
Christian.
