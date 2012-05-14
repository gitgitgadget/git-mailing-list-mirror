From: Stefan Zager <szager@google.com>
Subject: Re: submodule update --force
Date: Mon, 14 May 2012 10:17:53 -0700
Message-ID: <CAHOQ7J_O=8NL0wp0Pu6pfjN_Y6NDJhKZUft9G2FL0vUWL7aEBw@mail.gmail.com>
References: <CAHOQ7J8r4m2rz57BdkM9CADHdHE1yDFwExyF87u=DCEXjqzcqw@mail.gmail.com>
	<CAHOQ7J9xCYL=x=_nbq-3ksC2nF7L0=kxu9JX6M60xM-Bxmyfag@mail.gmail.com>
	<7vobpwpoyi.fsf@alter.siamese.dyndns.org>
	<7vk40kpnia.fsf@alter.siamese.dyndns.org>
	<CAHOQ7J_6+sfU6egjvVSPj-FAS6zjSUT=a057=kz_wYbogHLMMA@mail.gmail.com>
	<7v8vh0ozge.fsf@alter.siamese.dyndns.org>
	<20120510185738.GE76400@book.hvoigt.net>
	<CABURp0rFQ+330X8g3C2rmozQ77zxqhZhReZhaYMi1FE4uKeQtA@mail.gmail.com>
	<20120514165231.GB58058@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Lars Hjemli <hjemli@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 14 19:18:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STyuG-0007zI-5C
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 19:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974Ab2ENRRz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 13:17:55 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42859 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab2ENRRy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 13:17:54 -0400
Received: by qcro28 with SMTP id o28so3519678qcr.19
        for <git@vger.kernel.org>; Mon, 14 May 2012 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=mqXTmRaRpfqA/22RX6densPjXQnSKVKLhowFpXQwOsk=;
        b=orVRohbXOGh0t8H58wpbik3C+Gb08EGRA8zel3NIY4bSFFUeMBC556ArP1LLbk3Btn
         gvzy9BTM98IZMO+C/hLcIWHgbXn8YCnM/0QadhCTZXUGz7Ag+mOyvMK3fqK/tyxTf0Fi
         4Hc3kOr6+5OwmpmmofyuUY4HlqXC9k4VLnqKvyB2smKAo+RJqlISaiDej6wz3KH8MWyU
         oygLlB3pDw7GFAnxCQHUwW2hPdAYCGKxWJRNdRFZe34e3kaDmRHiAQrON+fiMiOIbFeY
         O5ZTbpQ06DiGqO9Hqj5v57hweFO5xY1nAg3UU7rIWf58wWPE7nF8I2tVMHz82iL2F67g
         Bzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record
         :x-gm-message-state;
        bh=mqXTmRaRpfqA/22RX6densPjXQnSKVKLhowFpXQwOsk=;
        b=J+QjZrYbkwqPg5byo9LoQLdX3n7Y5ZKP8pMikYAWkhdaLCbMZfO0+nKGVPCRWZj5Yj
         NUcyzk8UpC1OhTyvjqhln/aPyFrJw98O8+2b9OqFVCbj3Cg5egYqH0uWVlAQCm90GQg8
         TkPi9nsQi4OoeLHRKt9pbmu5r7nvieLKBvQIZprepoK73UhELWxRT30Cie/8m1/gjVDY
         L/mdoz0aNl3ew3H96CmAMdsSbSqoQNAN+XSrrf47Vm1gsbDQke5YUusHkJwlNIjl6Slv
         u2kp8a+tD8jOxO9qNwO0ilfn+s4jVvD1PFiw6mpym2RJbBX4xt4Ip2SWt2sjCAYhNm9u
         YOeg==
Received: by 10.229.102.130 with SMTP id g2mr4306088qco.77.1337015873824;
        Mon, 14 May 2012 10:17:53 -0700 (PDT)
Received: by 10.229.102.130 with SMTP id g2mr4306073qco.77.1337015873626; Mon,
 14 May 2012 10:17:53 -0700 (PDT)
Received: by 10.229.135.211 with HTTP; Mon, 14 May 2012 10:17:53 -0700 (PDT)
In-Reply-To: <20120514165231.GB58058@book.hvoigt.net>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmmxMqFq11pph7lm4IyG9xAKO2YEroS337P+EdBwRJYyZRcHVNUs64by6ofhqZtSMpgE1EFnJHjyMrUTtJmoCQam0TF/6oIASHR0UppOORwtRUnKfy2mZVfvpqtaIvDJ+wsTwMbvVsJECOQ6AiZptkbtoVGzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197788>

On Mon, May 14, 2012 at 9:52 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

> Yes we should eliminate surprises thats true. On the other hand there=
 is
> no way to setup submodules in the way Stefan had them by using the gi=
t
> submodule command or is there? So for his use case the command sequen=
ce
> you described seems to be more appropriate but I am not sure whether
> that justifies a separate option for it.
>
>> (3) is too heavy when I really only wanted (2).
>>
>> I do not understand that use case that led Stefan to the predicament
>> he was in where he had submodules with HEADs but with no checked out
>> files. =A0But I do not begrudge his being there.
>
> Yes, but currently -f is wrong in the way that when the submodules HE=
AD
> sha1 is the same as registered in the superproject it will skip the
> checkout. That is wrong when you have local uncommitted changes in th=
e
> worktree. In such a state I would expect it to throw away those local
> changes and checkout HEAD. So I think Stefans patch makes sense anywa=
y
> even though it might actually be to heavy for his use case.

To satisfy your curiosity, although it probably won't help me make my
case: I'm working on very large project with a lot of commit history.
Cloning this repository is prohibitively slow, so I'm trying to speed
it up by periodically creating a snapshot of the repository (and all
submodule repositories) that can be downloaded and cloned locally.

I first tried using `git bundle`, but cloning from the bundle files
was still very slow, because it took a long time to replay all the
commit history to recreate the index.  So, I hit upon another
solution: run `git clone -n` on the top-level repository and all
submodule repositories, and create a zip file of the empty checkout.
The resulting zip file is the same size as the git bundle file, but
unpacking it on the client (basically, `unzip` followed by `git
checkout HEAD`) is much faster.

Stefan
