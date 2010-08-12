From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH V5 16/17] Add tests for line history browser
Date: Thu, 12 Aug 2010 16:27:41 +0000
Message-ID: <AANLkTinZ8vqfqL5ajFuxMDa9_SP5-vewFYnBUp5fxaAu@mail.gmail.com>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
	<1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
	<AANLkTi=qvywaiwYpr7ZZ6Gf0i_curaLr0E8gRLD5WTK-@mail.gmail.com>
	<AANLkTinYaOhNNBj9_6mFF3azaFAwUJgeLVkyax2ZbVOm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 18:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjadA-0008SK-Ob
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 18:27:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760014Ab0HLQ1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 12:27:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58705 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab0HLQ1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 12:27:42 -0400
Received: by fxm13 with SMTP id 13so839907fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=H8DNWBYcDyLOG4oNPQz3lOP6GvLBHrTvd2jazHzkBPw=;
        b=Sk4usnzqLZo/BA/Xp+rkdxnO9F8xVTbxkg2sOm4/dB5U8r4zZXxlQ9RTqSDBW3+wxE
         zqY1TQRI4BPbzmJTLAozpx77puSOygmean0RzauUFYK4AfHUZv+hIfd+Ju3diM8cuAxA
         DQjsE5eOLv+zpKthv9IMA/1lXeec7/Z46TDa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w2u1cYM6t5ilkK0dBlpVewDD7QUM/xukGw0SaFr919Gr/Qg4cpEPsUiktjqmuixIr3
         deMLEEm3NVRSsUKE3ABUVeld+jm4bNJK7By89OiBdc5lLs8EKAJvyr5t8tr5YSc3+GDA
         6SC2oLrZEWL2VGKPwx0lgAhyX6iM8o2K5EBtg=
Received: by 10.223.113.13 with SMTP id y13mr514443fap.37.1281630461491; Thu,
 12 Aug 2010 09:27:41 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 12 Aug 2010 09:27:41 -0700 (PDT)
In-Reply-To: <AANLkTinYaOhNNBj9_6mFF3azaFAwUJgeLVkyax2ZbVOm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153385>

On Thu, Aug 12, 2010 at 12:24, Bo Yang <struggleyb.nku@gmail.com> wrote=
:
> Hi =C3=86var,
>
> =C2=A0 Seems this is the SP problem. Do you apply this series with
> --whitespace=3Dfix ? This will erase some spaces in the diff files,

I just pulled it down from pu, maybe Junio applied it like that.

Try pulling down pu and testing, do you have failures?
