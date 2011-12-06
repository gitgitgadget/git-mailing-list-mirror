From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Suggestion on hashing
Date: Tue, 6 Dec 2011 11:46:38 +0700
Message-ID: <CACsJy8CM8xqWxTx14QbY+-bT=306p3U=6gJfRaW=dDD-Swo7-w@mail.gmail.com>
References: <1322813319.4340.109.camel@yos> <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
 <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bill Zaumen <bill.zaumen@gmail.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Chris West (Faux)" <faux@goeswhere.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 05:47:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXmvz-0004z3-NZ
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 05:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770Ab1LFErL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Dec 2011 23:47:11 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40318 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389Ab1LFErK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2011 23:47:10 -0500
Received: by eaak14 with SMTP id k14so4722020eaa.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 20:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=eYA7gFS69WXx+sue0b9sJ2c//7Z5E9Sl3TMh6TsVCtU=;
        b=S2YLL23f+XsGNLOVBc9YRsIaMwQHFv7pzlAqyADvdke1JFfDj/bnBQrgBmqIp5WlZ/
         WUm4CMvPIqWXQ9pq589ftWkYeKxJTZJgZ9UOk2EJ9MVivWQWBbZ1vveO4eoLnbE31ZJg
         btJy6tdvDFmO0p7bIGZUftg1V9fqbJyInfrfM=
Received: by 10.213.28.195 with SMTP id n3mr1073814ebc.122.1323146829196; Mon,
 05 Dec 2011 20:47:09 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Mon, 5 Dec 2011 20:46:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186311>

On Tue, Dec 6, 2011 at 8:56 AM, Chris West (Faux) <faux@goeswhere.com> =
wrote:
>
> Nguyen Thai Ngoc Duy wrote:
>>
>> SHA-1 charateristics (like 20 byte length) are hard coded everywhere
>> in git, it'd be a big audit.
>
>
> I was planning to look at this anyway. =C2=A0My branch[1] allows
> =C2=A0init/add/commit with SHA-256, SHA-512 and all the SHA-3 candida=
tes.

Great!

> log/fsck/etc. are all broken. =C2=A0Don't even dare try packs. =C2=A0=
=46ixing things
> =C2=A0is painful but not impossible. =C2=A0I'm not convinced the task=
 is even
> =C2=A0remotely insurmountable.

It would take more work, but after you're done with code changes, you
should have a look at updating the test suite. We have many SHA-1s
there. If the test suite passes, your job is (beautifully) done.
--=20
Duy
