From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] completion: make compatible with zsh
Date: Sun, 15 Aug 2010 21:43:39 -0400
Message-ID: <AANLkTinoPRPqxPrzNHF5J595r_Oedy=LSPZNYdMhB+OD@mail.gmail.com>
References: <AANLkTimknF-m4_TYt+-vBBW0e3A-DY1nY93k7mPybdaD@mail.gmail.com>
 <1281757237-32656-1-git-send-email-lodatom@gmail.com> <20100814212507.GD2372@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 03:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkokC-00044Y-Uz
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 03:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121Ab0HPBoE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 21:44:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47232 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0HPBoC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 21:44:02 -0400
Received: by qwh6 with SMTP id 6so4505767qwh.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 18:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NWfK85KgZoNbSagGIxwJxI6LtpJ2zzQ7Lmzv4txY3yo=;
        b=sbH2ILYL4Dmp8+YwXHS67cy6iyAt8HcyVYQ67iddaXGksInaYLr0Va3v4efgyo+Nwz
         bwuWi4gmcNt4PCc2PTpnjCYsPtCtqOhGeNmR1G57PG2RKbO4WZlDvXA9/KXLFs60w1dV
         jQUPCiINiV9oWdiNnbqD5pI0x0WYNT6yIAlQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rIUXNlnRT1bOzv4HsLibf1p5IIzBliItn4pQxlnwk+dJ4MlBNiC/hq9SQd1ZUoFgSe
         JJLwmst2pfn4BlhjEYPyj5zBrOzAWccjhzzrwhxPrBvEhYPfcGaayV7FLCAGN/yO/VEa
         zQfCXM3+7USfT/KqWRViuN5++gBISXhwQpDTw=
Received: by 10.224.69.17 with SMTP id x17mr2851306qai.283.1281923039172; Sun,
 15 Aug 2010 18:43:59 -0700 (PDT)
Received: by 10.229.72.139 with HTTP; Sun, 15 Aug 2010 18:43:39 -0700 (PDT)
In-Reply-To: <20100814212507.GD2372@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153642>

[original email was sent only to me]

On Sat, Aug 14, 2010 at 5:25 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Mark Lodato wrote:
>
>> ${var:2}
>> =C2=A0 =C2=A0 Zsh uses $var[3,-1] to trim the first two characters. =
=C2=A0There is no
>> =C2=A0 =C2=A0 way to write cross-shell code to accomplish this, so w=
e must wrap
>> =C2=A0 =C2=A0 this in a check for zsh.
>
> Maybe
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0${var#??}

Good idea.  I'll include this in the next version of the patch.
