From: Zenaan Harkness <zen@freedbms.net>
Subject: Re: False positives in git diff-index
Date: Tue, 4 Jan 2011 22:47:51 +1100
Message-ID: <AANLkTi=Po7zA1YG-VdN6cZEV+ZF3GYNM9W9CLVXFaE5Z@mail.gmail.com>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com> <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 12:48:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa5NM-000348-1T
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 12:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322Ab1ADLsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 06:48:23 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:60055 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab1ADLsW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 06:48:22 -0500
Received: by bwz15 with SMTP id 15so14473789bwz.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 03:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=/IhUpAreA/+ysvSCSV7eTN1l8GyZnYiquZPLfMcBaWI=;
        b=fNez+wmmwu5MWakrvsZE08X6z8wZcczk22hEB4vYUbd5Q0ZZM1ay6iH+iEo8B/BLc3
         Q9Qu/dA3YmTz49clLabhtqfmdmmGfnw49I+Sikv7XUAiI1EBCUGbQk8so9AZLFV1owwL
         BATdPfi/r7gQ7OWBL+fZCWZK5jDIWJAT8iRhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=T5XuvkyoePYn833c1XIHwRjMBnTDS5eO7o1fKect1RudW0QpEj0Q2ZQyG1sOOl8dHq
         a9EchN/0oAcMjCX1Bmr6uHC/I9ggvOGDcPD2+67WECqLyEIZG1kJZoz3nCgvjwmL0HKq
         8L0dUnRjrU9k+qc+R2ihxn8mSsm7rLstOvVfs=
Received: by 10.204.59.132 with SMTP id l4mr2917964bkh.160.1294141701382; Tue,
 04 Jan 2011 03:48:21 -0800 (PST)
Received: by 10.204.112.210 with HTTP; Tue, 4 Jan 2011 03:47:51 -0800 (PST)
In-Reply-To: <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
X-Google-Sender-Auth: vNRwslE_jQnheOEjYkiuQCUFgFU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164483>

On Tue, Jan 4, 2011 at 20:45, Alexander Gladysh <agladysh@gmail.com> wr=
ote:
> Nobody is interested?

Your problem set appears that you have a rather gnarly corner case
issue, arising from your custom build processes. Although git really
is amazing, I believe you may well be pushing git to its technological
limits.

So your problem could be quite hard to debug, whilst being distinctly
difficult to ascertain the root causes.

It also appears that your custom complicated build process is likely
protecting, or at least integral to, your high value corporate process
assets.

So _in this case_ you would be remiss to not find a suitable
consultant to provide professional and discreet assistance - perhaps
GitHub.com, as GitHub=92s Tender provides both public and _private_
support issue posting, and customized and private training if you and/
or your colleagues require; you might contact GitHub direct (
https://github.com/contact ) as their Support page does not link
directly to support contract information; oh, and GitHub supports a
lot of community projects too: their support for our community ought
be supported.

<disclaimer> I am _not_ affiliated with GitHub, I do work full time
with a human rights association in Australia.

Good luck
Zenaan


> Is there a way I can get some help with this issue?
>
> Thanks,
> Alexander.
>
> On Mon, Dec 27, 2010 at 11:49, Alexander Gladysh <agladysh@gmail.com>=
 wrote:
>> Hi, list!
>>
>> I wrote about the related issue earlier:
>>
>> http://lists-archives.org/git/731516-false-positives-from-git-diff-i=
ndex-when-used-with-git-dir.html
>>
>> Now I've got a case when I can reproduce this problem each time I tr=
y to.
>>
>> Unfortunately I can not share it or create a minimal example =97 the
>> case is triggered by a custom complicated automated build process on=
 a
>> private repository.
=2E..
