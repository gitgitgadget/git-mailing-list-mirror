From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Allow cloning an empty repository
Date: Sun, 25 Jan 2009 01:55:28 +0100
Message-ID: <bd6139dc0901241655n66f75a8fn8450b774809fa8e7@mail.gmail.com>
References: <1232669252-21881-1-git-send-email-srabbelier@gmail.com>
	 <7vwscm4xx0.fsf@gitster.siamese.dyndns.org>
	 <bd6139dc0901221746h258f548etf857ab37399133da@mail.gmail.com>
	 <alpine.DEB.1.00.0901230333060.3586@pacific.mpi-cbg.de>
	 <20090123230520.GL21473@genesis.frugalware.org>
	 <alpine.DEB.1.00.0901240131570.3586@pacific.mpi-cbg.de>
	 <bd6139dc0901231642v6bd593d3mfefaca3c419a9f0a@mail.gmail.com>
	 <20090125004955.GY21473@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 01:56:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQtJ1-0005ZF-Ba
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 01:56:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045AbZAYAza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 19:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753858AbZAYAza
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 19:55:30 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:30045 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853AbZAYAz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 19:55:29 -0500
Received: by yw-out-2324.google.com with SMTP id 9so2390303ywe.1
        for <git@vger.kernel.org>; Sat, 24 Jan 2009 16:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=cMqPr20wYbyb5B+GK7OCDE8CZHqSuAmuxxY0RCp97Xc=;
        b=tZuoeab6UravwZlVrVEE6UNCaKEi+8HKzoS0f/xmqNpoU452w7uPLtyifnndn8iA0I
         Oi8XNoVy+1kge1Bv7L/9Gn3F96TL8yIcjZfssaiD0IncTepXmgQQzwDU2isUhZLhoCYN
         GKfOlaTe6ECU7mbop2EqSwoIMOroYwnm0T8SA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=UmuXxUaAHxFP90wtcl/J1b+CBybjRD3ndIa5opGuGijWZQ6kI2/T11UqoD9h4gZpz3
         uRncoYnU/X9LUVuQfueXP4ERFhBtSkuOgZVhlOxt4ZBKi+4cT1TZzbuA6dVkHO4IDqYU
         JWXdqGa4/46xwYb2niEvH5aLZTe0VSMBys8Ho=
Received: by 10.151.113.11 with SMTP id q11mr74585ybm.135.1232844928683; Sat, 
	24 Jan 2009 16:55:28 -0800 (PST)
In-Reply-To: <20090125004955.GY21473@genesis.frugalware.org>
X-Google-Sender-Auth: 273d45c3be80d36a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107032>

Heya,

On Sun, Jan 25, 2009 at 01:49, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sat, Jan 24, 2009 at 01:42:30AM +0100, Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> Which means all protocols actually die?
>
> I think so.

Junio, are your concerns address now, since Miklos confirmed that
transport_get_remote_refs always dies?

-- 
Cheers,

Sverre Rabbelier
