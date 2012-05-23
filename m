From: Alexey Pelykh <alexey.pelykh@gmail.com>
Subject: Re: Question about submodules and absolute paths
Date: Wed, 23 May 2012 08:39:49 +0300
Message-ID: <CAOmKuSqeW==dfdengmOrzaTWr+uqN9ysvm8MEHS1BB8mnYUA3Q@mail.gmail.com>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
	<CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
	<7vk4043wc5.fsf@alter.siamese.dyndns.org>
	<CAOmKuSrmxnHKaip2X87Y0Cp=XtLAtpAwUp71QhZ5od3gbDF2sg@mail.gmail.com>
	<4FBC774E.5000500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 23 07:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SX4Id-0001qv-MC
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 07:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120Ab2EWFjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 01:39:51 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:51810 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab2EWFju (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 01:39:50 -0400
Received: by vbbff1 with SMTP id ff1so4344694vbb.19
        for <git@vger.kernel.org>; Tue, 22 May 2012 22:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Et3b+UgNzYmfE76IFFYyyjQk/73buo8vr2WxVmYdGEI=;
        b=kKjoVdcE93a3lk/7xwGgQZmxYQGPiDuaiXKPsk0GIbUu6PzuPef2rMxbzeEWfygSRn
         h3NpYW1OQLc6hX5bDkefABYMK7oGhRpJnzk46+KnzAzcKewhU5E744ia1uC/4NQVJnSX
         Hx4VouiNslH25i0UymjOIRoNxXLnIw79hzv5fvp+k9p5I5axA17yhyFJh7ASqUY8odas
         uNswW1TIiSM7CIcu8WmhYlCJSwZKk/YPBlPJQipfGQWBZG1Xx+huyyxr6BR+FPjqCQZl
         55E7PyjhhA3ELrf0u8SIjcZLNDGrMLAzyLAUsy+n/7G78wlMl0NRfY21CUneMjGLqscl
         pKzg==
Received: by 10.220.222.13 with SMTP id ie13mr2175897vcb.52.1337751589709;
 Tue, 22 May 2012 22:39:49 -0700 (PDT)
Received: by 10.221.13.201 with HTTP; Tue, 22 May 2012 22:39:49 -0700 (PDT)
In-Reply-To: <4FBC774E.5000500@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198273>

Thanks for pointing this
I haven't experienced issue with this. Maybe due to my git on Windows
is actually part of cygwin? Or maybe git status is 99% is what I do
before any operation with git :)

On Wed, May 23, 2012 at 8:36 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>
> Am 5/22/2012 21:18, schrieb Alexey Pelykh:
> > Not on two machines, on single machine but with two OSes
> > Windows + Linux + shared 'work' partition :) So both Windows and Linux
> > use same repo clone that is stored on a 'work' partition. But due to
> > those absolute paths, it gives '/cygdrive/d/work' on windows and
> > '/media/work' on linux. Thus I have to keep 2 copies of each
> > repository that uses submodules (and that is very inconvenient :( )
>
> I think you cannot share the index file between OSes. Even though its file
> format should be portable, the contents (stat information) is not
> portable. After you boot into a different OS, you need at least a 'git
> status' call to populate the index with the stat data from the new OS.
>
> -- Hannes
