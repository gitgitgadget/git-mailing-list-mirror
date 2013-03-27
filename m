From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Wed, 27 Mar 2013 11:49:29 +0530
Message-ID: <CAMK1S_jZcoA9sy+ixXmy8uj2E9E4Q6W2pLQVFStZMgH9eRoo6g@mail.gmail.com>
References: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
	<20130324192350.GA20688@sigill.intra.peff.net>
	<CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
	<20130325145644.GA16576@sigill.intra.peff.net>
	<CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
	<20130325155600.GA18216@sigill.intra.peff.net>
	<CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
	<20130325200752.GB3902@sigill.intra.peff.net>
	<CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
	<20130326165553.GA7282@sigill.intra.peff.net>
	<1364340037755-7580771.post@n2.nabble.com>
	<7vr4j1qzao.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rich Fromm <richard_fromm@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 07:20:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKjiJ-0001ok-GZ
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 07:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab3C0GTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 02:19:31 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:60975 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab3C0GTa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 02:19:30 -0400
Received: by mail-we0-f171.google.com with SMTP id d46so5221946wer.16
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 23:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=usee8mYrIPNiTGevuVkHf6GOT3eHOO7zEmSt9v5abIQ=;
        b=cfYaoC56uE7TyuSrRei/5xWXj6UVStyUod/v76+yUTuyOHeUdH2MvVtEEdpXOZoUux
         PAIQHfm5XpaMqo/2jawKHlkftGByJEdVD2czOHY3GPCClfe3Fvnn8++5FDt/s6TIxlPQ
         KaK2rb6FbJ+ip1jdZJ0otgOo2lCq9AVFHC18xLYBoz4rUZLkepuwvkbv7ARByH813dyX
         sV5bNpHxSuKCQTZznYVgxExTZFJq6njsYMeaA2qy+QzQ/B5+Ov8qJ96sJmLK9/ePcNez
         TnZhFnq1Z5s0BdoCMfva4ikPYgOlEJdBf3VzwnPk7mofpSnPS8gEpLfei4bLR/obri+K
         0Wbw==
X-Received: by 10.194.77.110 with SMTP id r14mr29340565wjw.2.1364365169549;
 Tue, 26 Mar 2013 23:19:29 -0700 (PDT)
Received: by 10.194.153.161 with HTTP; Tue, 26 Mar 2013 23:19:29 -0700 (PDT)
In-Reply-To: <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219241>

On Wed, Mar 27, 2013 at 9:17 AM, Junio C Hamano <gitster@pobox.com> wrote:

> To be paranoid, you may want to set transfer.fsckObjects to true,
> perhaps in your ~/.gitconfig.

do we have any numbers on the overhead of this?

Even a "guesstimate" will do...
