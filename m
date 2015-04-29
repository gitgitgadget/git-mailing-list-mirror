From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v9 3/5] cat-file: teach cat-file a '--allow-unknown-type' option
Date: Wed, 29 Apr 2015 10:53:13 -0400
Message-ID: <CABURp0qCe3aLtnwueh8Jm6Hm-AN1--Dk1NV4Y=oA5XhMsLh1Aw@mail.gmail.com>
References: <5540D397.8020104@gmail.com> <1430312006-23323-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 16:53:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnTMp-0007mX-3W
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 16:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423302AbbD2Oxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 10:53:35 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33932 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423013AbbD2Oxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 10:53:34 -0400
Received: by iedfl3 with SMTP id fl3so49498918ied.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i2LWOo8zRSiq7GEcbW1YCAnFI7TFRg39mNDjujDHcNo=;
        b=uJHbI/vtps3Fm9laBI4uYoifgasXTgv4qWDaovosw4uuRptPvZfjAsCrmajP+k+8AE
         6uvAbkk/Yi3jiWC9gw+DTc/NMzB4wBzPuLcuE3IJYeQKtVINaQuZAXrcsBBzS1PWBC/O
         /VKYAsL1EP8O71H6GnO7xrLypKjNM2KFWY6jtNtVDExsGpkfXtR9mXltGLRmHy3z1IHL
         7C2l+mOCoF5G87VLN7O4QH7f3qZLrY3PTb3vs/fSBo9WUPymc+FZ8+P6p28jMbk5+4Wp
         tXL1I/YmD14xfxZK3AgPFsl02ZCcbLKqFuR9b/ZpB7XO1O/98F62ghzDuf/whI2slNLi
         pm7A==
X-Received: by 10.42.185.12 with SMTP id cm12mr4108800icb.0.1430319213652;
 Wed, 29 Apr 2015 07:53:33 -0700 (PDT)
Received: by 10.107.139.202 with HTTP; Wed, 29 Apr 2015 07:53:13 -0700 (PDT)
In-Reply-To: <1430312006-23323-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267969>

On Wed, Apr 29, 2015 at 9:01 AM Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Currently 'git cat-file' throws an error while trying to
> print the type or size of a broken/corrupt object. This is
> because these objects are usually of unknown types.
>
> Teach git cat-file a '--allow-unkown-type' option where it prints
> the type or size of a broken/corrupt object without throwing
> an error.

In this entire series, replace all 'unkown' with 'unknown' in both the
commit messages and the code ("unknown" is misspelled most of the
time).  I notice the switch name itself is misspelled, but also
variable names such as 'unkown_type' in this patch.

Respectfully, because I know English is a challenging beast sometimes,
and spelling is difficult even for many native speakers...
