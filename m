From: Strainu <strainu10@gmail.com>
Subject: Re: BUG: [Cosmetic] Commiting a gerrit ChangeId before the commit
 hook was installed
Date: Fri, 17 Jan 2014 23:10:27 +0200
Message-ID: <CAC9meR+78_EvoqHNcuPyDKOZDjSsUngziGDa2aV1QDtOb8eOXw@mail.gmail.com>
References: <CAC9meRKiR+60YaGiuCu4twEt6dyWksEjHSH8YPTEvmD=LoB=aw@mail.gmail.com>
 <20140117204132.GB18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, openstack-infra@lists.openstack.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 17 22:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Gh7-0007HG-J0
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 22:11:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbaAQVLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 16:11:09 -0500
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51580 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbaAQVLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 16:11:08 -0500
Received: by mail-pd0-f169.google.com with SMTP id v10so4486552pde.28
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 13:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=54hPggutn19hVUOe1hJqSIQkz8hrqfMtc2O7l5Yf8K4=;
        b=YpEtCD1Gqmho6QKxng6Gr3JS/yA25sG76BgA/6Yt43OInQNWGg6Xwya/euYZPEzCsp
         YK4D7Qc9E9dmBZ34pCZAjet6W2YipAyVOl+24z8fDiFB0U5WWnl8KNUKd3DqijWC69TH
         LtVyYb+bp71/yosOdNmABsF8190b0mOg6oIlu5YMVr/I6IYhPrltR2F8E9FLxG2IgGXO
         rAobt6qoy/DWXZyUksVqWun9QosNQjuTXMJDRJ5fAVLSamiVOfcZsrClk1oiVzQNtuIu
         MIJIbBsrmZP+U1Okn2mv5Wc5XvrlR+wX9SP9kUjD5vWOXcKe4PW7iOYPkrVs8czcIDkv
         Piqw==
X-Received: by 10.68.204.161 with SMTP id kz1mr4579232pbc.156.1389993068056;
 Fri, 17 Jan 2014 13:11:08 -0800 (PST)
Received: by 10.68.175.225 with HTTP; Fri, 17 Jan 2014 13:10:27 -0800 (PST)
In-Reply-To: <20140117204132.GB18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240632>

2014/1/17 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> Strainu wrote:
>
>> strainu@emily:~/core> git review -f
>> Creating a git remote called "gerrit" that maps to:
>>         ssh://strainu@gerrit.wikimedia.org:29418/pywikibot/core.git
>> Your change was committed before the commit hook was installed.
>> Amending the commit to add a gerrit change id.
>>
>> At this point I ended the transaction, as I was confused by the last
>> message: I was afraid the ChangeId would have changed, causing the
>> patch to be attached to another review.
>>
>> I think git should not show this message if the change description
>> already has a change id
>
> This message doesn't come from git.  It comes from the git-review
> tool (in git_review/cmd.py), so cc-ing the authors in case they
> have thoughts on that.

Thanks for clarifying that. I'll log a bug on launchpad then.

Strainu
