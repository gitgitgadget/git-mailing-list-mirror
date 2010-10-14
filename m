From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Stable ab/i18n branch
Date: Fri, 15 Oct 2010 08:50:45 +1100
Message-ID: <AANLkTin-s8EqssfuOeM6vAmBOFF=JrtgzS96hTSFKZ90@mail.gmail.com>
References: <7v39s9fkk1.fsf@alter.siamese.dyndns.org>
	<AANLkTimr73DUBBwdj9MXOQQ=O-vmyyEZpgwdHmRsGG_-@mail.gmail.com>
	<20101014200027.GA18813@burratino>
	<AANLkTim-2V_XtWVLFbWS_A-0rFNmuDvtR58aanxKL-O2@mail.gmail.com>
	<20101014205413.GD28958@burratino>
	<AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 23:51:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6VhX-00052M-BQ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 23:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab0JNVuz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Oct 2010 17:50:55 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:50465 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab0JNVuz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Oct 2010 17:50:55 -0400
Received: by qyk9 with SMTP id 9so174314qyk.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b5QQvWR9ew+7EeoX7nZsvx8jFIW1eBFISQ8RRa/jVys=;
        b=Wkbt8cUGn6wI/c3At3OGkzUQ9MaJ1QkRQ3mB8QNDNHCTD8LmcaqscVARfHVnq5d39/
         PNN1MZHyKEtAV4/OHSSgAmyPpnwflcLSpzdXwU/mnK9Gtnf2i09VTh1RpZwLnrTzMnpf
         880WAEpV1wNeWgE/vw0t19v6nh8qJrRGt1FJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EFUHGHX18WpNyVvmjzDnL6FwpRYGDiZ+wfx0aIQpNC2HCw+EDqrbblf210qvKQ5x0B
         BNC1s7vtzhxmskSEez4EBdIcJvvZ/FrQRnXGFc2YHKjFIYHDnC2km9U9OAd5nQ6fcCfU
         rCplFV2U1POp9jK/5kHBuQ3owemu3RRJLbmT8=
Received: by 10.229.215.193 with SMTP id hf1mr9297902qcb.59.1287093045389;
 Thu, 14 Oct 2010 14:50:45 -0700 (PDT)
Received: by 10.229.226.6 with HTTP; Thu, 14 Oct 2010 14:50:45 -0700 (PDT)
In-Reply-To: <AANLkTi=LEzQu5_EyJ_ncRmsHfufG=AnEv9+eTQuqh5W7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159079>

On Fri, Oct 15, 2010 at 8:18 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Oct 14, 2010 at 20:54, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> So what I've tried to do to make this acceptable for inclusion in cor=
e
> is to make this whole thing a no-op unless it's explicitly
> requested.
>

I agree with Jonathan that there might be some value to clearly
delineating the i18n infrastructure from the application of it to the
rest of the code base.The i18n infrastructure should be, relatively
speaking, less invasive than the application of it throughout the code
base.

It would be good for Junio (I presume) to have the option to integrate
the infrastructure in one hit, but allow the application of it to be
deferred, perhaps on a subject-area by subject-area basis.

jon.
