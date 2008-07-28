From: "Eric Raible" <raible@gmail.com>
Subject: Re: gitk crashes when quitting gitk while it is is reading commits (was Re: gitk crashing on Windows.)
Date: Mon, 28 Jul 2008 13:31:22 -0700
Message-ID: <279b37b20807281331t46866e92s72b0c5a6311cf2db@mail.gmail.com>
References: <g6kmqf$q9p$1@ger.gmane.org>
	 <loom.20080728T162025-946@post.gmane.org>
	 <E7C7B8BA-6050-40DE-917C-200EAE9CA6E8@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, paulus@samba.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZOK-0006wJ-Qr
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYG1UbY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbYG1UbY
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:31:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:12991 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbYG1UbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:31:23 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1479290ywe.1
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 13:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pUA/4Qmz70/0/6gS0vruepxbHPHuqTCVDalqw+2BftA=;
        b=LQaEd6lyyPM3sWohF1OVuR4CziCqu+XHGOZAifS4R2Imba881elQdu+U5bJ336kUP2
         ZBFDQ0UdzIzJZyGen0P+9OGeP4EdpOBj05euVV56hOpocM11tABWHt0SQkdeC32GfSAS
         k80NBIem2BKq3GloHPhb1IzTb861B9YBNy6sE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=M+WNehj2n5oUSLAR4eeEXmT3U9v0k41aKM57GqnsfvymbKj4Z3aTl9+rvhASKUKmHY
         FbwSt4yI/ugSOcEmgCbw5Bbwh/PC06fgvJbVwiMXbnxElj17LdAW/yGJ8Wpasr5z/Gt+
         KMI2wVH4hTK0mYjFv3avbTRJDBTkSSvg/QE2Y=
Received: by 10.142.139.19 with SMTP id m19mr1753506wfd.154.1217277082062;
        Mon, 28 Jul 2008 13:31:22 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Mon, 28 Jul 2008 13:31:22 -0700 (PDT)
In-Reply-To: <E7C7B8BA-6050-40DE-917C-200EAE9CA6E8@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90502>

On Mon, Jul 28, 2008 at 12:18 PM, Steffen Prohaska <prohaska@zib.de> wrote:

> I don't think so.  The error Jurko reported might be the same error
> that was reported earlier and filed as issue 125:
>
> http://code.google.com/p/msysgit/issues/detail?id=125

I agree - sounds the same.

> I don't think the problem is Windows-specific.  At least on Mac I am
> seeing similar problems.  When I hit CTRL-q while gitk is still reading
> the commits, it crashes with as segfault.
>
>        Steffen

I also agree that it easily could be a generic problem.
But the fact remains that it used to reliably crash on me,
and no longer does with more recent source.

But I still can't find a relevant commit, which makes me
feel like I'm a) still a complete git newbie, or b) imagining
the whole thing.

- Eric
