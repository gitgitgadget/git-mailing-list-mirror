From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC Application [ Parallelism + Git.pm ]
Date: Wed, 21 Mar 2012 21:10:03 +0700
Message-ID: <CACsJy8AQEKfVKSOCRhGWb1FNT+onno5sB3QCuEdmpj4j2OWBGQ@mail.gmail.com>
References: <CAB3zAY1cbjmJvPQo2i38Vxv=1CTzcusvtBTPQehi30cYsDe1Zw@mail.gmail.com>
 <871uomt929.fsf@thomas.inf.ethz.ch> <CAB3zAY319iV5ogaAeumo5bXC5vkvq=x_-6E689+fN8yZ6jtg1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Subho Banerjee <subs.zero@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 15:10:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAMFQ-0006jA-Pg
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 15:10:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449Ab2CUOKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Mar 2012 10:10:36 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:45185 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030302Ab2CUOKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2012 10:10:34 -0400
Received: by wibhr17 with SMTP id hr17so5709422wib.1
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 07:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yzmkT77tt9mq+3h7ZmDnYoBWY/ciJE6SLqVvv1Orbsw=;
        b=sb/ODNjtcvOdGyZXz+zi068/8BYSxmtoyrPBzk9WsfArSc5TZNm+KTBMpZjADyNOhg
         fBug26lZLqsQtNZWAicyQN+eIjevjFf9LGGWFaiuuHoKc4sls3oQ2ms3ptiLK7/Lbdrn
         9y53bJsxTQF0uR+dKMi9rBPSuaUyLcq1vjdZVdLfHvysSEXw0ceuTXEUwvsZUjq/Y3PD
         3vUtpbx0OdN2yw6MU9vLe/iK54aaBesINKYALDJkqsNEzA0cMfxJqt4JrzjxzynFN/Kp
         GsLzOSwxdYrHtYcwfh8cUq9EllKGDVkl2g/hMyG5EutBza79OdOysw7kc3/JKN96d5ij
         280Q==
Received: by 10.180.107.101 with SMTP id hb5mr2846966wib.7.1332339033689; Wed,
 21 Mar 2012 07:10:33 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Wed, 21 Mar 2012 07:10:03 -0700 (PDT)
In-Reply-To: <CAB3zAY319iV5ogaAeumo5bXC5vkvq=x_-6E689+fN8yZ6jtg1w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193579>

On Wed, Mar 21, 2012 at 8:53 PM, Subho Banerjee <subs.zero@gmail.com> wrote:
> Hello,
> Thanks for the links. Those really helped.
> This threading that will have to be done, will this have to platform
> independent, for example will it be used in windows without cygwin?

Yes. We simulate a subset of pthreads API for Windows in
compat/win32/pthread.[ch]. Stick to those functions and you are fine
(or add some more, of course).
-- 
Duy
