From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 22:11:08 -0400
Message-ID: <76718490807201911j11bd4b3k914cec91485f9e0e@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <alpine.DEB.1.00.0807171940160.8986@racer>
	 <48806897.1080404@fastmail.fm>
	 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
	 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
	 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
	 <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
	 <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness>
	 <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com>
	 <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	Tarmigan <tarmigan+git@gmail.com>, git@vger.kernel.org,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 04:12:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKksl-0006Dv-J3
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 04:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568AbYGUCLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 22:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758557AbYGUCLK
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 22:11:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:32661 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758565AbYGUCLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 22:11:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so423994ywe.1
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Xy8Zg1yN3lmcsyEVnCwUkJ7yhOai2qS1pVfqlgN9ESQ=;
        b=qIyQEzHAdnw8fPAY8axdnPgNTe3pUucQdENRq7ZMfHh7vup8fdek6KO17pVLB8tI41
         FT3SndUFyy9NnJprDG09O74g2QHkqa2TMqwj1Fps68JHhZq2J26mBlYNNIT2zaTyA6Zk
         pANo2F1p2JXiiO57XWlMcRTeggmR89mcFcwv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=svS2wLGY0yDSJaWI70EJtzAdhRsPR9NgV4Np2YsQNb67Ur9NGj+3j1YtBiF6Znkree
         tT23RIfXNgAPASjPuVZ6dW/6ClBzlEgHvWqPiySlvIMhv9X+9fccU1O/WDPnBDypIASs
         dO/x2ym+JzYP6GvC/T6ZYfhbtQCsi5/fTN5AY=
Received: by 10.150.54.6 with SMTP id c6mr3165389yba.226.1216606268843;
        Sun, 20 Jul 2008 19:11:08 -0700 (PDT)
Received: by 10.150.149.15 with HTTP; Sun, 20 Jul 2008 19:11:08 -0700 (PDT)
In-Reply-To: <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89295>

On Sun, Jul 20, 2008 at 2:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I do not understand either of you.  If for whatever reason "add -A" makes
> sense in your workflow, it's a sign that you are extremely disciplined
> that changes in your working tree at one point of time where you would
> issue "add -A" are concentrated on a single topic, and at one of such
> points you may want to commit.  For such a disciplined person, "commit -a"
> would make perfect sense there.
>
> So for such people who would find "add -A" useful, "commit -a" will not be
> "unrelated changes in the same commit".  And for such people, I would even
> say "commit -A" would be even more useful, too.

Hah, it's Sunday and my brain wasn't awake. You're right, "commit -a"
complements when I'd use "add -a" -- namely, when I have a branch that
is tracking a non-git source: either files I'm rsyncing from another
VCS or drops I'm getting as tarballs. (I'm aware of import-tars.perl.)

j.
