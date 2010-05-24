From: Giuseppe Scrivano <gscrivano@gnu.org>
Subject: Re: [RFC][PATCH] Print the usage string on stdout instead of stderr.
Date: Mon, 24 May 2010 22:51:32 +0200
Message-ID: <87pr0lja5n.fsf@gnu.org>
References: <878w7ieu4p.fsf@thor.thematica.it>
	<4BF12C96.9030802@drmicha.warpmail.net> <87vdamu2es.fsf@thor.thematica.it>
	<4BF14508.8040307@drmicha.warpmail.net> <87d3wutt34.fsf@thor.thematica.it>
	<4BF2614E.50003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 24 22:51:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGecV-0002RJ-Sx
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 22:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756194Ab0EXUv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 16:51:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:13783 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab0EXUv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 16:51:26 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2012000fga.1
        for <git@vger.kernel.org>; Mon, 24 May 2010 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:references:date:in-reply-to:message-id:user-agent
         :mime-version:content-type;
        bh=qfBE3DQw5MsNevxURuWeHAzfaT76zIiwNEGoAAYWB+A=;
        b=FFis8Hxm/6zgdvM6XImiQkxysY373MGrK3oiIkuSpccpzPGwEzf9nbm2Ok5anj4wVh
         WhLJrssQrPHa/DqzHWl9mG7ick2htM1D9M62fRSmBV604/jEu3MZGxMVAPSMdyMeeJoQ
         AAlldYX59Sd1qJTKT63KNNYWbKHKuGnxakzs8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=TSCQ13OxfZ1ohxNP7c5nwaQ/6GcDFCdC270GIu6zSfgnw3NW8Z6jb0AMjdCnoqiIzH
         6YRtgAOLqvII4uBf5d45didy2jyuwsQdNgX59b3/b5GtmatgzevCHq65zMgEniMEjUY3
         voagorr/WdmhfSvEvlVSbWtMsXKlH786JqhfA=
Received: by 10.223.40.136 with SMTP id k8mr5147567fae.24.1274734284531;
        Mon, 24 May 2010 13:51:24 -0700 (PDT)
Received: from helvete (dynamic-adsl-84-222-166-164.clienti.tiscali.it [84.222.166.164])
        by mx.google.com with ESMTPS id 2sm21278040faf.3.2010.05.24.13.51.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 13:51:23 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=helvete)
	by helvete with esmtp (Exim 4.71)
	(envelope-from <gscrivano@gnu.org>)
	id 1OGecW-0000ms-QP; Mon, 24 May 2010 22:51:32 +0200
In-Reply-To: <4BF2614E.50003@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 18 May 2010 11:43:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147648>

Hello Michael,


Michael J Gruber <git@drmicha.warpmail.net> writes:

> I haven't checked whether this covers all code paths but other than that
> it looks OK to me, and the tests pass.

is the patch ready for inclusion?


Thanks,
Giuseppe
