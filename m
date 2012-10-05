From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Ignore on commit
Date: Fri, 5 Oct 2012 11:00:01 +1000
Message-ID: <CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
 <506DEC50.7090402@obry.net> <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: pascal@obry.net, git@vger.kernel.org
To: Marco Craveiro <marco.craveiro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 03:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJwN0-00037c-Mj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 03:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400Ab2JEBAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 21:00:23 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46555 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab2JEBAX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 21:00:23 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so5122375wib.1
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kcdb/fb+RjC+s/nR5son2XpBpsSSbKjSPneSJljML08=;
        b=mANKM+Vds2EtdVpdeR+/xZsGD5fGNm2fVDinPAglGOF5TJZNxp3A7XSrtIEPRrNmQE
         oDpf8VUja+E20ZjG4hTHVCw+dx+GJltxP3+QY+6fSQmGglLLgpKMAfYd1yK2hOK+dEFo
         ilavcB/cT8l7ZtQn4Uj/WnEMFaG9U/gezrOOYnsh4xsy7dQFbljD+Jv44e/ot0XEfOZP
         MhEM+bocr70wwB9EjLZf0h8e+H/vopotcFTuBFK0RnMc6gXK+m3/foXqb9CMrWxTyuyw
         P1vHv1wFLTfQcE68A979UpeFM5BIgu+c5E/1uJVMIKldFhYMzT34y/0PM32quIlOkwVw
         181A==
Received: by 10.216.201.156 with SMTP id b28mr4414728weo.4.1349398821706; Thu,
 04 Oct 2012 18:00:21 -0700 (PDT)
Received: by 10.216.231.169 with HTTP; Thu, 4 Oct 2012 18:00:01 -0700 (PDT)
In-Reply-To: <CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207060>

On 5 October 2012 07:20, Marco Craveiro <marco.craveiro@gmail.com> wrote:
> ...
> Similar but not quite; the idea is that you know that there is some
> code (I'm just talking about files here, so lets ignore hunks for the
> moment) which is normally checked in but for a period of time you want
> it ignored. So you don't want it git ignored but at the same time you
> don't want to see these files in the list of modified files.

What is the reason git ignore is no good in this case? Is it simply
that you can't see the ignored files in git status, or is it that
adding and removing entries to .gitignore is too cumbersome? If it's
the latter you could probably put together a simple shell wrapper to
automate the task, as otherwise it seems like git ignore does what you
need.

Regards,

Andrew Ardill
