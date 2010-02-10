From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git rebase -i and the reflog
Date: Wed, 10 Feb 2010 23:26:39 +0100
Message-ID: <fabb9a1e1002101426p41cba90dw5b3d4afdfb157b5c@mail.gmail.com>
References: <fabb9a1e1002101419x40844a42s21108aaa849430c1@mail.gmail.com> 
	<7v3a183f3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:27:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfL1p-0004hH-OE
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676Ab0BJW1E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 17:27:04 -0500
Received: from mail-px0-f184.google.com ([209.85.216.184]:58261 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656Ab0BJW07 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 17:26:59 -0500
Received: by pxi14 with SMTP id 14so297455pxi.20
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 14:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=68VEO+IiEe2fy1PmQE88D/z4f8NNfxuqrrPORCxh44Q=;
        b=D6iiP081c58NLcESUwnM7u53IWc75unSrZOBvlIYvTfp5u8gWrU4mgLF/mNxFqJEEP
         y4e3Vs0invhpQf5iPoPissOKO7aBpkNP372ixZa+0s31ckwdrwCDlrEiKBDf7gKoCnIO
         SQK2Yv7ED009Lv9FhlLWXUxYrvf3Hd+avdi6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H4J8pZu5tYfslt8wy5BNJiKsx6hPrXgwWsehFTD4ltpDaAAG96/Q7ul2ugOyqWQmhM
         UGOQPYASi5hE88i0vrjPzfc2QECue0OenBd+u4w3iN4ZtNBTb9+H6CW1JstI5r9745hW
         /Q7JDYffqgkm2LE8ujIGbQsnLE+1c5sT4pig8=
Received: by 10.142.59.19 with SMTP id h19mr564796wfa.243.1265840819080; Wed, 
	10 Feb 2010 14:26:59 -0800 (PST)
In-Reply-To: <7v3a183f3q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139563>

Heya,

On Wed, Feb 10, 2010 at 23:23, Junio C Hamano <gitster@pobox.com> wrote=
:
> Yes and no. =A0I too suffer from it but only when I rebase a detached=
 HEAD
> state. =A0If you rebased a topic, "git diff topic@{1}" (or "git diff =
@{1}")
> would give you what you want.

Ah, mhh, so the reason I'm seeing this cruft is that I'm using 'HEAD@'
instead of 'topic@'. It only makes sense that HEAD's reflog includes
every commit, and a topic's reflog includes just that topics. Thanks
for the quick reply, this'll make my life a bunch easier :).

--=20
Cheers,

Sverre Rabbelier
