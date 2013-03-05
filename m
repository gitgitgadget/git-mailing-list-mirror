From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias> --help
Date: Tue, 5 Mar 2013 17:32:13 +0100
Message-ID: <CACBZZX5=ARahxswkN_mLbBF3fQxV-HtKgehe_3ogHg5-i7utYw@mail.gmail.com>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com> <7v8v61vn3h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:33:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCunf-00082K-JP
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641Ab3CEQcf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 11:32:35 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:41938 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab3CEQce convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Mar 2013 11:32:34 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so2756082obc.6
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 08:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=zs3CeocNPgX3KdXVBjyELgrXecmUwsuJcN4ikBGnrpQ=;
        b=dkkuu0KNNf/GC2+9N/ZLcKtSzFcVFRcJnnv+fsHY16Wj5o7C+5I2EeIgOZ4zmN/OG1
         JIQOIOrRUv4hR+g0hEGXP8tY41trvtdEH9hw1IQjQXvcmUOiXBUPaI99yl7fi68jwCoK
         /zJaw/3p0V4tijaUcRMYqVJdO6Y9Hs2wQJrJWu/6Y1+76joCMGyH9Wg/75ZsvzlNxsUv
         YxTXnkaeOfIrdvRZcBQ+b56Chi66tQCFFEq/VIQokmy7Y7mPepVeTDpNCaEckxS5W1Hp
         XjRctjNrXRHnL3ZcVfE8wRh6MtHC0wNdG1ztc2ACW7UVCuOfA0EekwSqADb0pXGUJOV5
         NbGg==
X-Received: by 10.60.21.101 with SMTP id u5mr20034364oee.71.1362501153779;
 Tue, 05 Mar 2013 08:32:33 -0800 (PST)
Received: by 10.76.167.34 with HTTP; Tue, 5 Mar 2013 08:32:13 -0800 (PST)
In-Reply-To: <7v8v61vn3h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217461>

On Tue, Mar 5, 2013 at 5:16 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the semantics of "git <alias> --help" to show the help for th=
e
>> command <alias> is aliased to, instead of just saying:
>>
>>     `git <alias>' is aliased to `<whatever>'
>>
>> E.g. if you have "checkout" aliased to "co" you won't get:
>>
>>     $ git co --help
>>     `git co' is aliased to `checkout'
>
> If you had "lg" aliased to "log --oneline" and you made
>
>     $ git lg --help
>
> to give anything but
>
>     'git lg' is aliased to `log --oneline'
>
> I would say that is a grave regression.

Good point. I'll fix that up.

No objection to the patch in principle though? I.e. not showing you
what the alias points to.
