From: John Tapsell <johnflux@gmail.com>
Subject: Re: Reverting a specific commit
Date: Thu, 23 Sep 2010 08:17:34 +0100
Message-ID: <AANLkTikB2A99zXvp8kyajkT63y3HuPMKyTgDg+HJUCLN@mail.gmail.com>
References: <1285226023268-5561992.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: milindkanchan <milindkanchan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 09:17:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oyg3o-0004Lb-GI
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 09:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526Ab0IWHRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 03:17:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59354 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0IWHRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 03:17:35 -0400
Received: by gyd8 with SMTP id 8so456020gyd.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=mvWfrWbMq3EcJwgEx8UoSyxLXGHeAHnjkeWuXw9f6V8=;
        b=RhIoD4dYOXlB4jSzdH8WGY+WSF/UzlChjk5qZR+HByttqy/+LlmNskJuP16kNnEuc1
         nJ2DovLtGqDqDRUd5HTiCOthK0Vu2s1+bYlUYs0cgZScUWX/d03wgNyaCIHtF5gMmZ5w
         iKUDU2pHzjhURZcvhN2g01xrCxzTaW1n439Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=UuDUXjMNjmSnk1EP0hscJYYcUNTDMJpFg4plIEduDTnjOG5vPvMB/q3ndrkkU7l3Yd
         CbdJ/h1XYYdQYy5E9ZCUIJxEw1xXKWjE4720XNnsjCwiY164hcdRpScGg5fgkb0YIYwq
         K8iimRac3Z1KBtTHe09FMfyzDGNBWFJ1PG2oQ=
Received: by 10.150.59.19 with SMTP id h19mr2203836yba.389.1285226254313; Thu,
 23 Sep 2010 00:17:34 -0700 (PDT)
Received: by 10.42.0.196 with HTTP; Thu, 23 Sep 2010 00:17:34 -0700 (PDT)
In-Reply-To: <1285226023268-5561992.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156855>

On 23 September 2010 08:13, milindkanchan <milindkanchan@gmail.com> wrote:
>
> Hi All,
>
> I am using git for code management.
>
> I have some query regarding reverting the commit in git.
>
> Can we revert a specific commit in git ?

To make a new commit to undo a bad commit:

git revert SHA

where SHA is that long string of numbers and letters associated with
each commit.  do "git log" to find out what the SHA is.

John
