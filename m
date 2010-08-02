From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 02 Aug 2010 17:04:14 -0400
Message-ID: <4C5732CE.10906@gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com> 	<1280780684-26344-3-git-send-email-avarab@gmail.com> <AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:04:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2BO-0004uG-OY
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0HBVEW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 17:04:22 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51150 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0HBVEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 17:04:21 -0400
Received: by vws3 with SMTP id 3so2383469vws.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=91hkaf1K7/AbX5ctjJrlN7EIBmCXhZonojRonqTTPoI=;
        b=ftwJThJyvc2SFj910Q/Is3IAr5aQDiZNizwa27mgJofyLLhenFE/OragYiEfs9Fk9j
         Tba0Vo57S5KnIPCetghZP6uVNfeajRRo+vR6aN5u0Oaw6jcglalRMaBBx4Wok0inCSsy
         iq5zAByhLod++HBxJ/9xd84cUMaVBQe1kv7Yg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=diW+Ct0uo9MUsSMexsgggyDE5GbXwbk7S3Z909sLKWGrsyMI/P/gjumrkmovbr4elb
         HBrSdQDkeX7Jh67QDKc3JNAtH6DarkBC8FypL6AcTavVJjdKC176bFpz0RkISiZImFnJ
         Yscocvdqc5QO1fqq/zQRs+aA9ny4Xut/1xfks=
Received: by 10.220.89.68 with SMTP id d4mr4607129vcm.98.1280783060549;
        Mon, 02 Aug 2010 14:04:20 -0700 (PDT)
Received: from [192.168.1.5] (cpe-67-248-185-165.nycap.res.rr.com [67.248.185.165])
        by mx.google.com with ESMTPS id y25sm6376602vbw.6.2010.08.02.14.04.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 14:04:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100620 Icedove/3.0.5
In-Reply-To: <AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152459>

On 08/02/2010 04:54 PM, Sverre Rabbelier wrote:
> Heya,
>
> On Mon, Aug 2, 2010 at 15:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason<=
avarab@gmail.com>  wrote:
>> Git now has a smoke testing service at http://smoke.git.nix.is that
>> anyone can send reports to. Change the t/README file to mention this=
=2E
>
> Can't we run this somewhere a little less "shabby"? I'd hate to
> introduce Yet Another Official Git Site (I'm really glad for example
> that the Git Wiki is now on kernel.org). Is it not possible to move
> this to git-scm.com, kernel.org, or something like that?
>

And what's on the site tells us almost nothing about the tested systems=
=2E
