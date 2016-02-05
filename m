From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 8/8] one ugly test to verify basic functionality
Date: Fri, 5 Feb 2016 20:02:18 +0700
Message-ID: <CACsJy8C2+kaPLALojJoFe+T=WoeyQ8JsB0zenDzQt3wpi9D=tw@mail.gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
 <1454662677-15137-9-git-send-email-pclouds@gmail.com> <CA+EOSBnZVuHThXLg9+VftPVaKy5wqqxp=iQtP1ZUtxkKq32HMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 14:02:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRg2I-0007Lz-Mq
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 14:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbcBENCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 08:02:50 -0500
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34050 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbcBENCt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 08:02:49 -0500
Received: by mail-lb0-f177.google.com with SMTP id cw1so49075386lbb.1
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zqmS7v2O/dZGQvgyH/m8d0XGUEeqrLSNCeO9wOtJ7tE=;
        b=b3k2GtFhtUT5RtY3EIg4DYKgu/YwqWTVAGFn1Urw0WMcFJHJQgqlUK6EiKGrDbsY/h
         +St30DFT2ufjbmQZFixG/ldxaIe9jDhRxdzqYTbQxUWQkRNrUY3qaHaYeKUd8O0AiZHU
         yp/8JF/9Bq7EJdizhmdpRLP8dW7+MMoObIl8phfd7+6XiUcxdvBFFwiqfmdFRRHW1g+K
         FwvRzyiTT005+ZYe6Fx/Zdyl1OKX5lbJSBkfnD5XS8kOp5pwJeG7B2SmkiZtxGLuN0+1
         1gYLTXxIoRLSdoM7OF2h3z7050DSn9TpD8weoYb4jewdBZC1Alzf0seLRmCDyOmNCT77
         MOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=zqmS7v2O/dZGQvgyH/m8d0XGUEeqrLSNCeO9wOtJ7tE=;
        b=dHVS9qooMDpUkNCOV2j6wD5jw5pAh8H4iI9EkZNEnegfaOdyZtOKSmfF2CseemlQqI
         u/Gz9Hu76N0LOARl8jIKsSOkIZ6WZnnpsYKdwNGqO7APXNo7q+cEiOPQhQp5Opclcton
         TEhWT18SBo1ugwA4eELF6UkBD9eIG+WHhwuhODesnAthXvH/5GdCiMwbBA76TpDnTcrS
         vVze9fmekq/xJ0f3OMmcWLoF87s2BAI6WtWz/ZTGZZhq5rulIE3XjgsBGa7vPsan+Y/z
         BdJ8MHRlAfH2x03ZcURf608USKFryJrAtCKunXtU7YQlX5cc2Fbsx/7HfvkutWatdLW8
         E0hg==
X-Gm-Message-State: AG10YOTNzYhhIBDk76n/doesRv11aPkt74oYVlgVCW1nvuD7so3UzLXQ5NbB7WrpNV5EQugpcS4ChVsITC72FQ==
X-Received: by 10.112.141.97 with SMTP id rn1mr6321020lbb.80.1454677368348;
 Fri, 05 Feb 2016 05:02:48 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 5 Feb 2016 05:02:18 -0800 (PST)
In-Reply-To: <CA+EOSBnZVuHThXLg9+VftPVaKy5wqqxp=iQtP1ZUtxkKq32HMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285575>

On Fri, Feb 5, 2016 at 6:57 PM, Elia Pinto <gitter.spiros@gmail.com> wrote:
>> +       mv `ls .git/objects/pack/*.pack` pack &&
>
> No, please. From the git coding guideline : "We prefer $( ... ) for
> command substitution; unlike ``, it properly nests.

I was being too subtle with the word "ugly". I assure you this test
cannot be merged in its current form.

But that's not important. It makes me think, can we catch `..`
automatically? I know the test suite can catch broken && command
sequence. Maybe we can do the same for`..`?

> It should have been the way Bourne spelled it from day one, but
> unfortunately isn't."
>
> http://stackoverflow.com/questions/4708549/whats-the-difference-between-command-and-command-in-shell-programming
-- 
Duy
