From: Doug Kelly <dougk.ff7@gmail.com>
Subject: Re: submodule.$name.url is ignored during submodule update
Date: Thu, 19 Mar 2015 08:09:22 -0500
Message-ID: <CAEtYS8TM6KWEjpcOLL8qRmN1yEo4JGQLLJCkkQ+GHaX7F-aLJA@mail.gmail.com>
References: <CAC+L6n1RjvzcqX33VDvcM-4CpQPHeaddA7Dhs9S+ma+T+DN28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Dmitry Neverov <dmitry.neverov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 14:09:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYaCX-0006G4-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 14:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751394AbbCSNJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 09:09:24 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35356 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbbCSNJY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 09:09:24 -0400
Received: by labjg1 with SMTP id jg1so61578404lab.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 06:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PlaYatSEC6SG5ysr8t5SoQ04a9fkNRn1jq8UGa18gos=;
        b=MouGCmFHKQnzS+R9QCUuzOCv+WsdqxAB9Mb2FrkCFN9yVcJW7+Uu9240b+aPV4yDAo
         j6yB0Mf92CaAaaxnsgyQ4D6xHj3UVNP7FeqWYbJv7S/foytEt1MWwXT1w49KqLk5bwSt
         bc078GKSpfS60qEcqVarD8lNMisJOwGQ4ggTKSHkujG5Chxtb/ngRz6GTZvfX+N/msUY
         wQrMmB6ztgKR5ik/ilK/JNBgF0vs/A0j1h5O2hYNvX+fjTeyu4MCIUL0FXAGdV4iPvry
         Fh5IX/9VSyGqLyjmKk/DpwXmMt/VU9bD9YYst8rEdb/j7eqAdzj8CJB4XVvhVkouVIi0
         8eww==
X-Received: by 10.112.146.70 with SMTP id ta6mr46255257lbb.59.1426770562266;
 Thu, 19 Mar 2015 06:09:22 -0700 (PDT)
Received: by 10.25.81.145 with HTTP; Thu, 19 Mar 2015 06:09:22 -0700 (PDT)
In-Reply-To: <CAC+L6n1RjvzcqX33VDvcM-4CpQPHeaddA7Dhs9S+ma+T+DN28Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265801>

On Thu, Mar 19, 2015 at 4:27 AM, Dmitry Neverov
<dmitry.neverov@gmail.com> wrote:
> Hi,
>
> I've noticed that the 'submodule.$name.url' config parameter from the
> main repository is ignored when a submodule needs to be updated, the
> submodule's 'remote.origin.url' is used instead. Is there any way to
> customize the submodule url for both the initial clone and for
> updates?

That's what "git submodule sync" is for. It will synchronize the url
in .gitmodules with
to the remote.origin.url for each submodule.  I'm not sure about the second part
of your question: are you talking about using different URLs for the
initial clone
and updates?
