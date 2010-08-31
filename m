From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 06/17] gettext: localize the main git-init message
Date: Tue, 31 Aug 2010 15:39:19 +0000
Message-ID: <AANLkTimVGJugnxFzk9Vy2BOZiH=PXWmNs108qs1oSwdy@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<1283203703-26923-7-git-send-email-avarab@gmail.com>
	<20100831151044.GF2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSvm-0004A3-Gq
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757569Ab0HaPjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 11:39:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59216 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757558Ab0HaPjU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 11:39:20 -0400
Received: by fxm13 with SMTP id 13so3998093fxm.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DPsbpbXGQSREOFUqDbis908ntQPPLeSmjE2zxtFEBGs=;
        b=OS8LhUCuG+KgTayWRQ5q3ZsJkqQSZtuE8H+7uaRsPOlj0kOxU0ZfG3zUtQFXfOm98Y
         haHuFckXOZG9juGcT61jkDwihN5kKJQP5Ov5amXxxFeY4G+6dlgreyieIRC99b0CPfTg
         EwwPwLQ1Ntp4EYkZ7mxB2DOctzvfvej4ikDt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u43Oh9WC45qNOoDNEz2iky3dBeRKuWaStvaKT+3FHB+g5d6fpd+ynRtcTq8twoQNmW
         A+ZJyuXRxJwnsyWSkq7IDU99xdNDiw4Tq0bRB3q5iUl9lXwcOK4Qd80SbR3PZ2Tzg8AG
         1IhrMTSROdUMPGnDalG5YcyaG/ogIT+ICXaOQ=
Received: by 10.223.108.80 with SMTP id e16mr2490815fap.16.1283269159534; Tue,
 31 Aug 2010 08:39:19 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Tue, 31 Aug 2010 08:39:19 -0700 (PDT)
In-Reply-To: <20100831151044.GF2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154916>

On Tue, Aug 31, 2010 at 15:10, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Note that the TRANSLATORS comment doesn't use the usual Git
>> style. This is because everything from "/* TRANSLATORS: " to "*/" wi=
ll
>> extracted as-is xgettext(1) and presented to translators, including
>> newlines and leading "*"'s.
>
> How would it cope with the following?
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* TRANSLATORS:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The first '%s' is either "Reinitialized=
 existing" or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * "Initialized empty", the second " share=
d" or "", and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * the last '%s%s' is the verbatim directo=
ry name.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>
> The leading column of stars makes it easier to distinguish code
> from comments. =C2=A0(Plus I am not too happy to read code with two
> inconsistent comment styles used.)

As I was (trying) to get across in the the commit message it'll make
the *'s part of the message. I.e.:

    TRANSLATORS: * The first '%s' is either "Reinitialized existing"
    or * "Initialized empty", the second " shared" or "", and * the
    last '%s%s' is the verbatim directory name.
