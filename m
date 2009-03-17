From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: fetch and pull
Date: Tue, 17 Mar 2009 12:21:28 -0400
Message-ID: <76718490903170921r36843c11y5aac537d53384298@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
	 <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com>
	 <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com>
	 <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:23:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljc4C-0006YR-Ar
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755770AbZCQQVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 12:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754384AbZCQQVb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:21:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:11288 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbZCQQVa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 12:21:30 -0400
Received: by rv-out-0506.google.com with SMTP id g37so70449rvb.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jU/9Ki2s+QT8bTQWUrgJIxtvBEtfFzgn52QyHEoCEE8=;
        b=jbHlbAKCMf5XAt8/64sVB6yWUVJzO7DIOknEfzRN9o/5oYOlmff4p62fPz+e3xC5MI
         W6s6VTeEeArc+l4WwM4ualXfY6I2MnnGQrdRPtQBvgtkxKuRawXPQ2ERiRkPaZHpfwgk
         EWq8osEW/kL//o3rCC2vcJvXdnl6vm/WSas+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fxO+2lAWLj4fKOkz7P4ng38zgR/IeEgVF9SOIN6qXYkJLonD+j1AGfXyQVPjngWQpi
         Fjbb6cfvAvB3fg0OKXQ0b9cnPutm1Gww+LwEncxBJUMgF0ZvmOA5gkyRHfdVlBRXBRrB
         d9fnVjatriPO0S6G+0uQTYeX/B27Xuy8Q+WX8=
Received: by 10.141.84.21 with SMTP id m21mr36500rvl.284.1237306888804; Tue, 
	17 Mar 2009 09:21:28 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113493>

On Tue, Mar 17, 2009 at 10:58 AM, John Dlugosz
<JDlugosz@tradestation.com> wrote:
>> $ git clone git://central/repo.git
>> $ cd repo
>> $ git checkout -b topic origin/master
>> $ edit, commit, edit, commit, looks good
>> $ git checkout master
>> $ git pull
>
> You checkout master before updating it?

You cannot merge/rebase a branch unless it is checked out.

> The developers may not non-ff the dev when they push it. =C2=A0But th=
e repository maintainer may reset dev for some reason, and since topic =
branches are pushed, he can see that it either doesn't bother anyone th=
at way or knows who to help out. =C2=A0But, it means that in general th=
e pull _could_ be arbitrary and not a ff from his last pull.
>
> For example, developer A checks in a finished topic, then B checks in=
 a finished topic. =C2=A0But A doesn't use a spell checker even though =
he *really* should, and doesn't proof read even though he **really** sh=
ould let a native English speaker look at it first. =C2=A0So the reposi=
tory maintainer rewrites the tip of the dev branch. =C2=A0Next morning,=
 everyone pulls, and both A and B are non-ff even though they have not =
branched anything from the old A or B.

We seem to not be understanding each other, and I apologize, but I
cannot invest any more time in this thread. Perhaps others better
understand what you are trying to do and can jump in.

j.
