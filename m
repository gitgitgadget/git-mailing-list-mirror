From: Rodrigo Fernandes <rtfrodrigo@gmail.com>
Subject: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 11:29:11 +0100
Message-ID: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 29 12:30:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpxau-0006rs-GG
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 12:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210AbaE2K3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 06:29:52 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:35667 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756934AbaE2K3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 06:29:52 -0400
Received: by mail-yh0-f43.google.com with SMTP id v1so82153yhn.16
        for <git@vger.kernel.org>; Thu, 29 May 2014 03:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=uFEUZ3TKe2xnSjWm5dZFuS5reDmKLi1i6sl8E9GrPhI=;
        b=v3eDb6dEDOy1XfmIvvNvQ0Krge03HuquSfnrOn0/f0fGeKHcoqvr2nqxePILsIeKSW
         EgeVAvozqe1cHtb5fy+/VKOxk/01vPlnKqZ6syGwddyNT/gBBQ36ZqQZ9Uf94Xh2hJin
         JsBrH/NhpBKd+/QYeJZtUSlBMqVEzXFPkZh0Zxie9g4Je/G7fDenVecWjUv7KMvFXzYf
         xkbFHrQZyabem1WhP7lOI4zw+QtxUEV0lfyBKO8kn/+MkWz9LFqX2459sjpXU/YzoU0t
         Y2KbuE5KIqyqY6WBM6eg4kFBjw1NoXRVzDVJ+T6mWVRU+DCQARwR1RTg5pYbz1EtyJ7r
         q9fg==
X-Received: by 10.236.56.41 with SMTP id l29mr8950115yhc.13.1401359391552;
 Thu, 29 May 2014 03:29:51 -0700 (PDT)
Received: by 10.170.51.136 with HTTP; Thu, 29 May 2014 03:29:11 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250354>

Hi,

I'm having some problems with the `git log` command.

Setup:
Happens in multiple versions, tested on 1.8.* and 2.*

The problem happens when I try to get a pretty log for a commit with a
wrong date.

Executing the command:
`git log --encoding=UTF-8 --date=raw --pretty=format:'%H,%P,%ad,%cd,%an,%s'`

I get an empty response on the date field, but since pretty has `%ad`
it should follow the --date and return the date even if wrong.

The problem happens in this repo:
`https://github.com/SamWM/jQuery-Plugins` on commit
`e9dddaf24c9de45d9b4efdf38eff7c30eb200f48`.

I posted it on SO too:
`http://stackoverflow.com/questions/23793188/find-date-for-not-dated-commit`

I think it is a bug probably on pretty since other raw formats show
the date as it should.

I tried to check the source code but have no idea where to start,
maybe if you point me on some direction I can take a look for my self.

Can you help?

Kind regards,
Rodrigo Fernandes
