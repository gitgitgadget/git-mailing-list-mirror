From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Found possible branch point, then "Use of uninitialized value $u
 in substitution/concatenation"
Date: Sat, 7 May 2016 09:07:18 +0200
Message-ID: <CAP8UFD2dH+nDdpiURK=MePz-JiOOcv3V=NJWjdMYo--oyNZ04g@mail.gmail.com>
References: <CALZdSA_pDy=B-bgB-vjpi1yjgtse_-07ewXSX0_GsYhLfOUbzw@mail.gmail.com>
	<CAP8UFD0k0Kx306S3y-Kd5328j0MDNL+ewCJvXbsJ1nzsJYRdtg@mail.gmail.com>
	<CALZdSA_eF--tdDAPwEfopioB+X=n7Xti-ixGNJqEwvDdCwo2pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Thierry Suzanne <thierry@yellownemo.com>
X-From: git-owner@vger.kernel.org Sat May 07 09:07:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aywKm-000166-JE
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 09:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbcEGHHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 03:07:21 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:35480 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbcEGHHU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 03:07:20 -0400
Received: by mail-wm0-f54.google.com with SMTP id e201so80067463wme.0
        for <git@vger.kernel.org>; Sat, 07 May 2016 00:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=5wMQOksg6VtL16rrgkr/DJ5CcLM1LePDXSfyNMKDRgc=;
        b=z2noX5/7Ja7bbYrDrH66bYPoeXLEK82q/EUlu2ifuJvfeCAGeb3x+ChoJnpGWe425L
         Q1/rV4puvpKmu1l6I8XcF/NwH2S0IWoOf8It7Mr9irhBmfPZRA3JfH18YBjCWP4WxSJO
         B1XBIjU2O3XbTRAks82/KuP1y5hV4E397aXeIqc7b1cfY20HSoxWHmKD85JKrchOTg9e
         sFQUeyIJ6uUWocKhpv6ZOGp1VBHcbbn/45ppGvSZYZc9v8M1qk4vkhy8rmB/4aEuSXBO
         TSjvlbcrVmST4cbFvVg0Ve7gOj1zNvZVHIxur1oSySEHaYoQgGBnhQ/xyzjFIa5rl6SE
         d3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5wMQOksg6VtL16rrgkr/DJ5CcLM1LePDXSfyNMKDRgc=;
        b=kKfxxvLZFAhqlaoLQYgZ2NhnukVL6azyebBuf1pN280m2BYehPE50mcleUDnWWEeNy
         cLu3tyHFPR8uI36qVIVDq4WdOiOdDZtLC8j8gemqWUJAyIk8kuZALMOPqB0mBfCXsKNX
         AEOD0DRfxsae0fm6MzzlDvp7SI3EcZO1r737y0ARcnaiCFv/9dCB07OXLHctwTS4Qx7F
         mVC3DAOPE86BP+n0hjQf7isjlDrkCX+PhWNbuBM+bWipVUfjq4YXgv3R3GXa3MwFIKKv
         DTspmf/kJSXmo4YEgGxbmWL6KHa6A4obpcbgutiBSCYhcZF0+tHLghS+pAMyNSZzli44
         /rlg==
X-Gm-Message-State: AOPr4FXvZWQi+X8paRiRWldJGnDrQKpUQ0GJ8CtgQP5VaQ9vVzf4H2kK3XnCwaTVyeV/y6QgHPX13ruuH2AvwA==
X-Received: by 10.194.20.162 with SMTP id o2mr23329071wje.78.1462604838934;
 Sat, 07 May 2016 00:07:18 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sat, 7 May 2016 00:07:18 -0700 (PDT)
In-Reply-To: <CALZdSA_eF--tdDAPwEfopioB+X=n7Xti-ixGNJqEwvDdCwo2pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293887>

On Fri, May 6, 2016 at 5:31 PM, Thierry Suzanne <thierry@yellownemo.com> wrote:
> Sorry, can't help :(

I just sent a patch. It would be nice if you could test it to confirm
that you get a nicer error message.

Also please reply below other people's comments, as customary on this list.
