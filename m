From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Some git mv questions
Date: Tue, 16 Oct 2007 18:05:28 +0200
Message-ID: <8c5c35580710160905v69787856m7ed11b037c1adef1@mail.gmail.com>
References: <200710161733.49185.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Jan Wielemaker" <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhovM-0003MU-4O
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXJPQFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbXJPQFa
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:05:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:9859 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbXJPQF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:05:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2432930wah
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=njt2Nnl5+QTrnFkfCr6wJWa9D0d08g5gEyLepLDUl94=;
        b=lfQ7zfo+iAdp1CAGtnbQYZa2pyDwiOqL9AQZT0ortDMqiwZn4A4RwlYUlaeD5EvFJwx/L9QOrVUeFxrlQkYxRA0uR4g2DWoqRYBPCut+Qr+KCa7/On/hbONAqhxHmRc+gETL1jihmTSHgd/YACQatV+aVtGKzHDv7VeCkKo7Tmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aop14ZOFSzk7GJzQCCW0pUlf0tKHk43AOMe8h3JALg/sBH8nCC9AToshjOZheCpXkIpW/OW0H/87msL8LW7IJuqyMUxqRG+96NoKpgQ31F0IHhEDzn3Mfmjczn3T8c5Owi+cBIIX1WG7lV1o2yJSnBdW3c+STJ1M7GtX2EhvN24=
Received: by 10.114.109.1 with SMTP id h1mr8632486wac.1192550728710;
        Tue, 16 Oct 2007 09:05:28 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 16 Oct 2007 09:05:28 -0700 (PDT)
In-Reply-To: <200710161733.49185.wielemak@science.uva.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61203>

On 10/16/07, Jan Wielemaker <wielemak@science.uva.nl> wrote:
>         * On a somewhat bigger test I moved a large directory using
>         "git mv dir newdir" (where newdir is an existing directory).
>         Now "git status" gives a lot of new and deleted files!?

You could try to adjust diff.renameLimit in .git/config

--
larsh
