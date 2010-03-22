From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 12:34:26 +0800
Message-ID: <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
	 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 05:39:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtZQP-0007sO-4b
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 05:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634Ab0CVEjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 00:39:31 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:43875 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab0CVEjb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 00:39:31 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2010 00:39:30 EDT
Received: by qyk26 with SMTP id 26so2265032qyk.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pZokeKaL5oKoGdTo+H/R0BZE2yAMaNace12EcmqpbKA=;
        b=mWGSGfUkoDYM0+mUNAM66QWHK23b6avXkTqeZxVxsp0zD6Yg4NyzCM1v5g+ri/ravG
         aBSP4PAmI7ouqwyhiaMXMalomxXJ9dbt+CtJIrv19T9VrCO99lYfk6EhzpHnLZuLhTXZ
         IWV1o188dT1M4H8qI994SL6DNb7357wIrHRZM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pChq827XS0ghDrE15+kBfbf1xy1/8a2uyNyfLG7WzPBl1wh27kIjQdNN5RZsJqHh/a
         dyf8IfFDdcgKrqI/B9e6810c5rVKfQILW0N7axsPAkv76W0+hmUuJw5LPnQ1gGrAZisV
         NrAMl+C5s0JvYK9BqiPEbeYRvGrGJZKqzLmJI=
Received: by 10.229.191.18 with SMTP id dk18mr3353367qcb.9.1269232466493; Sun, 
	21 Mar 2010 21:34:26 -0700 (PDT)
In-Reply-To: <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142895>

> Horrible. =A0That is not how we name things.
>
> What's wrong with bog standard:
>
> =A0 =A0$ git log -L 10,20 master -- Documentation/git.txt
>
> which is exactly how "blame" does it?

The 'blame' way is very good if we only support one line range. But if
we want to support multiple line ranges, I don't think it is suitable
for that case. Anyway, how can I specify multi-ranges which refers to
multiple files at multiple revision and multiple line ranges using
above syntax?

Except that, I still can't convince myself that we need multiple
ranges support. Anyway, how do we display such a result to our users?

Regards!
Bo
