From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: 'Theirs' merge between branches on a binary file.
Date: Mon, 22 Dec 2008 16:16:40 -0500
Message-ID: <c115fd3c0812221316y24ce0c7q29807cd349a99e83@mail.gmail.com>
References: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
	 <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:19:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEsA5-0003F2-QB
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 22:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240AbYLVVQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2008 16:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbYLVVQn
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Dec 2008 16:16:43 -0500
Received: from mail-gx0-f27.google.com ([209.85.217.27]:46244 "EHLO
	mail-gx0-f27.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbYLVVQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2008 16:16:42 -0500
Received: by gxk8 with SMTP id 8so1874489gxk.13
        for <git@vger.kernel.org>; Mon, 22 Dec 2008 13:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eHbZvV7MglaJbUQswphjuzk9uc+RFFNuQjk6Si5vemc=;
        b=D0WokwWLSEkO7of/zBjG+Lq3rxqwNK4Mp2k8yIz5q6Y4q/1KGn6wnkSuF6ecv8B14c
         JHWSHhfofe+jdGMFWJ8qlwL7lICVmtR1p7L3zOYBRTJp9dnm0ANxSh7ysRa38LuBUbA7
         TlxccDLC+WtY0LPaqmiaSiyufpkPBp7vTUETg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=JAuzXZcwFoJtiBlt+7AWG7YLstyRlAfKtdHL8dBf+XaYoE//n30Jyy3/TqjRDOCCA4
         dU6TOxpU1QF/49Oz8QQeQnOAYhxmiU4xW6wn4ZmrV3Qt5KwZSUgXu1D8x61ja3+gbS9q
         Y7g63mVbA1hvt7K/B1A1lmFc/DD76WTJPALgk=
Received: by 10.101.69.6 with SMTP id w6mr4104617ank.138.1229980600702;
        Mon, 22 Dec 2008 13:16:40 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Mon, 22 Dec 2008 13:16:40 -0800 (PST)
In-Reply-To: <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103773>

On Mon, Dec 22, 2008 at 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Do you mean during a conflicted merge resolution you would want to check
> their version out of the index and declare that it is the merge result?

Sure.  Let me try to be a bit clearer.

I was developing on a feature branch and now want to merge back into
the master branch.  Unfortunately, a binary file somewhat central to
the development effort was changed between the the feature branch and
the master branch and now there is a conflict.  Obviously, I can't fix
the conflict via markers or something like that because it's a binary
file, and I know that I want the feature branch's version of the file,
not the one that it is in conflict with.  How would I just select the
stage3 version of the file and add that to the index?

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
