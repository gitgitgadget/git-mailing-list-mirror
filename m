From: Chris Rorvick <chris@rorvick.com>
Subject: Re: git push tags
Date: Fri, 26 Oct 2012 09:23:08 -0500
Message-ID: <CAEUsAPaqqDsFndFXfrf3Fxvp+_eHtkRkyX_HUkAEPF=PSBNvWA@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
	<CAB9Jk9A95YrrtH8ue-CJ6Mqe9Z+3nfo=tjurLZjmecfiMFijvg@mail.gmail.com>
	<CAM9Z-nkosbe1NXYnu7x6v4seLqCnMBWg-jrdH2eJ9RetaZBTyQ@mail.gmail.com>
	<CAB9Jk9ApdbN+4Yk-6+u4Nje9+tbESSGGVj95iof1jnfG4Ga7GA@mail.gmail.com>
	<CAM9Z-n=+YeF3BaF-5UB5f2GBHYw7WDZEFDVT72RGSsDBaH4PJA@mail.gmail.com>
	<CAEUsAPZC80aSwnS0sBTt9nEu0HgyPp0BD2TWjSBb7tS7=i=VhQ@mail.gmail.com>
	<CAM9Z-nnrFxhX7XxBqe4qfuqZigpD12CrN2W6d=L996rJ_ecWFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 16:23:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRkol-0006lx-5R
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 16:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933246Ab2JZOXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 10:23:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:39687 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043Ab2JZOXK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 10:23:10 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1718363lbo.19
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=vEn+nq7/nJb2yn+V6X2r45SCltk3wlsXJswrD5BWhks=;
        b=btRQ20P/YVzNIgvhdyJWsY0PnAcaodO+VSKPltoLXKTdf+cp9pTinnBhSkEMoqLOcL
         Q+8FjRZdhy2Fzfi7kEOKwnvBm90GsEZ9wqvY5q8Yp33VZs8qU3ZYwuVghz5qhORKqMj0
         VMWy4Xf4yu3Ew7oRtcmyrReAEu4k/dqB6atSi+iT8juZNebaWwF2w1v7Zgb1I/6wrSoP
         sm5OBP3tEPs6+zkmQf9Zy2KKiDKjWBot7jPlVUwMVqKkiMsMmgplk4Hoj0JdQrXKGE6L
         8E/++S96s0zutiXRSltN3Y13Mwqptz1tAuiQaL+ytYKam/x1MM5IB6pCmmwXOK1c7uoD
         N4gQ==
Received: by 10.152.103.18 with SMTP id fs18mr20582611lab.32.1351261388268;
 Fri, 26 Oct 2012 07:23:08 -0700 (PDT)
Received: by 10.114.2.45 with HTTP; Fri, 26 Oct 2012 07:23:08 -0700 (PDT)
In-Reply-To: <CAM9Z-nnrFxhX7XxBqe4qfuqZigpD12CrN2W6d=L996rJ_ecWFQ@mail.gmail.com>
X-Google-Sender-Auth: uWJHEjo0QEqDqEmvLJ4iSwYcA1M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208452>

On Fri, Oct 26, 2012 at 9:13 AM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Fri, Oct 26, 2012 at 9:59 AM, Chris Rorvick <chris@rorvick.com> wrote:
>> On Fri, Oct 26, 2012 at 8:37 AM, Drew Northup <n1xim.email@gmail.com> wrote:
>>> (As for deleting the current branch, you can't really do that on a
>>> proper bare remote anyway as there is no such thing as a "current
>>> branch" in that context.)
>>
>> Really?  When I clone a bare repository I see a HEAD, and Git doesn't
>> want me to delete it with a push from a remote repo.  So is this not a
>> "proper" bare repository?
>
> Chris,
> If there's no working directory in the remote repository is there a
> "current branch" in the _remote_ repository?

Yes, I believe it is the default branch when the repository is cloned.
