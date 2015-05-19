From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Tue, 19 May 2015 14:29:55 -0500
Message-ID: <CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>
	<20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	<5547C961.7070909@web.de>
	<CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
	<37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
	<CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
	<20150518123036.GB16841@book.hvoigt.net>
	<CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
	<20150519104413.GA17458@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue May 19 21:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YunDF-0004S9-Lg
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 21:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbbEST35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 15:29:57 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38270 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbEST34 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 15:29:56 -0400
Received: by igcau1 with SMTP id au1so22510452igc.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 12:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dwdivlhFTB5j0eB+KuskcDPabacZrnaxPd/BJ8mOORI=;
        b=jPJg2+VyKZ4AUsnV66SYtVk9WozFav+Et9un3eUjGZX2YIeeJtzvPIX9eoUam61LFB
         TspVQXyJRmK7UmRbL8ijTqCWcNh1RCEGIsqJNPXOA3m7nZEMKdB0N1e1VT1gaitDIWfw
         hRPI+fOYZIR85eBou0JX2N55olEFKL6wLxciQcBSEiYKm6oAnbjsUXj38O2VXprCq0h7
         0utGCPnKlFOuzey4A8/T37buBmxmP9Q9Ga0vtbojCPJgTmFB+JIXemrvCpepaduB6WzI
         5NCY6qwz99osowsa1pLx99VXJ2I+KCPo1FAc2AQsP+u3dsisXUHjs8f1iVX/J35dTK0I
         pKoA==
X-Received: by 10.43.97.130 with SMTP id ck2mr42007092icc.91.1432063795468;
 Tue, 19 May 2015 12:29:55 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Tue, 19 May 2015 12:29:55 -0700 (PDT)
In-Reply-To: <20150519104413.GA17458@book.hvoigt.net>
X-Google-Sender-Auth: WOwFXkuSzvaLI1Rx2DcUQrNoPbI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269391>

On Tue, May 19, 2015 at 5:44 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Mon, May 18, 2015 at 10:06:32AM -0500, Robert Dailey wrote:
>> Unfortunately I find it unintuitive and counter productive to perform
>> inline patches or do anything on a mailing list. Especially on
>> Windows, it's a pain to setup git to effectively do this. Also I read
>> mailing lists through Gmail which does not offer a proper monospace
>> font view or syntax coloring to effectively review patches and
>> comments pertaining to them.
>
> Are you sure you are not overestimating the effort it takes to send
> patches inline? Once you've got your user agent correctly setup its just
> a matter of copy and paste instead of attaching the patch. On Windows I
> would probably use Thunderbird which has a section in the format-patch
> documentation how to configure it. Compared to the effort you probably
> spent on writing your patch isn't this bit of extra effort neglectable?
> And your patch is almost done. It just needs some tests and maybe a few
> rounds on the mailinglist after that.
>
>> Since I am not willing to properly follow your process, I will
>> withdraw my patch. However it is here if someone else wishes to take
>> it over. Really wish you guys used github's amazing features but I
>> understand that Linus has already made his decision in that matter.
>
> It not just Linus decision it is also a matter of many people are used
> to this workflow. AFAIR there have been many discussions and tries about
> using other tools. Email has many advantages which a webinterface does
> not provide. It is simply less effort that one person adjusts to this
> workflow instead of changing many peoples working workflow.
>
>> I'm sorry I couldn't be more agreeable on the matter. Thanks for the
>> time you spent reviewing my patch.
>
> If you are really this fixed in your workflow that would be too bad.

How do you send your patches inline? Do you use git send-email? I have
tried that and it is horrible to setup. Do you just copy/paste the
patch inline in your compose window?

It would be much simpler to fork Git, create a branch, make my change,
and initiate a pull request. I can get email notifications on comments
to my PR diff and address them with subsequent pushes to my branch
(which would also automatically update the code review). Turn around
times for collaborating on a change are much quicker via Github pull
requests.

I am willing to review the typical workflow for contributing via git
on mailing lists but I haven't seen any informative reading material
on this. I just find using command line to email patches and dealing
with other issues not worth the trouble. Lack of syntax highlighting,
lack of monospace font, the fact that I'm basically forced to install
mail client software just to contribute a single git patch.
