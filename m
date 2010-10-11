From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] Makefile: Turn off the configure target by default
Date: Mon, 11 Oct 2010 11:26:38 -0500
Message-ID: <20101011162638.GH25842@burratino>
References: <36e21bdafd75e95f1e13437f81067c71c7390408.1286783121.git.git@drmicha.warpmail.net>
 <AANLkTikb2vDMXLa48QsDfK6grczmqC1uk1jYi0ZFq9QC@mail.gmail.com>
 <4CB2FEB8.3050705@drmicha.warpmail.net>
 <201010111718.39996.jnareb@gmail.com>
 <4CB32D15.4080204@drmicha.warpmail.net>
 <AANLkTimAj_sCquCixmTOEV5ZaQVbbv-yvm=Yw82har1t@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 18:30:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5LGC-0007nE-FY
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 18:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab0JKQ34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 12:29:56 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34236 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668Ab0JKQ3z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 12:29:55 -0400
Received: by vws2 with SMTP id 2so993702vws.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lqEVXZ8yP9r/nIM1TJrgSpYJ1Ke5LAUjRxCrwxB49wU=;
        b=wzwIzaqRHfacLI1qfhRR8wbfnMutrX2UiPzq+N/8+sBbXWZ0JjWhCsc+CJz8IP5QyU
         o47KPfm8Oi9VxyBQfcbW4qqBsbUnrREmMt4+ksr8MPtj2SS+qOEMV+L1ggBCNmmUHX6E
         JzBEGZFwn4Mi0mcLBoEgO+FMcn0KzJ00KCvDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HT++CeigrYhQuq6KA6Vv8kwXJeApJK6toBcbMNtlnBEDfaC1Y7VQG0GiBqRosn+Fk/
         4BsHeKe+5CqVJsBHy92BDaQRuWR2V0f8f2Ms2HReUUaFdoAJs9jEWhh9dTUfe3TO0fSS
         5taAlIcqoq/9dPNUXdMOX2XtNdikxNeb54pNE=
Received: by 10.220.194.204 with SMTP id dz12mr1998572vcb.79.1286814594605;
        Mon, 11 Oct 2010 09:29:54 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id m10sm2044956vcf.45.2010.10.11.09.29.52
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 11 Oct 2010 09:29:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimAj_sCquCixmTOEV5ZaQVbbv-yvm=Yw82har1t@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158779>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Oct 11, 2010 at 15:28, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:

>> My observations on the list don't quite confirm that "configure" can
>> only improve the make situation, but I don't use it myself. So, I'll=
 let
>> those give configure advice who use it.
>
> If it doesn't improve it that's a bug that we need to fix.

Probably Michael was referring to the FreeBSD 4 thread:
http://thread.gmane.org/gmane.comp.version-control.git/158639

I suspect it has nothing to do with "configure", but given that
most of the active developers do not use autoconf, it tends to be
the first unknown one is tempted to eliminate.
