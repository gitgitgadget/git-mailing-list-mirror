From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 5/5] log: Add --use-mailmap option
Date: Wed, 12 Dec 2012 12:58:59 +0100
Message-ID: <CALWbr2xmRVS9m623yrxY88Ftaen_B8Tb2vd+VxhYV1ceAmbDSg@mail.gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
	<1355264493-8298-6-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rich Midwinter <rich.midwinter@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 12:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiky6-0003UP-W5
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 12:59:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab2LLL7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 06:59:00 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38842 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab2LLL7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 06:59:00 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so642877qad.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 03:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kRvgRi+ycqm6rOatxR3u78LuHVpxQqqKoYkj8P41ID0=;
        b=G6/0MNHmcvCUX4tkbgHTszXUYybMN+5RTKsqXKIWKBKiuyiR0QdD587dly1Kt+j4Pi
         JYeZpSHqRMsPnub2RV7aKOfnJ5p9gwReUIw1ttEPNcAjnpPzzfB/y48z4tCGnY4Rv4Wp
         UMYOqFWs1HbZxmW6GdEYAVOqDRTzC88HsU7tKLM2QPD+hV1wgo/br4Zr0QgaH9TcRk32
         DJElyl1nv1cjbHejwgczCUol0QlA2QnhtNL83j1+sE84dNmkXD8SotpbW4zyTmnKjMuJ
         vwgVKTsZOTYqJJw/Ty4oVHCtFW/dnrwqO3xWwb3dkaW7Z2zPbx5Xytby9GorOVagiZgz
         1niA==
Received: by 10.224.185.138 with SMTP id co10mr1321622qab.97.1355313539362;
 Wed, 12 Dec 2012 03:58:59 -0800 (PST)
Received: by 10.49.11.233 with HTTP; Wed, 12 Dec 2012 03:58:59 -0800 (PST)
In-Reply-To: <1355264493-8298-6-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211346>

On Tue, Dec 11, 2012 at 11:21 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> Add the --use-mailmap option to log commands. It allows
> to display names from mailmap file when displaying logs,
> whatever the format used.

The question is which log commands actually ?
Shouldn't we put the option in revision.c::handle_revision_opt instead ?
My opinion is that it belongs to 'Commit Formatting'.
It would also make sense to be able to use '--use-mailmap' when running
format-patch for example.

Also, I've noticed that my series break some tests (linked with
format-patch BTW).
I fixed that and re-ran all tests successfully. I will resubmit it later.
