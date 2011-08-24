From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 4/4] Add documentation for ref namespaces
Date: Wed, 24 Aug 2011 14:30:12 +0200
Message-ID: <CACBZZX7OYF9g_0dWXSmZiPqRmMRt+kR-dM0fBfkhmH4yg485KA@mail.gmail.com>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org>
	<1307470885-4018-1-git-send-email-jamey@minilop.net>
	<1307470885-4018-5-git-send-email-jamey@minilop.net>
	<CACBZZX4bow8vwrwSL5uRJQtAgeg10_K+5ss8u-HvCHOn3+0Tuw@mail.gmail.com>
	<7vfwksrqp1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 14:30:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwCb5-00039M-Jv
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 14:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab1HXMaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 08:30:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab1HXMaN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 08:30:13 -0400
Received: by fxh19 with SMTP id 19so926029fxh.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 05:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1kB5Jo4DbTJb/pQZTkJV7Xc2lZXLDCL3VjEMqEfz92s=;
        b=ICBLhwU994fxc/UUEQPJF+Jbxj9nMtMvZ6MJX8GJdsE5vedVD+kC07nmVneTu1Tahl
         drJ9Elf6Exc68OAMEm36ieols5xhlrb0Bc0KO4kwX2ecQmPJSJ4mQaC2Wf/QRKHegdlq
         O+ZxXuMnSU7/muNW+KFfCrzAfr7T6cPyYrtf8=
Received: by 10.223.29.76 with SMTP id p12mr7123827fac.51.1314189012196; Wed,
 24 Aug 2011 05:30:12 -0700 (PDT)
Received: by 10.223.78.203 with HTTP; Wed, 24 Aug 2011 05:30:12 -0700 (PDT)
In-Reply-To: <7vfwksrqp1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179998>

On Tue, Aug 23, 2011 at 19:19, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Tue, Jun 7, 2011 at 20:21, Jamey Sharp <jamey@minilop.net> wrote:
>>
>>> Document the namespace mechanism in a new gitnamespaces(7) page.
>>> Reference it from receive-pack and upload-pack.
>>
>> This breaks the build on older asciidoc versions, the fix is to do
>> what I did in f5008f56d5aba06598e1c6272f4f55b4ee4bb016.
>
> Thanks for a sharp-eye, even though I would have appreciated it even =
more
> if you spotted it while the series was still in 'next'.

That should work. And I very rarely compile things on these old boxes
so I usually don't spot them until they hit master. Sorry.
