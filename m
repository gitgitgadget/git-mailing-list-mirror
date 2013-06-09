From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 22:42:41 +0530
Message-ID: <CALkWK0=CW+tTRy0oPFCQpV6a0VnWQb6SUKtSPaj+4JoeG+J6uw@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan> <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
 <20130609160225.GB22905@serenity.lan> <CAMP44s0Zsejk4Ex6QfzOFOom3cyWv_hziWGkAK-LawSUkT9V3Q@mail.gmail.com>
 <20130609164248.GD22905@serenity.lan> <CALkWK0k=39-Cq3vNdrpLPTWa0wgkqLM=7c=cAmL0nvx0MT5mkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:13:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljBH-0000Rz-Rk
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994Ab3FIRNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:13:23 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:41712 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab3FIRNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:13:23 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so6033815ieb.38
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VgZVsndQUdeEzCuzQH4E7qF6/2QYP7XHsRnS2HZU7a0=;
        b=CZ7+TDeFQYWLxH5EHrZQWr0EmQVkPdUTx3vlzZaUY8AqAnQARuk+TxqsS6mUNR3Xhf
         CBgMMj+KNKrfZKSOW5JpToAwOBtDjHwcW2tJ3OVkHbWatIkuxjWuJnxBNRZ/nBAg2E/N
         0B8po6uKq4O7D2YGxZEg3ukB386dfMaw63q3SIPm8FzYj7r04ZgutDg5fGclsO0TFg0Y
         ES4IFACbWdXj+qWAT9Ks0w0NnvkGaDl7wRx66edN0ZzuIvMYPW1vE1JzvbpnCwxqCT5S
         PEpv/2PDv4beiD+BtoC+0nIKrgfNhbNzxaxBc4MC86Gb0C1tk1Pi1B0oIMWOkN015UOa
         Mwrw==
X-Received: by 10.50.3.37 with SMTP id 5mr2613423igz.0.1370798002758; Sun, 09
 Jun 2013 10:13:22 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 10:12:41 -0700 (PDT)
In-Reply-To: <CALkWK0k=39-Cq3vNdrpLPTWa0wgkqLM=7c=cAmL0nvx0MT5mkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227025>

Ramkumar Ramachandra wrote:
> So libgit.a is a collection of everything that is shared between
> builtins?

That is not to say that we shouldn't share things between builtins.
We can do it in builtin/lib.a, as Felipe has demonstrated here [1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/226975
