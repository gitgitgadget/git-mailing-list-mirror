From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] completion: correct completion for format-patch
Date: Sun, 2 Jun 2013 22:59:57 +0530
Message-ID: <CALkWK0=x3pTPwAkcj-FU6KwZcyxbxB4Ou0TpxKmrxUH7fG0UGA@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-5-git-send-email-artagnon@gmail.com> <CAMP44s16s3Uz6ybjYuqni9JdDX0XvG7F3z7F1cyNS2k=AqrkKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 02 19:30:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjC7H-0007UN-Cn
	for gcvg-git-2@plane.gmane.org; Sun, 02 Jun 2013 19:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab3FBRao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Jun 2013 13:30:44 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35856 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab3FBRai (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jun 2013 13:30:38 -0400
Received: by mail-ie0-f176.google.com with SMTP id at20so8161024iec.35
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/bdXJu8ktPzl+Ak8R/oc2jJT+tshXXArE36IIok7uEM=;
        b=nQz3P7JqYp0gaw0CgA1C51skYVwDkd8Auu7xTYIr03BJEk1zqXXm/JAs6aF5/6fomt
         PMbSDzkZA9RrS9C3wX6YOxSf2hiwYsU1RxQivHIuPZMXg9XUwV+1ZIiDgVss93pjIlPT
         COYxoF3ikwwA7j0OCPseumC0MXVRZ1dFP8XumaGtveoALywtriIPNv1Vm9KaOB/L4lHt
         TpI59saYX/QbKwx79115JELX+ZprVmYwkGWg0HaabEPtDgDsIj1n52D6BlrA9o+j13K2
         AwbRTcNdVn7qn/YwlCo3Ggb3KPoOZogEVGoojIoAaEJfJrVqdytp+b4MnXVCGswkUeOo
         5zXw==
X-Received: by 10.42.31.69 with SMTP id y5mr8790983icc.44.1370194237799; Sun,
 02 Jun 2013 10:30:37 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Sun, 2 Jun 2013 10:29:57 -0700 (PDT)
In-Reply-To: <CAMP44s16s3Uz6ybjYuqni9JdDX0XvG7F3z7F1cyNS2k=AqrkKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226169>

Felipe Contreras wrote:
> This breaks 'git format-patch master..<TAB>'.

Oh, ouch.

> Moreover, this is a perfectly fine usage of 'git format-patch':
>
> % git format-patch --full-diff master..fc/remote/hg-next --
> contrib/remote-helpers/git-remote-bzr

Never mind then.  Drop this patch.
