From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: 1.7.10.3 configure does not generate Makefiles
Date: Wed, 30 May 2012 13:38:19 +0200
Message-ID: <CABPQNSZaNeu7n36_v_Xe26WHqtXNQWWXiPVutvVM7hk+q5S_-Q@mail.gmail.com>
References: <20120529233238.GC3072@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: jupiter.hce@gmail.com
X-From: git-owner@vger.kernel.org Wed May 30 13:39:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZhF2-00018u-IW
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab2E3LjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:39:00 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51011 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab2E3Li7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:38:59 -0400
Received: by pbbrp8 with SMTP id rp8so7344828pbb.19
        for <git@vger.kernel.org>; Wed, 30 May 2012 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EivpQtjClAbc8yKqrAtTLoc2imfmEYGrQNc/hGQyVsY=;
        b=H8RP6wI+ULxupyKfLKI2+0T2XirHgmSnULnFW8BUu7tewzG1S41TZDE73l9b/pFrpC
         tjZMeQddRcUdiwuVdrZY3M9uZFoppYn3lTj+u2pt7VfaR/l87MsobxalETJ9KftNPjyu
         IIjv4hmnrE74k6R3VyNuNCuSgBZG/Ddypo7jodVLATH5Q9PiN5obzjSV1uiIQrSx80Df
         sO+lN/pKlLaCvxl9711bz7tO/9yg87aXy73khz+lneTeU+PYgtPBoRYb+UXPjZ1da3Hq
         7hiMYy9uI4+e+mFlDd0ZcTmvhri+HRpgJ6kZInZg1NAf5D7HfckbEjLDhSGw9n/+IOgY
         lqcA==
Received: by 10.68.132.166 with SMTP id ov6mr49970173pbb.24.1338377939183;
 Wed, 30 May 2012 04:38:59 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Wed, 30 May 2012 04:38:19 -0700 (PDT)
In-Reply-To: <20120529233238.GC3072@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198804>

On Wed, May 30, 2012 at 1:32 AM,  <jupiter.hce@gmail.com> wrote:
> Hi,
>
> I've just downloaded 1.7.10.3 source tarball and following the
> instruction from INSTALL, I ran the autoconf to generate the
> configure, then to run configure --prefix=/usr/local/git/1.7.10.3.
> There were no errors but there was no Makefiles generated either. How
> can I run the configure to generate Makefiles?
>
> .......
> configure: creating ./config.status
> config.status: creating config.mak.autogen
>

This is as expected. Git doesn't use Automake, only Autoconf. So all
it generates is a config.mak.autogen, which gets included by the
Makefile which is already present on the top-level.
