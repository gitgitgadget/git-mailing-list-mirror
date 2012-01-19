From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] i18n: disable i18n for shell scripts if NO_GETTEXT defined
Date: Thu, 19 Jan 2012 10:15:23 +0100
Message-ID: <CALxABCa6cxxnxzSQuo5HNGBCax5VGrX7YGiBmkHw_1B5Xm1ASA@mail.gmail.com>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <7vfwfervt9.fsf@alter.siamese.dyndns.org> <20120118195438.GA18892@blimp.dmz> <20120119001225.GA13975@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 19 10:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rno63-0005T1-5f
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab2ASJPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 04:15:47 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:50735 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754412Ab2ASJPo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:15:44 -0500
Received: by obcva7 with SMTP id va7so8395826obc.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6kAhrQ1eM+qkPyTshrlAZiHLug3DUA+iJh7rpgq1JyM=;
        b=ISb3fq89khtX0xS2ZJe8FdIpyuLOXrLUBLSmyZdpCVq3IN76WG60F1kWn0mUetx4Ml
         vkc/spvbKOzmnvcwF7C8ptigTbZEzzEyL2R2Rq2wMvuT+zqlJOHqN3fI/7FhTbAVZZ0a
         24dAdmrgk6VpmyHuUMqgvYiA2McmL0M67PkM4=
Received: by 10.182.216.100 with SMTP id op4mr22225298obc.53.1326964544167;
 Thu, 19 Jan 2012 01:15:44 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Thu, 19 Jan 2012 01:15:23 -0800 (PST)
In-Reply-To: <20120119001225.GA13975@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188797>

On Thu, Jan 19, 2012 at 01:12, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> I like the unindenting. =C2=A0Alas, I get
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A01: test: type: unexpected operator
>
> I suspect this should just say "elif type gettext.sh >/dev/null 2>&1"=
=2E

Indeed. Copy-paste error. I wonder why I didn't notice it...
Yes, ran the tests, both with and without NO_GETTEXT.

> The rest looks good. =C2=A0Thanks for writing it.

Was Junios idea, I just liked it.
