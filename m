From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] Add support for url aliases in config files
Date: Wed, 20 Feb 2008 20:26:07 -0500
Message-ID: <76718490802201726t677b1498ma3bdb3dbf25dd781@mail.gmail.com>
References: <200802202203.m1KM37aR012221@mi1.bluebottle.com>
	 <alpine.LSU.1.00.0802202221130.17164@racer.site>
	 <7v4pc316gq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?=" <nanako3@bluebottle.com>,
	git@vger.kernel.org, "Daniel Barkalow" <barkalow@iabervon.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 02:26:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS0D4-000679-6U
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 02:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933682AbYBUB0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 20:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759083AbYBUB0K
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 20:26:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:50174 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940AbYBUB0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 20:26:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4261707wah.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 17:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CulGQYJeERr2d19jq/RxnhUfvHGv//zhV+3X3+8oFMg=;
        b=nzYhhkYcrMBWCQPpaUHYQ/KsgBMOox4Nuo1xgyC7O0yZ2WEJEIW8zUALIanrEtt+e/ftoTnvxMhmqxEh28XISZYUkeDKwTs9BF4N+Mk8o6qXeM13V15aQX8mVSok1goCQDEgCkd5Gw6RxwnComGVnkzxPFnlVXft7ZpShW5VpaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QbHKJObUTUoKy1kg5pxIR6QSediYcz0azFeMwm7gM6Urw8/mitDsVsHX61klAVC+HcBlBtW6u6FdM7fw0OhUZcy0LyhJksK6t/xGeG8h3SWSReYAVXsFBtG8FnUg2qyB+jOMOwlhT2Jq/vxICNAz0jr1gwTMX2FOIRVk4awrmi8=
Received: by 10.114.137.2 with SMTP id k2mr49645wad.104.1203557167099;
        Wed, 20 Feb 2008 17:26:07 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Wed, 20 Feb 2008 17:26:07 -0800 (PST)
In-Reply-To: <7v4pc316gq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74583>

On Wed, Feb 20, 2008 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>  In either case, I think a good approach to take is to find a
>  wording that conveys the notion "I will use A to mean what some
>  other people might call B or C" unambiguously.

[url A]
  other_people_call_it = B
  other_people_call_it = C

[local_url A]
  external_url = B
  external_url = C
j.
