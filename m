From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/2] [submodule] handle multibyte characters in name
Date: Wed, 12 Jun 2013 21:41:11 -0400
Message-ID: <CABURp0psXnq9XFux1X9W11jdc7JJZU=87pFHMSfuigYz58Exqw@mail.gmail.com>
References: <1370991854-1414-1-git-send-email-iveqy@iveqy.com> <1370991854-1414-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <jens.lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jun 13 03:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmwXl-00068g-BO
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 03:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab3FMBld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 21:41:33 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41580 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab3FMBld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 21:41:33 -0400
Received: by mail-vb0-f46.google.com with SMTP id 10so6460856vbe.19
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 18:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+HrKNHsSaTAk/cb4d9bzVGuJxa7JADfZpNcs5dyuIwE=;
        b=NVK8aVnUrULvDL3Dpf/TtDFt4mxTEdsKF+o2OK9WBvyGuOTqwDQUPYD7FBZJVD6M+w
         M/6yla+8V7vb+1mvz3dylWZURmvrIw+/KX4RX4BHEK2mmP/PVZ98fnRUHZgK2b6OfZjq
         5Yo3k8DkHcDfj0o/0Q6FukI6sQBVYZeORFgOsxb+RhTuneAnxfxLRZrw+lM0OkeksZWt
         ih1wH5q1+jfVl7UyIAKZQVL/ty4cc048Oic+Zhjy8JsZeHs0L/pRRy56UA2+yOsGmlV4
         EzBiGl9HhGLyTlIX7OFc/7/XJ/ulAgZSPcg6Ys6iY6Pz6m52kUZbPupI6IowSp6AayNj
         dG1Q==
X-Received: by 10.52.165.36 with SMTP id yv4mr9213181vdb.31.1371087692078;
 Wed, 12 Jun 2013 18:41:32 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Wed, 12 Jun 2013 18:41:11 -0700 (PDT)
In-Reply-To: <1370991854-1414-2-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227693>

On Tue, Jun 11, 2013 at 7:04 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Bugg reported here:
> http://thread.gmane.org/gmane.comp.version-control.git/218922/focus=226791
>
> Note that newline (\n) is still not supported and will not be until the
> sh-script is replaced by something in an other language. This however
> let us to use mostly all other strange characters.

Please explain the commit better so the reader can understand what the
commit does and why.  I can see what's going on by reading the commit
and the original thread, but I should not have to.

Thanks,
Phil
