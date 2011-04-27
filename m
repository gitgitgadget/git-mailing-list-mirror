From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Wed, 27 Apr 2011 11:18:36 +0200
Message-ID: <BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 11:18:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0tQ-0003Wt-DA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 11:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755626Ab1D0JSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 05:18:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46343 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755561Ab1D0JSi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 05:18:38 -0400
Received: by bwz15 with SMTP id 15so1207738bwz.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=H1zY89eqJwI32BvV6TtA4dbLak4+qZizg0kLBQ3A7Vs=;
        b=VFppnCab79oyKHp+MgUWU+xlGvUsy/UPq06GVSUzKqD3ZXfHk2+/HH1HroDH2tCWp6
         3C+jTuuFmU6hbvmfypnkNFyse1/VzDKjzzJ/ugD04f8KD02V2HgctNRkziWHyMGKONML
         9rmBKOn0HHl8MAiuXYqirnyAth+T3ZTcvqmuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sD3RvxahL2M2WOXrPvRpcDzQ8nortphE4ZfC0O1QOX1W99eWvDaCxTPJ+anffRVCsW
         ct82srI4QJF1YmJsIrsZGOoQVSNwYCFLLunOLlEn08151ngpRArKiJrfqELvM2ZmIoDb
         lELg9i8/Mi1OQkFVirzbJmu6jp3zRZNEDd60Y=
Received: by 10.204.20.79 with SMTP id e15mr1754163bkb.147.1303895916955; Wed,
 27 Apr 2011 02:18:36 -0700 (PDT)
Received: by 10.204.120.195 with HTTP; Wed, 27 Apr 2011 02:18:36 -0700 (PDT)
In-Reply-To: <BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172205>

On Tue, Apr 26, 2011 at 8:18 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Apr 26, 2011 at 3:09 PM, Stephen Kelly <steveire@gmail.com> wrote:
>> Can git have a bug tracker please?
>
> So that you would feel comfortable that there would be a bug report
> gathering dust? Or that it's closed as invalid for lack of
> information?

If you believe that it is a foregone conclusion that that is the fate
of all bug trackers, and that that's a reasonable reason for git not
to have one, then you have had very different experiences to me.

I don't think there's more I can say than that.

>
>> This is another reminder to fix this bug which is otherwise untrackable.
>
> Let's imagine you are posting this to bugzilla: first question?
> How do you reproduce this?

My initial mail illustrated the problem as best I could:

http://thread.gmane.org/gmane.comp.kde.devel.pim/29534

>
> But I already asked you this[1], and you didn't reply. What should one
> assume but that you don't care enough to help get this fixed.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/165320

Someone else replied. Isn't that enough?

Other git developers confirmed it's probably an issue. Isn't that enough?

http://thread.gmane.org/gmane.comp.kde.devel.pim/29534/focus=165326

Anyway, we've had a work around in place since January. From the git
POV, this just falls through the cracks. Consider the bug marked as
can not reproduce/needs info/whatever you prefer. I'm outie.

Steve.
