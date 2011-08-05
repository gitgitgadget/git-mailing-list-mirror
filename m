From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] rebase -i: fix has_action
Date: Fri, 5 Aug 2011 14:36:00 +0200
Message-ID: <CAGdFq_j2wRw-gB109VypZkG1u=fm7yynkn2-Gu8AzNpVOrun8w@mail.gmail.com>
References: <1312450780-5021-1-git-send-email-nrubinstein@proformatique.com> <7vliv93r9g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Noe Rubinstein <nrubinstein@proformatique.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 05 14:36:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpJe4-0006Zb-SK
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 14:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab1HEMgl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 08:36:41 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:58361 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756555Ab1HEMgk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2011 08:36:40 -0400
Received: by pzk37 with SMTP id 37so3844579pzk.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RPwlXeFdqjZaRhuDmASQDEU2aQtHOksMGt0Arfp1Kxs=;
        b=HMWRPUuqks6orXQGoEZ1z4z00hiTnnYqC4eGmcFM9nPlZbF/bgw3BQNdrBrfVgRIeG
         5laamuceiGpyS8Evgj9LOIHVfEt+4xHbrQrYa/W7Qi2fT28A0GYl20nCIbV1TL+3NRyg
         srX3W/9V/KAEOpS5Vsmx2TW6V0UYAy5h3aG7s=
Received: by 10.143.20.28 with SMTP id x28mr2029621wfi.349.1312547800076; Fri,
 05 Aug 2011 05:36:40 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Fri, 5 Aug 2011 05:36:00 -0700 (PDT)
In-Reply-To: <7vliv93r9g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178792>

Heya,

On Thu, Aug 4, 2011 at 21:34, Junio C Hamano <gitster@pobox.com> wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0has_action () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test -s "$1"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

> =C2=A0 =C2=A0 =C2=A0 =C2=A0has_action () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sane_grep -v -e '^#' -e '^[ =C2=A0 =
]*$' "$1" >/dev/null
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

I think the former more correctly checks what the function name
implies, is there any downside to that which makes you suggest this
second approach?

--=20
Cheers,

Sverre Rabbelier
