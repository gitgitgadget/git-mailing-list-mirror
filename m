From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>" better
Date: Wed, 17 Jun 2015 12:58:06 -0700
Message-ID: <xmqq8ubi6rap.fsf@gitster.dls.corp.google.com>
References: <558127CB.70603@web.de>
	<CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
	<vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
	<vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
	<vpqtwu6sf4r.fsf@anie.imag.fr>
	<xmqqoake4akt.fsf@gitster.dls.corp.google.com>
	<xmqqd20u48at.fsf@gitster.dls.corp.google.com>
	<5581A3A3.1070908@web.de> <vpqh9q6gsdt.fsf@anie.imag.fr>
	<xmqqpp4u6swo.fsf@gitster.dls.corp.google.com>
	<5581CAA6.5080306@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:58:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JTS-0000xX-GW
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbbFQT6L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 15:58:11 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37137 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbbFQT6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:58:09 -0400
Received: by igbsb11 with SMTP id sb11so45160694igb.0
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Pj1jPg5aZ/yIxHpBKlUjhsn5tDToV+83HEuwBveWYT0=;
        b=fEZ/oZDo8R88LrJgFZIvj4nvmg6fC15iybPM+n8gJr6kgH092L53yRTf/NzOja2s48
         ICx/hBj2Wsat0LY/6UXAYA7Vds8izGh9SE5rKYuCd67s9qXjS3UsqL0cngn6l2XcJFps
         rZr0dxMGZuG8W9ntYx3Brq6woPbO8pban4pBb38UjovQoqCwxeJin/AWhwlgCfwePwEF
         OjTMZ3hYVwCRul69aCsH9/4VB4v5Wk9mOrZa8hHY1ph7DjKj2f3RgymhtT0QP21Z/ots
         YNG1FeUu2K4822zjcbLO6a0iOEHwOPqTLBvcCjJoezAw/rqmnCEg1QBVIOPSyO9hOSm7
         b+WA==
X-Received: by 10.50.64.147 with SMTP id o19mr13260804igs.33.1434571088386;
        Wed, 17 Jun 2015 12:58:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id 137sm3245863ioo.29.2015.06.17.12.58.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 12:58:06 -0700 (PDT)
In-Reply-To: <5581CAA6.5080306@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 17 Jun 2015 21:29:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271901>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2015-06-17 21.23, Junio C Hamano wrote:
> []
>>> Basically, I'm fine with anything starting with "Switch branches or=
",
>>> but please do change the headline ;-).
>>=20
>> Likewise; I agree "switch branches or" part is good.
>
> How about this:
>
> git-checkout - Switch branches or restore changes to the working tree

Gahh.  We are NOT restoring CHANGES.  We are restoring the whole
contents to a path.

It is perfectly fine to do this:

	git reset --hard
        git checkout HEAD^ hello.c

There is no changes in hello.c after "reset --hard".

This is what makes it tempting for me to say "check out (an existing
contents to) a working tree file".

Moreover, it does not matter if the target file is changed or not in
the first place, so your added text:

>> 'git checkout' with <paths> or `--patch` is used to restore modified=
 or
>> deleted paths to their original contents from the index or replace p=
aths
>> with the contents from a named <tree-ish> (most often a commit-ish).

that says "restoring modified or deleted is from the index,
replacing is from a tree-ish" is placing a stress on a wrong spot, I
would think.

"Checkout individual files" is to "replace contents with existing
versions, taken either from the index or from a named tree-ish."
That is done in preparation to come up with the suitable contents
for specified paths.

This is a tangent, but on the other hand, "checkout a whole branch"
is to prepare the working tree to be used to modify the specified
branch.  And that is why the word "checkout" makes sense for both
operations.
