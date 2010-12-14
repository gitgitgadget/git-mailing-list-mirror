From: Gavin Guo <tuffkidtt@gmail.com>
Subject: Re: duplicate commits after git rebase -i HEAD~10
Date: Wed, 15 Dec 2010 00:07:31 +0800
Message-ID: <AANLkTimSAjHOc42LOwkbFxqGEKrR0sOTcZB_mA2Ttj09@mail.gmail.com>
References: <AANLkTi=W9MyCuOuk49AtCxR7nTa5xkddY_2HkhOvQip-@mail.gmail.com>
	<20101203153435.GA6069@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Malaterre <mathieu.malaterre@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 17:08:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSXQ2-0000kz-4a
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 17:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759427Ab0LNQHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 11:07:42 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:60134 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759409Ab0LNQHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 11:07:41 -0500
Received: by bwz16 with SMTP id 16so966969bwz.4
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 08:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LjUEp9qx6JuD36RdAIG/PW4Ljp3sqs4TqDUzHzDGaDI=;
        b=TMgbm/DSgWxEPoXEbeuvTfqPuROBrhM/uLrq9wBUr1PcwcRpWYQFjpiiFLN5ivow9q
         cJP7vXfTwJxU7C2dOyvBJ6jfyvsjtOlqNI+2tFnqnSfjhJfHw3Zy9vNY7XnwYhQEgA/e
         Fyu8/TE6hopTjjHme4SvmAk3OobMZmKdX0nx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Daq8X2YOn7H9JJrMGhx4G4mf2T85+wLWeY0tOdDncJlkFWz5rtw6TXB1z0KgaeR0HO
         Dd6rj8e5bLVK7Oq9cLIzMGOe0ga4il9malVSmHewixpZ3KCxh1MzSdJnJOlMSSs/FYLv
         ZKSnsIlEHn8WnaNr2s834PVZdiKYppjXx3zWE=
Received: by 10.204.52.138 with SMTP id i10mr125017bkg.23.1292342851279; Tue,
 14 Dec 2010 08:07:31 -0800 (PST)
Received: by 10.204.70.79 with HTTP; Tue, 14 Dec 2010 08:07:31 -0800 (PST)
In-Reply-To: <20101203153435.GA6069@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163656>

The first one:

> =A0git checkout master
> =A0git reset --hard HEAD^
> =A0git merge your-branch

The second:

> =A0git checkout tmp-branch M^
> =A0git merge your-branch
> =A0git rebase --onto tmp-branch M master
> =A0git branch -d tmp-branch

I don't exactly know what the difference between the two methods to
solve the duplicate problem. Why if there is already a built under
master need to use the second solution? It seems the same to me to
solve the problem.

Gavin Guo
