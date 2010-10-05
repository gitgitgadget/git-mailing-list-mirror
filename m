From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: 1e633418479926bc85ed21a4f91c845a3dd3ad66 breaks on OSX
Date: Wed, 6 Oct 2010 00:33:20 +0200
Message-ID: <AANLkTimwRJ+X4Kom9_Nv-5Xjf1LKCPbkwavWYHqCdTaM@mail.gmail.com>
References: <86r5g42wo8.fsf@red.stonehenge.com> <AANLkTinq7haFRs6h8W+ycDy5MzFgjty6LaD8syL+KnHX@mail.gmail.com>
 <86iq1g2vhq.fsf@red.stonehenge.com> <20101005213401.GA22845@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 06 00:33:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3G4z-0005Yz-2n
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 00:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442Ab0JEWdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 18:33:41 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43033 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab0JEWdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 18:33:41 -0400
Received: by ywh1 with SMTP id 1so206956ywh.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oBGZjAH7GyE5Z0yQo/gJtSBVg+KWhXbghY+tlyXQJVE=;
        b=pb9xi52+cohb0TxxJXhdgrhXWmTTX5nekttAMqvokpgNACU21O+DqrH3LIfxhQchso
         ueF1sO5ZjmxYGTMKnvL+WuI3J373UuPEKV5E0DlcGgDo6XjV2f0JFX3yTCd8q8NM8tOe
         YTEubf0i1Sf5kkxQc5595ToxDM77CyO3vczws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=IfmEa/EjYK8DCQ08nUfETBcS7ydJDed9jtsZfylaJsI3XchjMDDoxjBD8BhOOyHrcE
         o0m16Mnoalfg2Wh6hQ/Yig+Q6IfCIYzJc3+Ytpe+a1DmxdWTaTPiyALyz8E3j+m2jHIG
         ZDNVoNMo55CAqk+7yJKfarYJ0iJjzSrgE/kNA=
Received: by 10.151.87.10 with SMTP id p10mr995729ybl.101.1286318020351; Tue,
 05 Oct 2010 15:33:40 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 5 Oct 2010 15:33:20 -0700 (PDT)
In-Reply-To: <20101005213401.GA22845@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158256>

Heya,

On Tue, Oct 5, 2010 at 23:34, Jeff King <peff@peff.net> wrote:
> +ifndef NO_PERL
> +all:: perl/perl.mak
> +endif
> +

Regardless of whether that fixes the problem that looks like a sane
patch, so maybe we just should apply it?

-- 
Cheers,

Sverre Rabbelier
