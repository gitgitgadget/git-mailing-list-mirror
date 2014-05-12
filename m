From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Mon, 12 May 2014 17:21:42 -0500
Message-ID: <537149765d67b_377bc653042f@nysa.notmuch>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
 <xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
 <536a83097302f_76ff7a52ec6c@nysa.notmuch>
 <xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
 <536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
 <xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
 <536ad9601b73b_3caaa612ecdc@nysa.notmuch>
 <CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
 <xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
 <53712cd889ba9_2ea6e1f2f82f@nysa.notmuch>
 <xmqqzjimpw7x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 00:32:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjym3-0003Fi-HN
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 00:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaELWcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 18:32:39 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:42597 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaELWcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 18:32:39 -0400
Received: by mail-oa0-f52.google.com with SMTP id eb12so9006850oac.39
        for <git@vger.kernel.org>; Mon, 12 May 2014 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=z3e3j2nyonqNQkghrNuUYOcV5gXiOYfPTX4sZQSR5ec=;
        b=gSTscPlWXpHaLvl1dGNHO539F7T2rc7rcjK2MO8jhSBpwHBRYo9SmFjwd21cFRs2/M
         vyecZwDve/7NyIPzD+NM2sVgqK19ifwZJ7eUNCkbP63JIfgVUKVRois+xlpfAG4l3vjl
         /hL7XvPg0fyuv9sWc9KC6mxZ+IkLOwjjw29IzYs5ngwaB1oDYrX6tgJndgYI5HHeNz1O
         +ZYSY6Z2cG+A1LQKr7EycbE71q0giYOHGXeZfv2ei4HRfef/QNPfj7fT8XUGzQf6UJlL
         GAtItsoepJfH5lWW+LS7yX2Wb1xwtWihntt5qZDD3CtwHloJ3iIzIk0GuTf4i6XSXqeC
         KUhQ==
X-Received: by 10.182.120.5 with SMTP id ky5mr37128070obb.11.1399933958673;
        Mon, 12 May 2014 15:32:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zv18sm22544283obb.27.2014.05.12.15.32.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2014 15:32:37 -0700 (PDT)
In-Reply-To: <xmqqzjimpw7x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248736>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> > ...
> >> I was originally led to believe that its code quality was good
> >> enough, and that was why I merged the bottom three patches of the
> >> series even down to 'next' in the first place.  But after seeing the
> >> "Of course" response that led to [*1*], which made me recall many
> >> patch-review interactions with him, I have started to have doubts.
> >
> > This is bullshit, and a wrong direction fallacy.
> >
> > Event #1:
> > Junio rejects the graduation
> > http://article.gmane.org/gmane.comp.version-control.git/248263
> >
> > Event #2:
> > I give up improving remote helpers in git.git
> > http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248341
> >
> > Junio is trying to make you believe that his decision (#1) was caused by
> > something I did (#2). Don't fall into that trap, #2 happened *AFTER* #1,
> > it can't possibly be the cause.
> 
> I think you misunderstood.
> 
> I never said that I do not want it to graduate up (out is an option)
> based on code quality.

Fair enough, that was my understanding up until today.

> But because I was asked, I thought about it, and then answered
> honestly.  I do not know what a trap you perceive is about, and I am
> not interested in your responses.

Philippe Vaucher didn't ask about quality, he asked about moving out of
contrib.

-- 
Felipe Contreras
