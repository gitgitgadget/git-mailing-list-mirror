From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Operations on unborn branch
Date: Fri, 30 Nov 2012 08:39:35 -0800
Message-ID: <CANiSa6hpztn4gRX+-azuiD2+jrMUcCteqzeXkSdDudsEfz54Mg@mail.gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
	<7vd2yyn685.fsf@alter.siamese.dyndns.org>
	<CANiSa6g2UQyvOWS+nuc6y=wzfFTVJ6G8OK14KOs5DJ3f-n5vOw@mail.gmail.com>
	<7vd2yyi4l1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 17:39:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeTd2-0000A8-Jd
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 17:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933327Ab2K3Qjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 11:39:37 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64595 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932472Ab2K3Qjg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 11:39:36 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so339107qcr.19
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 08:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yOPg44sG1Q61AzOtyvxXfdT+tkZWC3LR0Hn64hro2OE=;
        b=ZtQMhqWBXGsoPzWp6/C3y9X7dP/o9qZiM/hRWOe+QDRpKU6C4ED0u0RCAHAum0kkZM
         ih5yNYqpyQrzAVgZGir0Uz3bG0LKpdk7/+S+hrP7+4lBszBjqBZS8w9EBU5DVJ41ARbb
         ydVbg/P2MB6TauqIYs7Qm7+8uLGh1rDunmd7oA2V4mNoUppCLg5uUD0xvzS7/mw9FCrO
         WGDYqISbcLrMKDSkIPp/98HgrIAFGvTlAYBEhMk/n2iet0rlU8lIkzJbpWTF6FTPgI8y
         XEr6eg/mLwB02wBTCPykK6I2knU7cC3+8EGT8yqrCHTSDB0lXYW5QHTOgZC5g3EIK0M7
         TOOQ==
Received: by 10.224.176.138 with SMTP id be10mr3899175qab.50.1354293576075;
 Fri, 30 Nov 2012 08:39:36 -0800 (PST)
Received: by 10.49.2.195 with HTTP; Fri, 30 Nov 2012 08:39:35 -0800 (PST)
In-Reply-To: <7vd2yyi4l1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210928>

On Tue, Nov 27, 2012 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> You have to special case the edges whichever way you go.  [...]

If I understand you correctly, you're saying that revision walking
would need a different special case. This is the most obvious
difference, it seems. "git show" would also need different
special-casing. But rebase wouldn't need --root, diff-tree wouldn't
need --root, any operations on an unborn branch would just work (incl
reset, cherry-pick).

Again, this is hypothetical, so I'll stop the complaining now :-)
