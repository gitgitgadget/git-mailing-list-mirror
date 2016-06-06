From: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: Re: [PATCH] completion: complete --move for git branch
Date: Mon, 6 Jun 2016 19:19:00 +0300
Message-ID: <CABr9L5AK5KhFvAW4dah3Hji_VStgYKesnD+Ljari7ihJX8Y7fg@mail.gmail.com>
References: <1465218971-14118-1-git-send-email-ville.skytta@iki.fi> <582640631.360243.1465222588996.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 18:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9xFi-0008Tk-5j
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 18:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbcFFQTX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 12:19:23 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35450 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbcFFQTW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 12:19:22 -0400
Received: by mail-wm0-f48.google.com with SMTP id c74so53909636wme.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 09:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wb7p4oCK3xxLe2yjhzt9X8bAD3Xqz9xVh8HxMJywkA8=;
        b=ujUOT7Dmk8s3CQSoJx2l1P/BbIp4nnRaCW2VbwEu3lGBhG4HDKx/3t8UaVSxQ5UZlc
         WzHgkDNvBQAz2B4ND2dIw6QqISghwzJvqL+H5/YM4GQlv1BLv1gNGpr1DmUnGrM/c2KK
         UV5PI55r1/eJQKh9VoGN/iSPvKH8LaZ4fda3HNJb4pT68d58NCXl09NAZeWp4E5IH5mG
         QbwBb02XRgbiyfnAU9gzo1FqtdU1V/jrqZ0VcDEVT/hmohgPSFJ8RiNIN+PbQw2n9Sm3
         L6pHfQLpZo4fcNmaSumQdwt3jdVBQ5ngkvh8GssrG/UOFIsv9LqucLRLLg2kxvXE2qny
         JMyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wb7p4oCK3xxLe2yjhzt9X8bAD3Xqz9xVh8HxMJywkA8=;
        b=DeE7CmXB3ef93R4aoXzG6ErGColAB53bQYoR7WGc+Bh+kcNRBPABkdIr86abGCLmnq
         t0oS3zqTj6rfeTpQ+0EmQyKXNvGcKUIIV60CsmTih6ZoJzRgABJETqyVburOkjp4+gKn
         Ui+Gi2kJaZTSGfiVH0fbw1H0g/9/oSHdUsdqdoUpuozbdIVU67fUIPOVCT3ITDwZNw46
         mwpgfMG27RCOjKYMV1a+kKa3QsI04xDeYqpH7hMhMbyl81qk2+SiTcfrD4h23O/LPuLx
         ewOJX+rjSdY8J3C12RopbRK+xI2gZbuATCTZNHrHPWlzgaXuuy9Jzhn0vEbr7cQREFeA
         KpTA==
X-Gm-Message-State: ALyK8tJaSOKnFrvOJAUoA3xUvWJnf43DlBVNmYCnfqcIphA47gvFc1BWdsHLoWYimB7zJP9bA8YSdNhJxa9HcA==
X-Received: by 10.194.79.69 with SMTP id h5mr17882569wjx.129.1465229960021;
 Mon, 06 Jun 2016 09:19:20 -0700 (PDT)
Received: by 10.194.9.195 with HTTP; Mon, 6 Jun 2016 09:19:00 -0700 (PDT)
In-Reply-To: <582640631.360243.1465222588996.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: jFQnzX_jUFKfi7ae-80FxfXAlP4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296527>

On Mon, Jun 6, 2016 at 5:16 PM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
>
> Hi,
>
> Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
> >          while [ $c -lt $cword ]; do
> >                  i=3D"${words[c]}"
> >                  case "$i" in
> > -                -d|-m)        only_local_ref=3D"y" ;;
> > -                -r)        has_r=3D"y" ;;
> > +                -d|-m|--move)        only_local_ref=3D"y" ;;
>
> "While you're at it" you might want to do the same thing for
> `--delete`.

I'm afraid the "while I'm at it" would never end if I start looking
deeper into missing things there, so I'd prefer this self contained
one I keep running into myself applied first.

> > +                -r)                has_r=3D"y" ;;
>
> You are introducing an additional tab here that you probably didn't
> want.

It was intentionally added it to keep "only_local_ref" and "has_r"
tab-aligned the way they already were.
