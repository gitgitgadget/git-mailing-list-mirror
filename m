From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Re*: AW: Getting the full path of a conflicting file within a
 custom merge driver?
Date: Fri, 5 Jun 2015 10:38:19 +0200
Message-ID: <CAP8UFD1DcSB+679KHngYP5g6wPzsM3CtmHAC9-XZkFCiG0ZTaw@mail.gmail.com>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
	<xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
	<xmqq4mmq3sug.fsf@gitster.dls.corp.google.com>
	<xmqqvbf3t98b.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468839F73@DWPWHMS531.dwpbank.local>
	<CAP8UFD0cJoh2YrxD-Cjr-r37SGDOcy=VafETAN4suxS0HVa6sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek, Andreas" <Andreas.Gondek@dwpbank.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 10:38:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0n9E-0007dc-CX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 10:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbbFEIi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 04:38:29 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:34229 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052AbbFEIiU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 04:38:20 -0400
Received: by wgv5 with SMTP id 5so51171096wgv.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 01:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mHqD0YOxVZ5GIhzQkyrm9Ho9vlwxSye0GSp/hND3amI=;
        b=KMY5dquijGCfBCvaE/xjtv+4+UBQr7jlPbsBwgtBVUVvWQB6jdhc/rCS/VJsAuw7EB
         Wmxsf1Qjgq/kgYmZHLkJhqHcYwYrZVadbdL+FrvZlUawrPny0W4ONX6+9lIZWqECiFB9
         DT5MQNSj/1xVNii8dJQcXEZaIRtF3Q7vic6v7uFIUdWMlgZY3byOMZJzm8ebfTih5FXU
         stMxYVK/n2+We1JYnpTxn/r+wHEJgw/FVe+w4MGJr2LAATShU/w3Qyrt3KUcNXo+Zf/E
         6aPzASlfMFdNeJZ0Zae3w8bW6dllxyji9eGmPrK5klLo6Gi+9h5D+KyxRjh9pL2jQtJQ
         bjqQ==
X-Received: by 10.180.105.38 with SMTP id gj6mr15575467wib.90.1433493499735;
 Fri, 05 Jun 2015 01:38:19 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Fri, 5 Jun 2015 01:38:19 -0700 (PDT)
In-Reply-To: <CAP8UFD0cJoh2YrxD-Cjr-r37SGDOcy=VafETAN4suxS0HVa6sA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270818>

On Fri, Jun 5, 2015 at 10:07 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Jun 5, 2015 at 7:56 AM, Gondek, Andreas
> <Andreas.Gondek@dwpbank.de> wrote:
>> Thanks, thanks, thanks.
>>
>> One last question. If I don't want to compile Git myself, how long may the pu branch take approx. to get into a next release?
>
> According to:
>
> https://github.com/git/git/blob/master/Documentation/howto/maintain-git.txt
>
> "One release cycle for a feature release is expected to last for eight
> to ten weeks."

Actually I should have read the next lines that say:

"- Maintenance releases are numbered as vX.Y.Z and are meant to
contain only bugfixes for the corresponding vX.Y.0 feature release and
earlier maintenance releases vX.Y.W (W < Z)."

> As v2.4.2 was tagged on May 26, the next feature release should be in
> 6 to 9 weeks, and will hopefully include the feature you are
> interested in.

The last feature release was v2.4.0 that was tagged on April 30, so
the next one should be in 3 to 5 weeks.
