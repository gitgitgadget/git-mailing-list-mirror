From: Brian Cardarella <brian@dockyard.com>
Subject: Re: Pushing to a remote repo from a remote repo?
Date: Sat, 14 Apr 2012 19:16:36 -0400
Message-ID: <CAAnwhhXPs0+GPExMu8TP0jbctMamg6FZW2ndcQMJbtqGetfyZw@mail.gmail.com>
References: <CAAnwhhWTcfOi+qqXPnGNXSKHbFh5L=+6eSKaaex5mq6VTwSxEw@mail.gmail.com>
	<1334444541.7825.1.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sun Apr 15 01:16:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJCD0-0006fx-Ss
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 01:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab2DNXQj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 19:16:39 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:43222 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754925Ab2DNXQi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 19:16:38 -0400
Received: by lahj13 with SMTP id j13so3167348lah.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 16:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=f9bNCiX43W0O+8xVoyvmhKO5Bx91mAFyLY85JxSeBY4=;
        b=pAWWFjUCKPe6Qvvh17jriR6Lcy2/uXc+iQgi9rvskL9Dq72lyCK20rTb9i5A87+URM
         qh59Yf/pfUjQOwl88poSZ1oTfa1Tlt9F9irItFa8H8+s1NzlJsCxCkG5CYwoD1Ku30/Z
         L9Blu4tdOL5ihW7w4exJoAGe8w5yWXKSEH5wQ2sB7Q3hWQsIlaZ4Ms1Rll6+EWXg9PZx
         RZFq7RFeqjCex1FVnp3L7IrSLkVW5zdkGoEztgxxkSb1gl75EbOKd8O/aIWPePWa+m+d
         xBl4mnhKroJG1UGQSxSDv+ydK6awCZFbCrB7T7mo097zeKi+r8w/wYMeGE8iW4ArQkYS
         rP+Q==
Received: by 10.152.132.166 with SMTP id ov6mr6298725lab.35.1334445396847;
 Sat, 14 Apr 2012 16:16:36 -0700 (PDT)
Received: by 10.112.102.197 with HTTP; Sat, 14 Apr 2012 16:16:36 -0700 (PDT)
X-Originating-IP: [108.49.61.94]
In-Reply-To: <1334444541.7825.1.camel@beez.lab.cmartin.tk>
X-Gm-Message-State: ALoCoQn3G7KiQ/TWxUWlRDk+C0TnSfz1J28ze62vs1mn7u/N4yxyKyH7k/s1i2CEm2gjYCITi4We
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195532>

Yes, I assumed the bits need to come through my system. I want to
avoid cloning, pushing, then removing the repo. But it seems that is
not possible. Thank you.

- Brian

On Sat, Apr 14, 2012 at 7:02 PM, Carlos Mart=EDn Nieto <cmn@elego.de> w=
rote:
> On Sat, 2012-04-14 at 18:08 -0400, Brian Cardarella wrote:
>> So I have a destination repo that is remote. And I have a source rep=
o
>> that is also remote. I would like my local machine to act as a proxy
>> to allow me to push to the destination from the source without ever
>> download the repo to my machine. Is this possible?
>
> Using your computer as a proxy and avoiding downloading the informati=
on
> to your computer are mutually exclusive goals.
>
> At any rate, git doesn't support this kind of operation. If you want =
to
> move data from A to B, you need to push from A or fetch from B (or fe=
tch
> from A to C and then push from C to A).
>
> =A0 cmn
>
