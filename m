From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] Add a new commit-raw command.
Date: Wed, 25 Feb 2009 00:17:01 +0200
Message-ID: <94a0d4530902241417ld391492h2f76e325ef20a125@mail.gmail.com>
References: <1235510914-23319-1-git-send-email-felipe.contreras@gmail.com>
	 <20090224221406.GA6299@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Rene Stadler <renestadler84@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc5bk-0002Vd-9l
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 23:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604AbZBXWRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 17:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756132AbZBXWRH
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 17:17:07 -0500
Received: from mail-fx0-f167.google.com ([209.85.220.167]:43933 "EHLO
	mail-fx0-f167.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZBXWRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 17:17:05 -0500
Received: by fxm11 with SMTP id 11so3217390fxm.13
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 14:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ijvPUt2WD4QzYCUnnKiA6nmu0gewFQOQyat5GcgOZJk=;
        b=BWgyJbA09IwggLodaztt7W/4xay/3zSso03jS2DP1HQP6OEN8IIKtgP/o2A51YkPr2
         QJRp3D3E7DMovg33Jg69udyvzcr0hmk9a3YZzomCm8jzNszGrBIqA4rdX7h/sJ56NBd/
         gTTxaIL8pijgpJwrlRFtcHH+7Kqb2A9Gu1x5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IFcuyRT/3cm5/LeCQ17KctN9t0UlD0bAnirYaUlVUrLQRWu2q6az+iOgV/mpcLwMPh
         2vvCVQtdZFl+x9S6nPzeTGA0nBPdheUpDeI7ZS2hm4x12vkI9U/wMwPhQ3simk9K40o6
         YXra7XKbkr20E2AMzJYTyi7AJD8mpufSzrXBs=
Received: by 10.86.59.18 with SMTP id h18mr79563fga.57.1235513822086; Tue, 24 
	Feb 2009 14:17:02 -0800 (PST)
In-Reply-To: <20090224221406.GA6299@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111354>

On Wed, Feb 25, 2009 at 12:14 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 24, 2009 at 11:28:34PM +0200, Felipe Contreras wrote:
>
>> This command receives as input a raw commit object, and outputs the
>> generated sha1. This is very useful when doing some serious repo
>> reconstructions.
>>
>> For example: git cat-file -p 343ee25 | git write-raw
>> 343ee2589d1b94772f513cc699765622351acb19
>
> How about:
>
> =C2=A0git cat-file -p 343ee25 | git hash-object -t commit --stdin

Duh! Thanks :)

I knew there must have been something for that use-case.

--=20
=46elipe Contreras
