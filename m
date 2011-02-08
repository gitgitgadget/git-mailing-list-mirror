From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2011, #06; Sun, 30)
Date: Tue, 8 Feb 2011 18:48:24 +0100
Message-ID: <AANLkTikyHANL3y8VZ3LWu7bXkJwEHiiDLJ5NDZaA7z=b@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <AANLkTik4jZWLt6T-SwMgK94FJ77ujyUC4-oFD46-eqN=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 18:56:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmrnG-0006bJ-6U
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 18:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab1BHRz5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Feb 2011 12:55:57 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50696 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755037Ab1BHRz4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Feb 2011 12:55:56 -0500
Received: by yxt3 with SMTP id 3so2363270yxt.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 09:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=Cvr2cDTIPN2A+wXVSE/rwnWSGqt8XTbgdQagWrxl4Tw=;
        b=Rs1TeD7UzzfyANjy1vWau5sOrOvUxoig9+Cac5+KmxRJNbTfG6ePFbXvSdF+ggsx1B
         kocNcHKlTo5sUKaw9BKpzqG42TkUdpXdNmEWAw+ds+FNbPpmcGSeTE09urvbn+AVX3xK
         fEUVar4YtexETzs7+Bv2C4nmWnNE1+HD1DwLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=lZtjlB/oUFMM72V6CU8l2SfUQGHwU3vqvc9IA2oPc3F+WFE2iMnXeM4pxx+3zreA8p
         QjNexNU0FMySlLb7ycLFI3HA5cFncmNwQ+jYo7GMZy2S7cezwI1tkq5xKbPqL5j2w/F6
         bHcLcpaEEv92MyDxoxzOSbnxx9lctWUudXuuM=
Received: by 10.150.229.16 with SMTP id b16mr272078ybh.226.1297187755689; Tue,
 08 Feb 2011 09:55:55 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Tue, 8 Feb 2011 09:48:24 -0800 (PST)
In-Reply-To: <AANLkTik4jZWLt6T-SwMgK94FJ77ujyUC4-oFD46-eqN=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166362>

Heya,

On Mon, Jan 31, 2011 at 16:08, Sverre Rabbelier <srabbelier@gmail.com> =
wrote:
> On Tue, Dec 14, 2010 at 03:20, Junio C Hamano <gitster@pobox.com> wro=
te:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>> On Mon, Dec 13, 2010 at 09:34, Junio C Hamano <gitster@pobox.com> w=
rote:
>>>
>>>> Needs a bit more minor work to get the basic code structure right.
>>>
>>> And I'm still not sure (see earlier replies to "What's Cooking" pos=
ts)
>>> what needs to be done to make it better.
>>
>> One open question was why you do not want to move 'LIB_OBJS +=3D get=
text.o'
>> away from the LIB_OBJS section down to the configuration evaluation
>> section, i.e., why gettext.o would be different from block-sha1/sha1=
=2Eo.
>
> =C3=86var, you didn't respond to that message. Junio, do I understand
> correctly that if this problem is addressed the topic is ready to be
> merged to next?

It's been a week, no response from either Junio or =C3=86var ? :(

--=20
Cheers,

Sverre Rabbelier
