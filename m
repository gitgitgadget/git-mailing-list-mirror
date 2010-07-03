From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-cvsserver: pserver-auth-script
Date: Sat, 3 Jul 2010 10:49:17 +0000
Message-ID: <AANLkTilRfqg62NcvuLjCmNhJRlt8GFXFPAhG_M4fEa56@mail.gmail.com>
References: <20100702095406.7af15d20@ashinlaszlo.pta.neti.hu>
	<AANLkTinGZsCLF8CFKgQJaB63Jh9anGfQK4ZSHFPl4R4N@mail.gmail.com>
	<m31vbloa6m.fsf@localhost.localdomain>
	<AANLkTimts_MlrWGKaiu3frk7vOnK9B70RE7It2Wml3on@mail.gmail.com>
	<AANLkTinLgbrd-tOLntZt-FZkGVtTHXU2lteB-t7NAjSm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?B?TMOhc3psw7Mgw4FTSElO?= <laszlo.ashin@neti.hu>,
	git@vger.kernel.org
To: =?UTF-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 03 12:49:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV0Hs-0006wf-OP
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 12:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897Ab0GCKtU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jul 2010 06:49:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41989 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0GCKtT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jul 2010 06:49:19 -0400
Received: by iwn7 with SMTP id 7so4051718iwn.19
        for <git@vger.kernel.org>; Sat, 03 Jul 2010 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WVedD+PLlGuP/ipwHtN514Dcspgnp6/T3NNlgWSWdqI=;
        b=kOv9rKmGstGoIomRztUWTuJvUV8nXdHPPZERh7gXUKnbYM1iZw5kZfQN5qlW+qDSkg
         KgEbf3IyXl/skCxbjNqm5JFrn/SGefOYYb2UOnVb6Z2ZSGC/X/XZGrpaECxywFTBeHDc
         tiV0l98NvNhsd7FvitnYZM+eaAsQHsgWDGrtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RpSbnjDccXqv6sgZL4YiJ3kfOVn5eGexhEUpM2iS0MU/tQAs/UY7eBKS0X4GMRXGST
         3/VpOkzujzkLnTdyIwsElGbNYI/elpGjpPp3WjsEw276WdEPKS1TOqjnALgVru6wpE2j
         DA+u7UmursviUGzx8EZX2j0XNz6NUCjDtglWo=
Received: by 10.231.139.212 with SMTP id f20mr196672ibu.166.1278154157961; 
	Sat, 03 Jul 2010 03:49:17 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 3 Jul 2010 03:49:17 -0700 (PDT)
In-Reply-To: <AANLkTinLgbrd-tOLntZt-FZkGVtTHXU2lteB-t7NAjSm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150187>

On Sat, Jul 3, 2010 at 09:28, =C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@=
gmail.com> wrote:
> So, I will resend this patch - the corrected one without the mistakes
> I taken in the first version of it.

Good.

> Should I make one patch for each of the code, doc, and test case, or
> can they all go into one patch?

They should all be part of the same patch.
