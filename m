From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: Git prompt
Date: Sun, 10 Feb 2013 16:54:36 -0500
Message-ID: <CAE_TNin6oAt7DkXH-iUNFHoeXhoJnJ_rSvEy=w=QPTB8F0tsLw@mail.gmail.com>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 22:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4erp-0005jt-HN
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756810Ab3BJVy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:54:58 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:44949 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756415Ab3BJVy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:54:57 -0500
Received: by mail-qa0-f43.google.com with SMTP id dx4so959377qab.2
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 13:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=CmPDqTSjaV7mZ5lbQDqWTf2EClBNYR+JzprjUeTqwTI=;
        b=vCcEYmC5JnPri/eS8misMZudibVksNk5FbiaebmeWYefO3kJvBjVtpG8YVuL8SBAeQ
         FhD/GHQmlw4JvgfBTWW1/xEtY4h5wr9a+3WLN9LqQ+wCbRqsu1PByN41KsSu9hft7rKW
         LJGb5qhH+fUZZMTJ+krcwTA7IkGu6jN/oVoBSKWeu7bbosAbDH7QhgD9e32fEF6YHCAv
         gpNUvTXCOVEN7qHStGsSsf/mQzg2Ck67ms3qp+5sctzmVvhG3138ip3VJGr/uXs0aPA7
         HU9qonIpcQ9kzitNU77tg8qsYS99iA5DfHyfFGBf15xdQmpuytGyyRXWmSbrpkxV7Byi
         3VGA==
X-Received: by 10.49.84.104 with SMTP id x8mr5416600qey.5.1360533296788; Sun,
 10 Feb 2013 13:54:56 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 13:54:36 -0800 (PST)
In-Reply-To: <20130210212538.GA11720@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215942>

That would be perfect. (And I did mean I set the login shell to
git-prompt. Additionally, the git user does not have permissions to
run any other shell.) However, when I remove the git-shell-commands
directory I get (on the local end):

fatal: Interactive git shell is not enabled.
hint: ~/git-shell-commands should exist and have read and execute access.

If no one with more experience has the time to look into your
suggestion, I will try.

Thanks,
Ethan

On Sun, Feb 10, 2013 at 4:25 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ethan Reesor wrote:
>
>> I have a git user set up on my server. It's prompt is set to
>> git-prompt and it's git-shell-commands is empty.
> [...]
>> How do I make the git user work like github where, upon attempting to
>> get a prompt, the connection is closed?
>
> I assume you mean that the user's login shell is git-shell.
>
> You can disable interactive logins by removing the
> ~/git-shell-commands/ directory.  Unfortunately that doesn't let you
> customize the message.  Perhaps it would make sense to teach shell.c
> to look for a
>
>         [shell]
>                 greeting = 'Hi %(username)! You've successfully authenticated, but I do not provide interactive shell access.'
>
> setting in git's config file.  What do you think?
>
> Thanks,
> Jonathan



--
Ethan Reesor (Gmail)
