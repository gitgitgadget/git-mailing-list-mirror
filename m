From: Stefan Beller <sbeller@google.com>
Subject: Re: Improving Readability of the entire Codebase
Date: Fri, 1 May 2015 08:35:51 -0700
Message-ID: <CAGZ79kbORH6S5Cq03tRU0eHdu75QF1phZFiDsyiFQ+sg_2V83g@mail.gmail.com>
References: <CAKB+oNv1q=62a0-T7CCcOAOU+sfXPiyZPMB1qWxf-8zX=4PPpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Alangi Derick <alangiderick@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 17:36:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCyr-00017s-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753823AbbEAPfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 11:35:52 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37493 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbbEAPfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:35:52 -0400
Received: by igblo3 with SMTP id lo3so40157972igb.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EMe14cXqM2g/5I+xP+rtEimUk1bX4DtMWQp7XXjdHy0=;
        b=AjMiW/KYFVctlcCEv0WR57cJp+ew/fdY7bYpcL0/pAPq5qGh+lHhPXHgHyOI+e8Nvk
         ysWnUzS0PTUjmN9S2y5bHe9ZgjwksOawkKxzuDaRLoI5m2mtL/YtcoPF8oeAXtDYvNhA
         b0nPvShXk4DDJNTw+RUm79tKjR2awVD7eV5kc9C69JqMVzvUoAp3Wh9hbghpnKA2D69u
         8jIiHXaJBfKTLHBtCPly7/hct/l4HURddKKlGwTOB3EvNzk2Fp+0AZRqbAOmHI7ccdrC
         DztMVf7tMabobgBtFEppWR6IH+bTKKJBg0pbhhpC7dvYpNoeYAFT4j4mFyU8FCZ54WzQ
         LH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EMe14cXqM2g/5I+xP+rtEimUk1bX4DtMWQp7XXjdHy0=;
        b=B57Y8pTVMx+byl+OcJV1Yf+Q8PbHDU1gvSolEZqK/cuV/DudJMTw8jMIaD5eEi9TrY
         Iphk/0rdNnvvHM/GkHvef95TeaCcSrfXp5G5zrO3pNZRLin9D2P6tYYsKzT5ZagYoSJJ
         XkzBF2YOqpMamsG8lEjQuNTcvijJAtHdygm9VTxTjCiwlsrTgxMmKfknIVSbK2t0XYGS
         I81bI7mp26+RQaiEMOzX4oVNaNjh5EkHrXeJSjA798OOo2i6uUw2/wVJEmQtKGDzwfwj
         74MKUSMo2f4g/ghyaNTTwc7FbKgaV59tlXDdTP+G3A7fbhvTSsqSKsHTOMMJfW/1OXlX
         jocg==
X-Gm-Message-State: ALoCoQkItFUJGzlyf5iN06m2X5QFbFeTnYHfEv+/i6kzl/JwJQwrqSeXrxrR0H4QC5p8Zd9XiLYE
X-Received: by 10.42.188.19 with SMTP id cy19mr15662997icb.92.1430494551333;
 Fri, 01 May 2015 08:35:51 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Fri, 1 May 2015 08:35:51 -0700 (PDT)
In-Reply-To: <CAKB+oNv1q=62a0-T7CCcOAOU+sfXPiyZPMB1qWxf-8zX=4PPpg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268147>

On Fri, May 1, 2015 at 8:08 AM, Alangi Derick <alangiderick@gmail.com> wrote:
> Hello,
>     While reading the source codes of Git, i found something. Some
> sentences and words are not in their correct cases. For example like
> starting a sentence with a lower case whereas it should be in upper
> case. I want to go through the entire code base and correct the cases
> of these letters to improve on readability. I will also use this
> opportunity to learn the source codes and familiarize myself with the
> code base.

> If its a nice idea, someone should please give me the go
> ahead. I will be waiting.

That's usually the wrong approach within the Git community as
there are no people who give the go ahead.
Just do it and once you have some results these
can be discussed on the mailing list.

>
> Regards
> Alangi Derick Ndimnain
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
