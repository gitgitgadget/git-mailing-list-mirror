From: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH v2 4/7] i18n: builtin/pull.c: mark strings for translation
Date: Fri, 29 Apr 2016 08:57:50 +0200
Message-ID: <572305EE.8040704@gmail.com>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
 <1460234324-13506-4-git-send-email-vascomalmeida@sapo.pt>
 <xmqqinzptkaw.fsf@gitster.mtv.corp.google.com> <570B7FCD.5050809@sapo.pt>
 <CACsJy8BsxZTChST8Gb25LT1HwwR1AcAthjfOQmoAjxkF4qzvBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 08:57:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw2NB-0004fJ-Pj
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 08:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbcD2G5y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 02:57:54 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33730 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbcD2G5x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 02:57:53 -0400
Received: by mail-wm0-f42.google.com with SMTP id g17so8495149wme.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XyuX7NU9k7Kd+Mx163/42YcBs8dyqEaB9pnrfO822zY=;
        b=f1zQI6xs/yLNlspYerH+Hyw1OXsdxym96080P8SJ8vUo3EgaWjFB6a5AwKGDhlFIFn
         81dKN/UVdznnhOlwkLBIFpYGyFaC5DKW1zLL60NSyeLMsucaV+QU9p+5lX4FEyNNkxj/
         6CqcRukbuIzj8cViXL0JPZ8KQ9rOzl3f0YVWKVReNnbo2/DWdGF1Q4gEt8xQx1QYtqBf
         pRddlOb/irkBwxty9G7c+g8wnw7oAqMNGU82p1cHlWdxiaPzubfk5jHt4/7cNgWDATRi
         0fpk1AYys1MuXidXWS1qnSPiAONIVI1eSiMAu0IMQIgDFj8Uyr/Pgj5z4gemtNscrz82
         VSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=XyuX7NU9k7Kd+Mx163/42YcBs8dyqEaB9pnrfO822zY=;
        b=hrdb1JTovzZMwAd2lgYYWoOG0Bwg5Z3UW9uagDvX69PIAzUY0x1xrgQrqmb40i6Mq/
         /uOj+9L77X2nDKiXey9fVjVNmUARElXB7M9nPbVHdGn8gCeTGkVFHjLcdsQHBxLsMz4W
         cLUMPfxXzO4otsbrBNbUHmD/q2eTMwaRaUtbCm3k0IL5xLXt1/4fpHgfcGXBCR+pNtRm
         n+PYDHgFFXhAqK6JEEQNwqvnDX0IaV/eBLV13380XNDdMTqSttLZMSl23viw1QMLBZ4D
         DxKG4mLZgymlgLBp1eTe+4bOzn8p1fZLVreuJtR7ErTQTlUY0vdv6iJNhSBNHwkfB/Zy
         OR6A==
X-Gm-Message-State: AOPr4FV2rINPRRWGrOgnBX0WJ5RHl8Ti1xbo3NhkWB34RASwSooveEqP1jDP5TtBH13Mcw==
X-Received: by 10.28.104.131 with SMTP id d125mr1858538wmc.99.1461913072001;
        Thu, 28 Apr 2016 23:57:52 -0700 (PDT)
Received: from [192.168.1.75] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by smtp.googlemail.com with ESMTPSA id gr4sm13202752wjd.23.2016.04.28.23.57.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Apr 2016 23:57:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <CACsJy8BsxZTChST8Gb25LT1HwwR1AcAthjfOQmoAjxkF4qzvBw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292973>

Le 12/04/2016 11:52, Duy Nguyen a =C3=A9crit :
>
> Ex-translator speaking. Context is important. If it's me, I would eve=
n
> go as far as marking the whole line translatable just to give more
> context (it's mostly just copy and translate a few words then). But
> then again, I was half developer half translator and may see things a
> bit differently. Maybe _("<remote>") is a good balance.

I second this opinion. Translating a single word without context is
generally not advised. The english word might come up in different
situations with different grammatical forms for the translated version.

Adding the brackets provides enough context, as long as the string is
always used in the same semantic field, describing the command line. I
just don't know how much that helps reducing the amount of translated
strings.


JN
