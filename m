From: Daniel F <nanotube@gmail.com>
Subject: Re: git am mangles commit author name.
Date: Fri, 16 Jul 2010 10:18:21 -0400
Message-ID: <AANLkTimIkepwy93dYCu5mkdSMHNuh3dbMyxcHPl4hGmt@mail.gmail.com>
References: <AANLkTinqTL7gH4CHEfy8UrhK13xcO_3UzgIyQka00MAh@mail.gmail.com>
	<20100713054949.GB2425@burratino>
	<AANLkTinPCZ79vwZ9eVeHChgTuFGBrz3ACi_grM28Q5Y-@mail.gmail.com>
	<AANLkTikAcZa5J8XhKKJuDCHY3VMhSRzETv0ZQ34EcjMx@mail.gmail.com>
	<AANLkTim6Ax-4SVJU_LvR86SyD5q3VhCfGBlGOkSPTocL@mail.gmail.com>
	<AANLkTilZJ0g-XbkOsMh3Q1Jo7XQ2dbT1cY-YP_BdXvuh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 16 16:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZlkL-0007cS-1K
	for gcvg-git-2@lo.gmane.org; Fri, 16 Jul 2010 16:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965690Ab0GPOSb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jul 2010 10:18:31 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56333 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965654Ab0GPOSa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jul 2010 10:18:30 -0400
Received: by vws5 with SMTP id 5so2581381vws.19
        for <git@vger.kernel.org>; Fri, 16 Jul 2010 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zbL2hHLviIakXG7JBz+OfXzOtbslQl7lhHiU/OQjC1M=;
        b=uN53ZghwtxeM2VdvBHeOQJPb5cMK/tMm1oixpOld7y+11DSxjmAuBgdPNcovWCPTsQ
         DTdEs9N3nedOJWm7UeATGzZFtADIAUBkGT8czGD5kjs3oqqahyjk6XNcJG/jZTE3uiWb
         RBDYV4l6b46zNkIf6Mss3jJ1a+9Lh4hl84q9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MiZYUUXd2DEQLvIIg6jZAaDCXalgf68HBRGDGIqBiy9Q78+h3niLW/cin+3UEQsn8H
         fSJLmWGD+NQ7zc49hQCmdl8siAkw80ctULhOMcXj3fjyjDH90/X0RNeJEuiRMEFO73oZ
         pzP0zwg81zX0SPgyHZ7K/WD5CGpcFBbefsVsA=
Received: by 10.220.62.136 with SMTP id x8mr577720vch.177.1279289902160; Fri, 
	16 Jul 2010 07:18:22 -0700 (PDT)
Received: by 10.220.186.132 with HTTP; Fri, 16 Jul 2010 07:18:21 -0700 (PDT)
In-Reply-To: <AANLkTilZJ0g-XbkOsMh3Q1Jo7XQ2dbT1cY-YP_BdXvuh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151152>

On 7/14/10, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> w=
rote:
> On Wed, Jul 14, 2010 at 14:16, Tor Arntsen <tor@spacetec.no> wrote:
>> On Tue, Jul 13, 2010 at 17:11, Jay Soffian <jaysoffian@gmail.com> wr=
ote:
>>> On Tue, Jul 13, 2010 at 10:54 AM, Daniel F <nanotube@gmail.com> wro=
te:
>>>> Apparently, git-am fails when the username is just one word.
>>>
>>> And is less than 3 characters.
>> [..]

so... any git maintainers have thoughts on how this should
be addressed, or whether this should be addressed at all?
would simply setting minimum length to 1 have any negative
side effects?
