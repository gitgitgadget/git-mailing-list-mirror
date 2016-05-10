From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 19:57:41 +0700
Message-ID: <CACsJy8Bra1bzUkG8u_btR67fBUAckJyL29S8kr-kcd_3x76v-Q@mail.gmail.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com> <1462832134.24478.49.camel@twopensource.com>
 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com> <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
 <1462835573.24478.53.camel@twopensource.com> <CACsJy8CN_KzoFaROAksSuT1-sJgxP6zd2iJbqq-Dqq6EQyD_Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 14:58:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b07Ev-0001iQ-MF
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 14:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbcEJM6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 08:58:14 -0400
Received: from mail-lf0-f53.google.com ([209.85.215.53]:32928 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbcEJM6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 08:58:13 -0400
Received: by mail-lf0-f53.google.com with SMTP id y84so13876354lfc.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bpYnp7Pzcvo2231O53SixJglEfgEw54ndQ0y0Wet4Vc=;
        b=fpjIUv271aj78wZmkDgtbmyHwpgzI1tu5uVtMoou+4Fv+kuJ7TiHGhpWlW+akcXCu6
         95KpvT+a3/Z0k3EPm/sg+gPYn9QiktN4nakW2s6z7wbsUusYcdXUCuyFlOC6BzGJ62rJ
         ETlkxr7InZ17mT3eVWR/Cwl53j2T7flSkUUTEM7J6Jme/tqfDUjfiNdVAZbRpZu2R9w7
         CAvMHgc+MMPqsgI36Evn8cC3b8fiFizjFo7st8rapstY3lBQHoA7QhzAsQphjIHOikrM
         3KMNagHgbJIx+YE8Ef0jw8NzvT6dg8BZvrjifBPafAxr1rlD5SSojrducgTCJ7B8/3c9
         QOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bpYnp7Pzcvo2231O53SixJglEfgEw54ndQ0y0Wet4Vc=;
        b=btKv1KRRilhhglpngwfHTEnHqGCSEb5zZgiujjul4pxs7NW+caTl1yHL2wTMy7j8p1
         mR6IDCIMdNTu+Ky+nvGLrZTA537kJihDyxiGmebs+C9QBnYsuyQMjp/iEIa5b+7cquBr
         zsvPhdztAv+Dg6DNskLiEbVA3hvxnpNYA4lTOjPo8d19iFpxQICQT9cGJAC6/6oUbcu+
         aa4zBPwlb9VIV+sKyPuze0P1qMVFQGwd2/fHf5/YCFHnnEd2l7wHHsLpcP/b7r/VZ9rD
         JWF/B63F5Rr3gL0VzC9jI20cjlX65F+5TfvbdcX+VV3YHZ1cvBXEk3GSWYebWdpaJKE8
         oWdA==
X-Gm-Message-State: AOPr4FX9IS3GZkj5qlbEfFswJs3XwIRZa88Osn/Rb+gZqgidTi4e3dX44L7AuZtaxWV2yynpmoH3Onh0P0bM4A==
X-Received: by 10.112.181.72 with SMTP id du8mr16768001lbc.137.1462885091573;
 Tue, 10 May 2016 05:58:11 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 10 May 2016 05:57:41 -0700 (PDT)
In-Reply-To: <CACsJy8CN_KzoFaROAksSuT1-sJgxP6zd2iJbqq-Dqq6EQyD_Vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294128>

On Tue, May 10, 2016 at 7:45 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> If --detach is used, log_warning() can't cover die(),
> warning() or error(), most importantly die() for example because of
> bugs.

A case for redirecting warning() is because watchman-support.c uses
it. But because this file is only used by index-helper, you have
another option, simply convert it to using log_warning().
-- 
Duy
