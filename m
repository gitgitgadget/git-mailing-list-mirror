From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Fri, 29 Jun 2012 11:10:31 +0200
Message-ID: <CAD77+gSKsU6T8P6dQeZofkh3jhrKbW3yVy1XqJ0J_K-bDt-H8A@mail.gmail.com>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 29 11:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkXE8-0001Ik-Fj
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jun 2012 11:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188Ab2F2JKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jun 2012 05:10:53 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39140 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2F2JKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2012 05:10:52 -0400
Received: by yenl2 with SMTP id l2so2485489yen.19
        for <git@vger.kernel.org>; Fri, 29 Jun 2012 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4RhKjID7FOxNVyttghRKeOYTmmcrpdYHw4sxSqIdBa8=;
        b=JE6gUfV5xYSJU55ED2ahIJOolslS3NYrQuoaEB8Z8k9Nhky+z86e+ODRwsCwXuB9SJ
         jqMAw/3eEBAh6rvvAenGGlAkxgVi68T0ULb8ZS7W+fJ2HwDGZYyPUtHYpY1kv6vlttjh
         s7+06HVTZWxG4WkSvDIdwtJyjj1yyyN8gyd1ct1izfYFW6RpB7DBSCVltylOICy3AYlC
         sA588d16UrajqbM/YtWeLQZ0Pn+OVO5yRavnQ7xOoOab2EgEi8E9xDEux915iyjIE0TU
         MOgLT+T7ffa6b1WvuMvzD9CE1kA8AISqevsS55FHSgBteXQWv+oGrIGpMjlYR1EJ5YHm
         nt3A==
Received: by 10.50.212.70 with SMTP id ni6mr468959igc.30.1340961051339; Fri,
 29 Jun 2012 02:10:51 -0700 (PDT)
Received: by 10.50.135.97 with HTTP; Fri, 29 Jun 2012 02:10:31 -0700 (PDT)
In-Reply-To: <4FE9FF0C.8050409@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200812>

On Tue, Jun 26, 2012 at 8:27 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:

> Richard, could you please tell us what git commands behave strange
> in what way and what your expectations were?

A real-life example can be found at:

  https://gist.github.com/2992239

lines 354 in the second and 353 in the third paste block.


> As far as I can see all submodule code consistently clears all
> environment variables used by git before descending into a
> submodule (at least since February 2010 and 5ce9086dd). Maybe we
> should change that so it sets the GIT_WORK_TREE environment to
> "$GIT_WORK_TREE/submodule" to be consistent?

>From how I understand the problem, this would solve it.

-- 
Richard
