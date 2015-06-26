From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: revise manpage
Date: Fri, 26 Jun 2015 14:44:14 +0200
Message-ID: <CAP8UFD1GwH1ewapraL6cms04OVk8wHdtv+TJ7=HKL0_CLGjK-g@mail.gmail.com>
References: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Nguy <thomasxnguy@gmail.com>,
	Valentin Duperray <valentinduperray@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jun 26 14:44:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8SzV-000559-H0
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 14:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbbFZMoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 08:44:17 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36759 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbbFZMoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 08:44:15 -0400
Received: by wguu7 with SMTP id u7so87562823wgu.3
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=t7et7gk+H5vq2PIdUHkWxb5+w1v/ROWbCN+yWZ+7YI4=;
        b=clemkj8a5JNYDXZSQzvnJfb0iDYQ/HZjON1VpXHepbFAUexm03Fik7PjjlRzoI09XB
         45YwN2s2X/r9nmbIywCLAplrZWrr9008esPlps9W/kSv/sUmGY+tlwWiTHXXPT8dbOpe
         MYWSyT4pRNpES0KxDKzL+/ISo1EPokFppgrMnW7RBI/UqVrodnjB/ndsI89QLC5iktQY
         TkxDWEhHe8NQPF5XYY1l80aAoz7otHEE1127JyPNrgWgpi8EMCyB8mkzWBwiF6mjkSnk
         6A8xGU/ikextztCvhy8RCD7+KATRF2qAXEiCwZDSomYL78DVw5X23wNAPziqyJ760dVZ
         BN6A==
X-Received: by 10.180.86.163 with SMTP id q3mr4603241wiz.75.1435322654500;
 Fri, 26 Jun 2015 05:44:14 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Fri, 26 Jun 2015 05:44:14 -0700 (PDT)
In-Reply-To: <12a2e2d5e545459837b5eb2356cfc2fe4e3ef631.1435317576.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272775>

On Fri, Jun 26, 2015 at 1:30 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

[...]

> +Eventually there will be no more revisions left to bisect, and the
> +command will print out a description of the first bad commit, and also
> +create a reference called `refs/bisect/bad` that points at that
> +commit.

This could be understood as meaning that `refs/bisect/bad` is created
only at the end of the bisection.

> -Eventually there will be no more revisions left to bisect, and you
> -will have been left with the first bad kernel revision in "refs/bisect/bad".

The original looks better to me in this regard.

Thanks,
Christian.
