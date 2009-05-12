From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] topgit tg push feature
Date: Tue, 12 May 2009 08:22:13 +0200
Message-ID: <36ca99e90905112322v2aa93a34te9d4a9baf6b6da92@mail.gmail.com>
References: <20090505093448.GC16524@gmx.de>
	 <36ca99e90905062245w1ec78828ice5ed18161b6ec43@mail.gmail.com>
	 <20090507084355.GA11680@pengutronix.de>
	 <36ca99e90905070250l656f8879g87eb27c09db2cd42@mail.gmail.com>
	 <20090509103625.GC13344@lapse.rw.madduck.net>
	 <20090509190910.GA9655@gmx.de> <20090511032813.GA15540@gmx.de>
	 <20090511195532.GA28340@pengutronix.de> <20090511210614.GA6118@gmx.de>
	 <20090512051334.GA22757@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue May 12 08:22:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3lNe-0004wS-PW
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 08:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755611AbZELGWO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 02:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755556AbZELGWO
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 02:22:14 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:44067 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbZELGWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 02:22:13 -0400
Received: by fxm2 with SMTP id 2so3113895fxm.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 23:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zREDyuE3+MSC3Ve40NIv2CE0S1S+riO2BMOd1Iv2UK4=;
        b=p7iTWo9F02poTJltAhWBARIVtR0gbU+8uRdQ3QX9mwUSm/K4lQK6txL2hUpE9Cb1Uf
         wGl6304fQvf/EYFENqelUL0eCRIxvBGl33KE/SRnn8g3RbjNnQ6GLdbEa7nD1Ap7YTJ2
         VMETA0SlP5VPRQhy+ZGPl9t1Er1+ziTA9IfUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qki5/7/ZDdG75VezEL25RRuhYnsfrE1jIE5yez1jSNxrglfcssfubjQbI/uXTise45
         i7sahmduybqukSeEmHp8eFnqlXhLKlmDc0mJmr1DLWYDcKzKYXQ2n+yuVNEQMGCF3sRZ
         /URH8CqprWT3Q7B+S7iV8qLpLVGOYoxpeupuo=
Received: by 10.223.113.68 with SMTP id z4mr4301212fap.72.1242109333625; Mon, 
	11 May 2009 23:22:13 -0700 (PDT)
In-Reply-To: <20090512051334.GA22757@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118872>

2009/5/12 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hello Marc,
>
> On Mon, May 11, 2009 at 11:06:14PM +0200, Marc Weber wrote:
>> Thanks to Bert Wesarg, Uwe Kleine-K=C3=B6nig and Martin f Krafft the
>> patch is finally ready to be comitted (?) I included ukleineks last
>> nitpicks.
>>
>> ukleinek, usage line: remote2 =3D just another remote location.
> hhm, so you suggest that you can add more than one remote per -r opti=
on?
> I wouldn't document even if it works now.
That was my intention my asking for the -r option. The -r option is to
'tg' not a tg-command. And it's still not addressed.

Bert
