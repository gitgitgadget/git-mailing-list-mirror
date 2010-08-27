From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #06; Thu, 26)
Date: Fri, 27 Aug 2010 15:33:50 +0000
Message-ID: <AANLkTinYUjjL7FP8PnNX4jkQL7QuALmQYLF8bu+XUDxD@mail.gmail.com>
References: <7vzkw8k6wv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 17:33:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op0wH-00046i-Cb
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 17:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610Ab0H0Pdx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 11:33:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61579 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525Ab0H0Pdv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 11:33:51 -0400
Received: by iwn5 with SMTP id 5so2701838iwn.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8cvMQCUHWoOL+mtbcIu3PMJN+B9GkpjsA5t67F7jpgk=;
        b=uuzk4XfCCYATGKpxABkwIoC/xei5brGVofi3B5vK3LA93oZRlRqNa6IKdeT0MwpmsS
         tn9SIM3Q2GhukYeBzmitPSNVhRK/9QjIDMGyk0SvdlVrnaUHc3ZPqWr0Msi8+vmgCFJm
         r7FaW9O01dn61lESDf04uiyniHxN4d2x869qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xqm9dxWS4QKUfJNMV5yrpB0n3QBecrfnGVLnHHpPgm7vzrr+u6pHm+4ogj6zENaQmy
         kCfarOaxF3vwHvW3rkHEofwYg8plq/7tLSGWCEqiV2aktVQARd3QBhUnD/mp0V/kPON5
         SokeYPsDHCCgkmJUy7RNRx7/YWtDJcTvhhQPM=
Received: by 10.231.15.195 with SMTP id l3mr1221245iba.188.1282923230809; Fri,
 27 Aug 2010 08:33:50 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 27 Aug 2010 08:33:50 -0700 (PDT)
In-Reply-To: <7vzkw8k6wv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154601>

On Fri, Aug 27, 2010 at 04:37, Junio C Hamano <gitster@pobox.com> wrote=
:

> * ab/i18n (2010-07-25) 4 commits
> =C2=A0+ tests: locate i18n lib&data correctly under --valgrind
> =C2=A0+ gettext: setlocale(LC_CTYPE, "") breaks Git's C function assu=
mptions
> =C2=A0+ tests: rename test to work around GNU gettext bug
> =C2=A0+ Add infrastructure for translating Git with gettext
> =C2=A0(this branch is used by ab/test.)

Thanks for merging this into next!

I'll start submitting patches to gettext-ize some of the Git source
soon. I'm going to start with the common mainporcelain commands like
git-init, git-clone etc.
