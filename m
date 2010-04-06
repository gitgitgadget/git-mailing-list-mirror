From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4] Documentation/remote-helpers: Add invocation section
Date: Tue, 6 Apr 2010 16:34:40 +0530
Message-ID: <w2vf3271551004060404qc10fc39am937f9dbaf0ffc593@mail.gmail.com>
References: <x2zf3271551003311240i53ecb2fck173c8f34bdb3257@mail.gmail.com> 
	<7v1vetmrl1.fsf@alter.siamese.dyndns.org> <r2gf3271551004051943u6111c956p24f4fd2897c08d0c@mail.gmail.com> 
	<7vhbnpjcuq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 13:05:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz6ap-0001sM-4e
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 13:05:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161Ab0DFLFF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 07:05:05 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50347 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab0DFLFB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 07:05:01 -0400
Received: by gwb19 with SMTP id 19so1722863gwb.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gewFcOYjl1S22l+PnKlIWaoCgA8srfZQeuEu1ocuItk=;
        b=FPmz9kNdIg4hSSkz7vRD/nvFQBqnDEDJwHYmpcauiQsphHz0h97ScUcdniYyakOajb
         Z2OiMtmkx5ApdEZb9216i7WlpCDQJcG/fKoO+UIGh5VpeDDVqYHhXs1qjRbNKKd76hEu
         Ep/mvlUMa0TOaFR0G1CO9IL0JtM8gE1JSue98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=u2QG085XddZF93sIQuSe/hWgSLHCpuMeiVdFR5BHhEr22E9HvIxfSecokMSGbopMUO
         wRsW0+ksQj8NTiIxWhu07lhKjCZzFQsF5lrM0Lk6BTCYBaI9HnXkWrGpz/lFrW8LAeOn
         zRLZwDIo7SvXnFd2Ssl8VHQFwI96AiM/neKvo=
Received: by 10.90.69.14 with HTTP; Tue, 6 Apr 2010 04:04:40 -0700 (PDT)
In-Reply-To: <7vhbnpjcuq.fsf@alter.siamese.dyndns.org>
Received: by 10.91.147.7 with SMTP id z7mr1704501agn.2.1270551900534; Tue, 06 
	Apr 2010 04:05:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144127>

Hi,

On Tue, Apr 6, 2010 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> While in principle I can understand Daniel's aversion of spelling thi=
ngs
> out in too much detail to paint himself in a corner he cannot get out=
 of,
> I think it is necessary to give the overall picture to the readers (m=
y
> intended target audience is "helper writers"). =A0In other words, I t=
hink
> the documentation needs to say something like:

Okay. I've tried my best to incorporate everything you've said into
v5. If there's some detail that will change later, the document can
always be updated :)

-- Ram
