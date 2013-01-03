From: John Szakmeister <john@szakmeister.net>
Subject: Re: Pretty pictures of git merge conflicts
Date: Thu, 3 Jan 2013 18:53:34 -0500
Message-ID: <CAEBDL5VDX0BBjORX6EyZ7_4dUU7W1L2u-LqWE4RA0ZW6n5cpFw@mail.gmail.com>
References: <50E5B3BE.7080500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 04 00:59:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqugw-0006td-3J
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 00:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab3ACX7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 18:59:00 -0500
Received: from mail-qc0-f171.google.com ([209.85.216.171]:39134 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005Ab3ACX66 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 18:58:58 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Jan 2013 18:58:58 EST
Received: by mail-qc0-f171.google.com with SMTP id d1so8357039qca.16
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 15:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=/LvCfu8SB6ufYDcbLOsnS4rfQFHpsOVI+h1PZFg4FAY=;
        b=YXHAokvTcee/V3ZbU+3fj+0Id9tJDu3JtMWYrX9hsEFiYK09s5XE0s1rF7S8WB/GlH
         c6cg1be2+ZEBMqkc4LhYLjFyiNhQXjEkS3g0m3kGzhenV7AQgCYtTqOVCmZInBsbPmDu
         dNIzH1QUWdXhAowH4V9bKnu0Vnt9okGcEqqR4TJJlVSm3GL6/qDE4wEpxNKY24TIVptW
         slU7Q+NtaOTKUomQEObYzUIo8SWP+iNWBMG+GmU/DURf74xqIJCVCbPgxWbraQoCiO28
         Lv4Bi1Mt5a7oyEb1woTJmMkxD7CLeFbHGw9o7e1WXe+veeJN0bi1FQom7fmmZJNviHRk
         gx4A==
Received: by 10.224.117.84 with SMTP id p20mr29514918qaq.18.1357257214964;
 Thu, 03 Jan 2013 15:53:34 -0800 (PST)
Received: by 10.49.14.42 with HTTP; Thu, 3 Jan 2013 15:53:34 -0800 (PST)
In-Reply-To: <50E5B3BE.7080500@alum.mit.edu>
X-Google-Sender-Auth: 4ICs0E8PiU6dIPL-WUhX6gkpwyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212621>

On Thu, Jan 3, 2013 at 11:37 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Hi,
>
> I've been thinking lately about how to attack difficult git merge
> conflicts.  The first step is to visualize them.  I have written some
> articles [1,2,3] describing a way to atomize a complicated merge and
> efficiently compute diagrams that show which pairwise commits cause the
> merge to go awry.  I hope you find them interesting; feedback would be
> very welcome.
>
> I am working on some more articles (including software) that I plan to
> grow into tools to help users perform git merges that would otherwise
> seem hopeless.

Interesting work Michael!  Interestingly, I've taken such an approach
in a few real life situations.  It was a real help it trying to get
the conflicts resolved, so I'm eager to see the tools you come up
with!

-John
